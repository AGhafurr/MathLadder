import { createClient } from "@supabase/supabase-js";

export const supabase = createClient(
    "https://eskwxcxzwbacotezhxtk.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVza3d4Y3h6d2JhY290ZXpoeHRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNTQwNTcsImV4cCI6MjAxODYzMDA1N30.qT33GlY4ZmXN9MTDvXQeBYgnTABGUSuCdBNqbOsLUao"
);
