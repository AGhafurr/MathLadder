import formidable from "formidable";
import { supabase } from "../databases/supabase.js";

export const me = async (req, res) => {
    const { id } = req.body;

    const { data, error } = await supabase.from("users").select("*, points(*)").eq("id", id);

    if (error) {
        res.json(error);

        return;
    }

    res.json(data);
};

export const updateProfilePicture = (req, res) => {
    const form = formidable({});

    form.parse(req, async (err, fields, files) => {
        if (err) {
            res.json(err);

            return;
        }

        const id = fields.id[0];
        const file = files.profile_picture[0];
        const { data, error } = await supabase.storage.from("profile-pictures").upload(`${id}.jpg`, file, {
            cacheControl: "3600",
            upsert: false,
            contentType: "image/jpeg",
        });

        if (error) {
            res.json(error);

            return;
        }

        res.json(data);
    });
};
