import { supabase } from "../databases/supabase.js";

export const signUp = async (req, res) => {
    const { username, email, password } = req.body;

    const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
        email: email,
        password: password,
    });

    if (signUpError) {
        res.json(signUpError);

        return;
    }

    const { error: insertUserError } = await supabase.from("users").insert({
        id: signUpData.user.id,
        username: username,
        email: email,
    });

    if (insertUserError) {
        res.json(insertUserError);

        return;
    }

    const { error: insertPointError } = await supabase.from("points").insert({
        id: signUpData.user.id,
    });

    if (insertPointError) {
        res.json(insertPointError);

        return;
    }

    res.json(signUpData);
};

export const signIn = async (req, res) => {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signInWithPassword({
        email: email,
        password: password,
    });

    if (error) {
        res.json(error);

        return;
    }

    res.json(data);
};

export const signOut = async (req, res) => {
    const { error } = await supabase.auth.signOut({ scope: "local" });

    if (error) {
        res.json(error);

        return;
    }

    res.end();
};
