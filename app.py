import matplotlib.pyplot as plt
import pandas as pd
import streamlit as st


# Load the housing data
@st.cache
def load_data():
    data = pd.read_csv("housing.csv")
    return data


data = load_data()

# Set the title of the web app
st.title("Housing Statistics Dashboard")

# Show the raw data
if st.checkbox("Show raw data"):
    st.write(data)

# Display statistics
if st.button("Show Statistics"):
    st.write(data.describe())

# Display histograms
if st.checkbox("Show Distribution Plot"):
    # Select column to plot
    column = st.selectbox("Which column do you want to plot?", data.columns)
    # Plot the histogram
    fig, ax = plt.subplots()
    data[column].hist(ax=ax)
    st.pyplot(fig)

# Run the Streamlit app with `streamlit run app.py` from your terminal
