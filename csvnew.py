import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv('btlsheet.csv')
print(df.columns)


x = df['dT avg'].dropna()

mean = np.mean(x)
std = np.std(x)

bins = np.linspace(19,21, 20)

plt.hist(x, bins, alpha=0.6, color='skyblue', edgecolor='black')

print (mean, std)

textstr = f"Mean = {mean:.2f}\nStd = {std:.2f}"

plt.text(0.05, 0.95, f"Mean = {mean:.2f}\nStd = {std:.2f}",
         transform=plt.gca().transAxes,
         fontsize=12, verticalalignment='top', horizontalalignment='left',
         bbox=dict(boxstyle='round,pad=0.3', facecolor='white', alpha=0.7))


plt.xlabel('Average dT (in celsius)')
plt.title("DM 3221")
plt.show()
plt.savefig("hist_dTavg.png", dpi=300)
print("Saved plot as hist_dTavg.png")

