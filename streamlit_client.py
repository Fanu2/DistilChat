
import streamlit as st
import requests

st.title("Chat with Local GPT-2 Bot")

persona = st.selectbox("Choose persona", ["default", "poetic", "funny"])
prompt = st.text_area("Your message:")

if st.button("Send"):
    resp = requests.post(
        "http://127.0.0.1:8000/chat",
        json={"prompt": prompt, "persona": persona}
    )
    if resp.status_code == 200:
        st.write(f"**Bot:** {resp.json()['response']}")
    else:
        st.error("Error communicating with API")
