import { supabase } from "../databases/supabase.js";

export const leaderBoard = async (req, res) => {
    const { data, error } = await supabase
        .from("points")
        .select("*, users(profile_picture_url, username)")
        .order("point", { ascending: false });

    if (error) {
        res.json(error);

        return;
    }

    res.json(data);
};

export const updatePoint = async (req, res) => {
    const { id, point } = req.body;

    const { data, error } = await supabase.from("points").update({ point: point }).eq("id", id).select();

    if (error) {
        res.json(error);

        return;
    }

    res.json(data);
};
