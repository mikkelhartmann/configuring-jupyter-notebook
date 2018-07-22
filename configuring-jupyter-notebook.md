

```python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
```

<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"><li><span><a href="#Introduction" data-toc-modified-id="Introduction-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Introduction</a></span></li><li><span><a href="#Notebook-Extensions" data-toc-modified-id="Notebook-Extensions-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>Notebook Extensions</a></span></li><li><span><a href="#Custom-CSS-for-the-notebook" data-toc-modified-id="Custom-CSS-for-the-notebook-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>Custom CSS for the notebook</a></span></li><li><span><a href="#Creating-high-quality-inline-figures" data-toc-modified-id="Creating-high-quality-inline-figures-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>Creating high quality inline figures</a></span></li><li><span><a href="#Styling-Matplotlib-figures" data-toc-modified-id="Styling-Matplotlib-figures-5"><span class="toc-item-num">5&nbsp;&nbsp;</span>Styling Matplotlib figures</a></span></li><li><span><a href="#Styling-how-Pandas-print-cells" data-toc-modified-id="Styling-how-Pandas-print-cells-6"><span class="toc-item-num">6&nbsp;&nbsp;</span>Styling how Pandas print cells</a></span></li><li><span><a href="#Auto-reload-files" data-toc-modified-id="Auto-reload-files-7"><span class="toc-item-num">7&nbsp;&nbsp;</span>Auto reload files</a></span></li><li><span><a href="#Conclusion" data-toc-modified-id="Conclusion-8"><span class="toc-item-num">8&nbsp;&nbsp;</span>Conclusion</a></span></li><li><span><a href="#References" data-toc-modified-id="References-9"><span class="toc-item-num">9&nbsp;&nbsp;</span>References</a></span></li></ul></div>

# Introduction
In this notebook I will go through how I have set up the styling and extensions for my Jupyter Notebooks. It should generally improve readability and quality-of-life for the Notebook user. The notebooks will describe the contents of the following files:
1. A `nbextension.config` file which contains a list of all the Notebook Extensions I use. The extension could be enabled using the extension manager, but I lake having it scripted.
1. A  file which contains the default setting for how figures are shown in the notebook. It's called `ipython_config.py` and should be placed in `~/.ipython/profile_default/`. I use it to increase the quality of the figures. 
1. A file that includes the CSS used to render the notebook. It is called  `custom.css` and should be placed in `~/.jupyter/custom/custom.css`. I use this file to set the width and alignment of the different kinds of cells.
1. A file that that changes the default parameters for matplotlib.pyplot. I have called it `my_mpl_style.mplstyle` and it should be placed in  `~/.connfig/matplotlib/stylelib/`  

Together these file form my customization of my Jupyter notebooks.

# Notebook Extensions
I use the following extensions
1. **ExecuteTime** -- This puts the runtime as well as a timestamp at the end of every cell that has been executed.
1. **autoreload** -- Allows me to have some module automatically reload. Handy when you can to keep some of your function outside the notebook, but still have the convenience of quick editing.
1. **Hinterland** -- Enable code autocompletion menu for every keypress in a code cell, instead of only enabling it with tab.
1. **Highlight selected word** -- As the name suggests it highlights all occurrences of the selected word.
1. **Table of content** -- This allows me include a table of content in the notebook.

I use virtual environments extensively, and I don't want to have to enable these notebook extensions manually each time I start a new project. Can I include these in a config file and simply load that? Luckily the answer is yes.

For example, if we want to install ExecuteTime, we can write.
```bash
jupyter nbextension enable execute_time/ExecuteTime
```

I keep all my preferred notebook extension in `nbextension.config` file and then I use a bash script to enable the extensions.

I have created a shell script that enables all the extensions described in `nbextension.config`, so I can enable every simply by running `sh install_nbextensions.sh`.

# Custom CSS for the notebook
I love Jupyter Notebook, but there are some things about the default styling of the cells that I don't like, e.g. the figures are left-centered and the text fields are too wide. So I was quite happy to learn that Jupyter will use the following file if it exists: `~/.jupyter/custom/custom.css`.

    % The cell was generated using: "%load /Users/hartmann/.jupyter/custom/custom.css" 
```css
@import url("https://fonts.googleapis.com/css?family=Muli");

body {
  font-family: "Muli", sans-serif;
}

img {
  display: block;
  margin: auto;
}

div.output_area .rendered_html img {
  margin-left: auto;
  margin-right: auto;
}

h1 {
  text-align: left;
}

h2 {
  text-align: left;
}

h3 {
  text-align: left;
}

canvas {
  display: block;
  margin: auto;
}

.container {
  width: 50% !important;
  min-width: 750px;
}

div.cell.selected {
  border-left-width: 1px !important;
}

div.text_cell_render {
  width: 70%;
  text-align: justify;
  margin: 0 auto;
}

div.output_scroll {
  resize: vertical !important;
}

/* Remove the toolbar that result from using  matplotlib notebook magic*/
.output_wrapper button.btn.btn-default,
.output_wrapper .ui-dialog-titlebar {
  display: none;
}
```

# Creating high quality inline figures

I often save figures by drag-and-drop rather than running `fig.savefig()`. However, if you do that you will not get the benefits of the 

One can change the default setting for iPython. Running `ipython profile create` one can creates the file `~/.ipython/profile_default/ipython_config.py` that contains all the configs, see [this](https://gist.github.com/minrk/3301035). By adding `c.InlineBackend.figure_format = 'retina'` to the file, the resolution of the inline figures is improved greatly. This also means that the figures will have the same resolution if you save them by dragging.


# Styling Matplotlib figures
Below I define a function that creates a figure and returns the figure object so I can save the figure. I want to be able to compare the figures as I change the styling.


```python
n_curves = 4
random_data = np.random.rand(100,n_curves)
sorted_data = [sorted(random_data[:,i]) for i in range(n_curves)]
def create_figure(sorted_data, fig_name):
    fig, ax = plt.subplots()
    for y in sorted_data: 
        ax.plot(y, label='label');
    ax.set_title("Title")
    ax.set_xlabel('X Label')
    ax.set_ylabel('Y Label')
    ax.legend()
    fig.tight_layout()
    fig.savefig('figs/'+fig_name)
    return fig
```

First I create the plain figure using the default styling that comes with MatplotLib.


```python
fig = create_figure(sorted_data, 'plain')
```


![png](configuring-jupyter-notebook_files/configuring-jupyter-notebook_11_0.png)


We want out figures to have a print quality, so we will set the figure format to retina. This should make the figure look a lot sharper.

We can alter the default parameters used by matplotlib by changing the values in the `plt.rcParams` dictionary.

Lets have a look at the five first keys in the dictionary:


```python
[key for key in plt.rcParams.keys()][:5]
```




    ['_internal.classic_mode',
     'agg.path.chunksize',
     'animation.avconv_args',
     'animation.avconv_path',
     'animation.bitrate']



Below I will change some of the styling:


```python
# %load matplotlib_config.py
plt.rcParams['savefig.dpi'] = 200
plt.rcParams['figure.autolayout'] = False
plt.rcParams['figure.figsize'] = 7, 4
plt.rcParams['axes.labelsize'] = 12
plt.rcParams['axes.titlesize'] = 14
plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['ytick.labelsize'] = 12
plt.rcParams['font.size'] = 16
plt.rcParams['lines.linewidth'] = 2.0
plt.rcParams['lines.markersize'] = 8
plt.rcParams['legend.fontsize'] = 14
plt.rcParams['text.usetex'] = False
```

Lets plot the figure again now that the defaults have ben changed.


```python
fig = create_figure(sorted_data, 'new_default_parameters')
```


![png](configuring-jupyter-notebook_files/configuring-jupyter-notebook_18_0.png)


Instead of including all the code above in every notebook one can write a style sheets as explained [here](https://matplotlib.org/users/style_sheets.html). I keep my own custom style sheet as a Python Module on GitHub so I can install it using `pip`. However, the direct manipulation shown above is extremely useful when developing your custom styling.

Lets see an example of a plot that uses the custom style defined in `my_mpl_style.mplstyle`. It should be placed in `~/.connfig/matplotlib/stylelib/`.


```python
plt.style.use('my_mpl_style.mplstyle')
```


```python
fig = create_figure(sorted_data, 'using_mpl_style')
```


![png](configuring-jupyter-notebook_files/configuring-jupyter-notebook_21_0.png)


# Styling how Pandas print cells


```python
df = pd.DataFrame(np.random.rand(100,10))
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.332559</td>
      <td>0.817335</td>
      <td>0.408790</td>
      <td>0.883417</td>
      <td>0.925760</td>
      <td>0.491475</td>
      <td>0.332996</td>
      <td>0.245097</td>
      <td>0.955079</td>
      <td>0.683596</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.506777</td>
      <td>0.326121</td>
      <td>0.581329</td>
      <td>0.967265</td>
      <td>0.774262</td>
      <td>0.035652</td>
      <td>0.392939</td>
      <td>0.497094</td>
      <td>0.488386</td>
      <td>0.172741</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.124318</td>
      <td>0.845284</td>
      <td>0.973494</td>
      <td>0.552595</td>
      <td>0.225346</td>
      <td>0.948348</td>
      <td>0.177595</td>
      <td>0.222497</td>
      <td>0.690050</td>
      <td>0.847546</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.594137</td>
      <td>0.764081</td>
      <td>0.992046</td>
      <td>0.190661</td>
      <td>0.458834</td>
      <td>0.619343</td>
      <td>0.543222</td>
      <td>0.478462</td>
      <td>0.941433</td>
      <td>0.189839</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.389404</td>
      <td>0.707036</td>
      <td>0.410187</td>
      <td>0.473415</td>
      <td>0.152940</td>
      <td>0.225006</td>
      <td>0.459529</td>
      <td>0.886686</td>
      <td>0.774106</td>
      <td>0.256574</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.752569</td>
      <td>0.437070</td>
      <td>0.515809</td>
      <td>0.852868</td>
      <td>0.496751</td>
      <td>0.694558</td>
      <td>0.446531</td>
      <td>0.595130</td>
      <td>0.441311</td>
      <td>0.057544</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.743398</td>
      <td>0.742810</td>
      <td>0.336510</td>
      <td>0.021672</td>
      <td>0.154411</td>
      <td>0.571875</td>
      <td>0.679285</td>
      <td>0.013389</td>
      <td>0.267114</td>
      <td>0.947542</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.249761</td>
      <td>0.064544</td>
      <td>0.607377</td>
      <td>0.427276</td>
      <td>0.370251</td>
      <td>0.865870</td>
      <td>0.951798</td>
      <td>0.980376</td>
      <td>0.503680</td>
      <td>0.867869</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.929170</td>
      <td>0.407956</td>
      <td>0.641100</td>
      <td>0.808600</td>
      <td>0.679924</td>
      <td>0.952972</td>
      <td>0.765462</td>
      <td>0.035881</td>
      <td>0.499213</td>
      <td>0.365271</td>
    </tr>
    <tr>
      <th>9</th>
      <td>0.069586</td>
      <td>0.394798</td>
      <td>0.560635</td>
      <td>0.941417</td>
      <td>0.297765</td>
      <td>0.187606</td>
      <td>0.506170</td>
      <td>0.955814</td>
      <td>0.891632</td>
      <td>0.419866</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.827701</td>
      <td>0.718031</td>
      <td>0.170320</td>
      <td>0.168705</td>
      <td>0.313490</td>
      <td>0.595110</td>
      <td>0.436215</td>
      <td>0.057145</td>
      <td>0.976260</td>
      <td>0.534726</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.242130</td>
      <td>0.279837</td>
      <td>0.329979</td>
      <td>0.980450</td>
      <td>0.285774</td>
      <td>0.143720</td>
      <td>0.707582</td>
      <td>0.628614</td>
      <td>0.185452</td>
      <td>0.983469</td>
    </tr>
    <tr>
      <th>12</th>
      <td>0.964204</td>
      <td>0.840649</td>
      <td>0.519745</td>
      <td>0.439136</td>
      <td>0.191327</td>
      <td>0.255342</td>
      <td>0.161771</td>
      <td>0.258738</td>
      <td>0.821988</td>
      <td>0.089223</td>
    </tr>
    <tr>
      <th>13</th>
      <td>0.528773</td>
      <td>0.150766</td>
      <td>0.160997</td>
      <td>0.796449</td>
      <td>0.625050</td>
      <td>0.898132</td>
      <td>0.622695</td>
      <td>0.511752</td>
      <td>0.348881</td>
      <td>0.274251</td>
    </tr>
    <tr>
      <th>14</th>
      <td>0.554581</td>
      <td>0.772540</td>
      <td>0.501492</td>
      <td>0.890981</td>
      <td>0.363326</td>
      <td>0.232203</td>
      <td>0.339655</td>
      <td>0.512516</td>
      <td>0.812883</td>
      <td>0.813039</td>
    </tr>
    <tr>
      <th>15</th>
      <td>0.017119</td>
      <td>0.833591</td>
      <td>0.491231</td>
      <td>0.698028</td>
      <td>0.070933</td>
      <td>0.901884</td>
      <td>0.353139</td>
      <td>0.507318</td>
      <td>0.532148</td>
      <td>0.913510</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.303143</td>
      <td>0.720269</td>
      <td>0.836471</td>
      <td>0.172324</td>
      <td>0.777735</td>
      <td>0.675194</td>
      <td>0.459614</td>
      <td>0.965569</td>
      <td>0.589760</td>
      <td>0.267947</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.459640</td>
      <td>0.471618</td>
      <td>0.680691</td>
      <td>0.069857</td>
      <td>0.890254</td>
      <td>0.680691</td>
      <td>0.850862</td>
      <td>0.887371</td>
      <td>0.600478</td>
      <td>0.613436</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.807910</td>
      <td>0.004564</td>
      <td>0.310260</td>
      <td>0.577989</td>
      <td>0.697535</td>
      <td>0.402553</td>
      <td>0.612986</td>
      <td>0.152911</td>
      <td>0.186655</td>
      <td>0.711620</td>
    </tr>
    <tr>
      <th>19</th>
      <td>0.796835</td>
      <td>0.894753</td>
      <td>0.016744</td>
      <td>0.059018</td>
      <td>0.966855</td>
      <td>0.384143</td>
      <td>0.532837</td>
      <td>0.505691</td>
      <td>0.420396</td>
      <td>0.578264</td>
    </tr>
    <tr>
      <th>20</th>
      <td>0.467081</td>
      <td>0.153612</td>
      <td>0.280480</td>
      <td>0.298517</td>
      <td>0.259698</td>
      <td>0.260507</td>
      <td>0.747273</td>
      <td>0.879212</td>
      <td>0.815702</td>
      <td>0.030107</td>
    </tr>
    <tr>
      <th>21</th>
      <td>0.743701</td>
      <td>0.948741</td>
      <td>0.634907</td>
      <td>0.709664</td>
      <td>0.230629</td>
      <td>0.652195</td>
      <td>0.833835</td>
      <td>0.001210</td>
      <td>0.177989</td>
      <td>0.803404</td>
    </tr>
    <tr>
      <th>22</th>
      <td>0.105973</td>
      <td>0.162109</td>
      <td>0.685493</td>
      <td>0.092334</td>
      <td>0.530445</td>
      <td>0.773243</td>
      <td>0.992151</td>
      <td>0.761404</td>
      <td>0.273222</td>
      <td>0.339905</td>
    </tr>
    <tr>
      <th>23</th>
      <td>0.039874</td>
      <td>0.203370</td>
      <td>0.633356</td>
      <td>0.152678</td>
      <td>0.918532</td>
      <td>0.961898</td>
      <td>0.915903</td>
      <td>0.879231</td>
      <td>0.007396</td>
      <td>0.318876</td>
    </tr>
    <tr>
      <th>24</th>
      <td>0.038758</td>
      <td>0.131448</td>
      <td>0.731870</td>
      <td>0.858319</td>
      <td>0.388706</td>
      <td>0.817867</td>
      <td>0.367371</td>
      <td>0.275239</td>
      <td>0.928890</td>
      <td>0.935821</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0.842215</td>
      <td>0.557416</td>
      <td>0.037839</td>
      <td>0.713620</td>
      <td>0.039762</td>
      <td>0.331826</td>
      <td>0.416544</td>
      <td>0.323931</td>
      <td>0.635712</td>
      <td>0.241878</td>
    </tr>
    <tr>
      <th>26</th>
      <td>0.764447</td>
      <td>0.192502</td>
      <td>0.924932</td>
      <td>0.630741</td>
      <td>0.743219</td>
      <td>0.780681</td>
      <td>0.920846</td>
      <td>0.342242</td>
      <td>0.351829</td>
      <td>0.529702</td>
    </tr>
    <tr>
      <th>27</th>
      <td>0.905952</td>
      <td>0.124906</td>
      <td>0.531291</td>
      <td>0.571168</td>
      <td>0.778201</td>
      <td>0.177498</td>
      <td>0.354741</td>
      <td>0.950249</td>
      <td>0.653792</td>
      <td>0.715288</td>
    </tr>
    <tr>
      <th>28</th>
      <td>0.265424</td>
      <td>0.981468</td>
      <td>0.207388</td>
      <td>0.148392</td>
      <td>0.378744</td>
      <td>0.340396</td>
      <td>0.403250</td>
      <td>0.047198</td>
      <td>0.544206</td>
      <td>0.893234</td>
    </tr>
    <tr>
      <th>29</th>
      <td>0.418578</td>
      <td>0.438400</td>
      <td>0.953008</td>
      <td>0.338786</td>
      <td>0.224299</td>
      <td>0.715502</td>
      <td>0.854097</td>
      <td>0.623577</td>
      <td>0.458004</td>
      <td>0.803907</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>70</th>
      <td>0.785851</td>
      <td>0.625053</td>
      <td>0.572484</td>
      <td>0.344429</td>
      <td>0.465417</td>
      <td>0.851989</td>
      <td>0.055669</td>
      <td>0.101646</td>
      <td>0.970665</td>
      <td>0.023909</td>
    </tr>
    <tr>
      <th>71</th>
      <td>0.612778</td>
      <td>0.054991</td>
      <td>0.931069</td>
      <td>0.368668</td>
      <td>0.139984</td>
      <td>0.929182</td>
      <td>0.646530</td>
      <td>0.673750</td>
      <td>0.925752</td>
      <td>0.381135</td>
    </tr>
    <tr>
      <th>72</th>
      <td>0.525891</td>
      <td>0.243055</td>
      <td>0.833502</td>
      <td>0.175938</td>
      <td>0.566473</td>
      <td>0.955329</td>
      <td>0.547075</td>
      <td>0.138392</td>
      <td>0.932905</td>
      <td>0.638634</td>
    </tr>
    <tr>
      <th>73</th>
      <td>0.091340</td>
      <td>0.314255</td>
      <td>0.224582</td>
      <td>0.708030</td>
      <td>0.051977</td>
      <td>0.939406</td>
      <td>0.848416</td>
      <td>0.436854</td>
      <td>0.008277</td>
      <td>0.569559</td>
    </tr>
    <tr>
      <th>74</th>
      <td>0.784897</td>
      <td>0.883513</td>
      <td>0.368309</td>
      <td>0.487432</td>
      <td>0.482025</td>
      <td>0.278562</td>
      <td>0.769802</td>
      <td>0.655161</td>
      <td>0.390509</td>
      <td>0.937977</td>
    </tr>
    <tr>
      <th>75</th>
      <td>0.473963</td>
      <td>0.856605</td>
      <td>0.279710</td>
      <td>0.672958</td>
      <td>0.003968</td>
      <td>0.094930</td>
      <td>0.247854</td>
      <td>0.924776</td>
      <td>0.129369</td>
      <td>0.291227</td>
    </tr>
    <tr>
      <th>76</th>
      <td>0.703505</td>
      <td>0.478669</td>
      <td>0.812769</td>
      <td>0.307390</td>
      <td>0.122931</td>
      <td>0.824975</td>
      <td>0.073262</td>
      <td>0.784912</td>
      <td>0.015453</td>
      <td>0.201764</td>
    </tr>
    <tr>
      <th>77</th>
      <td>0.865534</td>
      <td>0.239719</td>
      <td>0.078379</td>
      <td>0.045903</td>
      <td>0.911878</td>
      <td>0.788672</td>
      <td>0.283483</td>
      <td>0.093282</td>
      <td>0.830255</td>
      <td>0.766615</td>
    </tr>
    <tr>
      <th>78</th>
      <td>0.423895</td>
      <td>0.592060</td>
      <td>0.992649</td>
      <td>0.265216</td>
      <td>0.928685</td>
      <td>0.819428</td>
      <td>0.982527</td>
      <td>0.448558</td>
      <td>0.103979</td>
      <td>0.791247</td>
    </tr>
    <tr>
      <th>79</th>
      <td>0.607598</td>
      <td>0.588940</td>
      <td>0.749097</td>
      <td>0.276011</td>
      <td>0.151373</td>
      <td>0.806061</td>
      <td>0.219677</td>
      <td>0.818870</td>
      <td>0.055326</td>
      <td>0.590411</td>
    </tr>
    <tr>
      <th>80</th>
      <td>0.833418</td>
      <td>0.689373</td>
      <td>0.301834</td>
      <td>0.085809</td>
      <td>0.549914</td>
      <td>0.548821</td>
      <td>0.933423</td>
      <td>0.411951</td>
      <td>0.963576</td>
      <td>0.157433</td>
    </tr>
    <tr>
      <th>81</th>
      <td>0.339780</td>
      <td>0.330240</td>
      <td>0.991863</td>
      <td>0.573516</td>
      <td>0.198036</td>
      <td>0.271417</td>
      <td>0.978376</td>
      <td>0.367005</td>
      <td>0.043040</td>
      <td>0.060756</td>
    </tr>
    <tr>
      <th>82</th>
      <td>0.699433</td>
      <td>0.860513</td>
      <td>0.875375</td>
      <td>0.146366</td>
      <td>0.896943</td>
      <td>0.829047</td>
      <td>0.380595</td>
      <td>0.939119</td>
      <td>0.841969</td>
      <td>0.414682</td>
    </tr>
    <tr>
      <th>83</th>
      <td>0.443156</td>
      <td>0.207281</td>
      <td>0.712977</td>
      <td>0.708367</td>
      <td>0.034060</td>
      <td>0.590776</td>
      <td>0.449715</td>
      <td>0.580867</td>
      <td>0.974195</td>
      <td>0.376413</td>
    </tr>
    <tr>
      <th>84</th>
      <td>0.372621</td>
      <td>0.222289</td>
      <td>0.967124</td>
      <td>0.716900</td>
      <td>0.203352</td>
      <td>0.269697</td>
      <td>0.875133</td>
      <td>0.639082</td>
      <td>0.939790</td>
      <td>0.641608</td>
    </tr>
    <tr>
      <th>85</th>
      <td>0.209431</td>
      <td>0.973103</td>
      <td>0.391327</td>
      <td>0.086957</td>
      <td>0.130221</td>
      <td>0.970904</td>
      <td>0.122996</td>
      <td>0.233551</td>
      <td>0.769321</td>
      <td>0.503878</td>
    </tr>
    <tr>
      <th>86</th>
      <td>0.733307</td>
      <td>0.521312</td>
      <td>0.085773</td>
      <td>0.530152</td>
      <td>0.540769</td>
      <td>0.028274</td>
      <td>0.110089</td>
      <td>0.130177</td>
      <td>0.041520</td>
      <td>0.053816</td>
    </tr>
    <tr>
      <th>87</th>
      <td>0.168084</td>
      <td>0.795403</td>
      <td>0.168718</td>
      <td>0.641627</td>
      <td>0.269878</td>
      <td>0.180220</td>
      <td>0.002460</td>
      <td>0.077573</td>
      <td>0.229146</td>
      <td>0.414962</td>
    </tr>
    <tr>
      <th>88</th>
      <td>0.922233</td>
      <td>0.729566</td>
      <td>0.592433</td>
      <td>0.493143</td>
      <td>0.056267</td>
      <td>0.509290</td>
      <td>0.991020</td>
      <td>0.230096</td>
      <td>0.337699</td>
      <td>0.655821</td>
    </tr>
    <tr>
      <th>89</th>
      <td>0.272808</td>
      <td>0.262849</td>
      <td>0.439887</td>
      <td>0.333854</td>
      <td>0.006816</td>
      <td>0.154985</td>
      <td>0.158194</td>
      <td>0.649633</td>
      <td>0.345370</td>
      <td>0.293209</td>
    </tr>
    <tr>
      <th>90</th>
      <td>0.388727</td>
      <td>0.885146</td>
      <td>0.980652</td>
      <td>0.986809</td>
      <td>0.489800</td>
      <td>0.710364</td>
      <td>0.360581</td>
      <td>0.672850</td>
      <td>0.732091</td>
      <td>0.178658</td>
    </tr>
    <tr>
      <th>91</th>
      <td>0.109873</td>
      <td>0.385418</td>
      <td>0.945586</td>
      <td>0.704235</td>
      <td>0.559176</td>
      <td>0.065068</td>
      <td>0.370641</td>
      <td>0.500224</td>
      <td>0.342265</td>
      <td>0.247806</td>
    </tr>
    <tr>
      <th>92</th>
      <td>0.607254</td>
      <td>0.349004</td>
      <td>0.186659</td>
      <td>0.482044</td>
      <td>0.617586</td>
      <td>0.441053</td>
      <td>0.853020</td>
      <td>0.664501</td>
      <td>0.679353</td>
      <td>0.471175</td>
    </tr>
    <tr>
      <th>93</th>
      <td>0.819564</td>
      <td>0.058033</td>
      <td>0.764257</td>
      <td>0.011152</td>
      <td>0.570296</td>
      <td>0.194823</td>
      <td>0.911448</td>
      <td>0.965955</td>
      <td>0.329357</td>
      <td>0.865604</td>
    </tr>
    <tr>
      <th>94</th>
      <td>0.978589</td>
      <td>0.535665</td>
      <td>0.254834</td>
      <td>0.328345</td>
      <td>0.656761</td>
      <td>0.731830</td>
      <td>0.681263</td>
      <td>0.431331</td>
      <td>0.076384</td>
      <td>0.221947</td>
    </tr>
    <tr>
      <th>95</th>
      <td>0.868240</td>
      <td>0.341487</td>
      <td>0.287054</td>
      <td>0.123176</td>
      <td>0.036959</td>
      <td>0.212604</td>
      <td>0.349453</td>
      <td>0.143924</td>
      <td>0.852241</td>
      <td>0.249461</td>
    </tr>
    <tr>
      <th>96</th>
      <td>0.287267</td>
      <td>0.459559</td>
      <td>0.694408</td>
      <td>0.509333</td>
      <td>0.542265</td>
      <td>0.103343</td>
      <td>0.605976</td>
      <td>0.278894</td>
      <td>0.439112</td>
      <td>0.070768</td>
    </tr>
    <tr>
      <th>97</th>
      <td>0.234008</td>
      <td>0.534439</td>
      <td>0.546413</td>
      <td>0.622258</td>
      <td>0.323104</td>
      <td>0.778915</td>
      <td>0.121307</td>
      <td>0.960940</td>
      <td>0.888444</td>
      <td>0.896266</td>
    </tr>
    <tr>
      <th>98</th>
      <td>0.764786</td>
      <td>0.543223</td>
      <td>0.806690</td>
      <td>0.862232</td>
      <td>0.550400</td>
      <td>0.986274</td>
      <td>0.646843</td>
      <td>0.188763</td>
      <td>0.313791</td>
      <td>0.974190</td>
    </tr>
    <tr>
      <th>99</th>
      <td>0.608924</td>
      <td>0.090545</td>
      <td>0.371937</td>
      <td>0.074920</td>
      <td>0.645989</td>
      <td>0.933297</td>
      <td>0.196211</td>
      <td>0.082198</td>
      <td>0.345270</td>
      <td>0.518197</td>
    </tr>
  </tbody>
</table>
<p>100 rows × 10 columns</p>
</div>




```python
pd.set_option("max_colwidth", 100)
pd.set_option("display.max_rows", 1000)
pd.set_option("display.max_columns", 9001)

```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.332559</td>
      <td>0.817335</td>
      <td>0.408790</td>
      <td>0.883417</td>
      <td>0.925760</td>
      <td>0.491475</td>
      <td>0.332996</td>
      <td>0.245097</td>
      <td>0.955079</td>
      <td>0.683596</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.506777</td>
      <td>0.326121</td>
      <td>0.581329</td>
      <td>0.967265</td>
      <td>0.774262</td>
      <td>0.035652</td>
      <td>0.392939</td>
      <td>0.497094</td>
      <td>0.488386</td>
      <td>0.172741</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.124318</td>
      <td>0.845284</td>
      <td>0.973494</td>
      <td>0.552595</td>
      <td>0.225346</td>
      <td>0.948348</td>
      <td>0.177595</td>
      <td>0.222497</td>
      <td>0.690050</td>
      <td>0.847546</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.594137</td>
      <td>0.764081</td>
      <td>0.992046</td>
      <td>0.190661</td>
      <td>0.458834</td>
      <td>0.619343</td>
      <td>0.543222</td>
      <td>0.478462</td>
      <td>0.941433</td>
      <td>0.189839</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.389404</td>
      <td>0.707036</td>
      <td>0.410187</td>
      <td>0.473415</td>
      <td>0.152940</td>
      <td>0.225006</td>
      <td>0.459529</td>
      <td>0.886686</td>
      <td>0.774106</td>
      <td>0.256574</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.752569</td>
      <td>0.437070</td>
      <td>0.515809</td>
      <td>0.852868</td>
      <td>0.496751</td>
      <td>0.694558</td>
      <td>0.446531</td>
      <td>0.595130</td>
      <td>0.441311</td>
      <td>0.057544</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.743398</td>
      <td>0.742810</td>
      <td>0.336510</td>
      <td>0.021672</td>
      <td>0.154411</td>
      <td>0.571875</td>
      <td>0.679285</td>
      <td>0.013389</td>
      <td>0.267114</td>
      <td>0.947542</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.249761</td>
      <td>0.064544</td>
      <td>0.607377</td>
      <td>0.427276</td>
      <td>0.370251</td>
      <td>0.865870</td>
      <td>0.951798</td>
      <td>0.980376</td>
      <td>0.503680</td>
      <td>0.867869</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.929170</td>
      <td>0.407956</td>
      <td>0.641100</td>
      <td>0.808600</td>
      <td>0.679924</td>
      <td>0.952972</td>
      <td>0.765462</td>
      <td>0.035881</td>
      <td>0.499213</td>
      <td>0.365271</td>
    </tr>
    <tr>
      <th>9</th>
      <td>0.069586</td>
      <td>0.394798</td>
      <td>0.560635</td>
      <td>0.941417</td>
      <td>0.297765</td>
      <td>0.187606</td>
      <td>0.506170</td>
      <td>0.955814</td>
      <td>0.891632</td>
      <td>0.419866</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.827701</td>
      <td>0.718031</td>
      <td>0.170320</td>
      <td>0.168705</td>
      <td>0.313490</td>
      <td>0.595110</td>
      <td>0.436215</td>
      <td>0.057145</td>
      <td>0.976260</td>
      <td>0.534726</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.242130</td>
      <td>0.279837</td>
      <td>0.329979</td>
      <td>0.980450</td>
      <td>0.285774</td>
      <td>0.143720</td>
      <td>0.707582</td>
      <td>0.628614</td>
      <td>0.185452</td>
      <td>0.983469</td>
    </tr>
    <tr>
      <th>12</th>
      <td>0.964204</td>
      <td>0.840649</td>
      <td>0.519745</td>
      <td>0.439136</td>
      <td>0.191327</td>
      <td>0.255342</td>
      <td>0.161771</td>
      <td>0.258738</td>
      <td>0.821988</td>
      <td>0.089223</td>
    </tr>
    <tr>
      <th>13</th>
      <td>0.528773</td>
      <td>0.150766</td>
      <td>0.160997</td>
      <td>0.796449</td>
      <td>0.625050</td>
      <td>0.898132</td>
      <td>0.622695</td>
      <td>0.511752</td>
      <td>0.348881</td>
      <td>0.274251</td>
    </tr>
    <tr>
      <th>14</th>
      <td>0.554581</td>
      <td>0.772540</td>
      <td>0.501492</td>
      <td>0.890981</td>
      <td>0.363326</td>
      <td>0.232203</td>
      <td>0.339655</td>
      <td>0.512516</td>
      <td>0.812883</td>
      <td>0.813039</td>
    </tr>
    <tr>
      <th>15</th>
      <td>0.017119</td>
      <td>0.833591</td>
      <td>0.491231</td>
      <td>0.698028</td>
      <td>0.070933</td>
      <td>0.901884</td>
      <td>0.353139</td>
      <td>0.507318</td>
      <td>0.532148</td>
      <td>0.913510</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.303143</td>
      <td>0.720269</td>
      <td>0.836471</td>
      <td>0.172324</td>
      <td>0.777735</td>
      <td>0.675194</td>
      <td>0.459614</td>
      <td>0.965569</td>
      <td>0.589760</td>
      <td>0.267947</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.459640</td>
      <td>0.471618</td>
      <td>0.680691</td>
      <td>0.069857</td>
      <td>0.890254</td>
      <td>0.680691</td>
      <td>0.850862</td>
      <td>0.887371</td>
      <td>0.600478</td>
      <td>0.613436</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.807910</td>
      <td>0.004564</td>
      <td>0.310260</td>
      <td>0.577989</td>
      <td>0.697535</td>
      <td>0.402553</td>
      <td>0.612986</td>
      <td>0.152911</td>
      <td>0.186655</td>
      <td>0.711620</td>
    </tr>
    <tr>
      <th>19</th>
      <td>0.796835</td>
      <td>0.894753</td>
      <td>0.016744</td>
      <td>0.059018</td>
      <td>0.966855</td>
      <td>0.384143</td>
      <td>0.532837</td>
      <td>0.505691</td>
      <td>0.420396</td>
      <td>0.578264</td>
    </tr>
    <tr>
      <th>20</th>
      <td>0.467081</td>
      <td>0.153612</td>
      <td>0.280480</td>
      <td>0.298517</td>
      <td>0.259698</td>
      <td>0.260507</td>
      <td>0.747273</td>
      <td>0.879212</td>
      <td>0.815702</td>
      <td>0.030107</td>
    </tr>
    <tr>
      <th>21</th>
      <td>0.743701</td>
      <td>0.948741</td>
      <td>0.634907</td>
      <td>0.709664</td>
      <td>0.230629</td>
      <td>0.652195</td>
      <td>0.833835</td>
      <td>0.001210</td>
      <td>0.177989</td>
      <td>0.803404</td>
    </tr>
    <tr>
      <th>22</th>
      <td>0.105973</td>
      <td>0.162109</td>
      <td>0.685493</td>
      <td>0.092334</td>
      <td>0.530445</td>
      <td>0.773243</td>
      <td>0.992151</td>
      <td>0.761404</td>
      <td>0.273222</td>
      <td>0.339905</td>
    </tr>
    <tr>
      <th>23</th>
      <td>0.039874</td>
      <td>0.203370</td>
      <td>0.633356</td>
      <td>0.152678</td>
      <td>0.918532</td>
      <td>0.961898</td>
      <td>0.915903</td>
      <td>0.879231</td>
      <td>0.007396</td>
      <td>0.318876</td>
    </tr>
    <tr>
      <th>24</th>
      <td>0.038758</td>
      <td>0.131448</td>
      <td>0.731870</td>
      <td>0.858319</td>
      <td>0.388706</td>
      <td>0.817867</td>
      <td>0.367371</td>
      <td>0.275239</td>
      <td>0.928890</td>
      <td>0.935821</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0.842215</td>
      <td>0.557416</td>
      <td>0.037839</td>
      <td>0.713620</td>
      <td>0.039762</td>
      <td>0.331826</td>
      <td>0.416544</td>
      <td>0.323931</td>
      <td>0.635712</td>
      <td>0.241878</td>
    </tr>
    <tr>
      <th>26</th>
      <td>0.764447</td>
      <td>0.192502</td>
      <td>0.924932</td>
      <td>0.630741</td>
      <td>0.743219</td>
      <td>0.780681</td>
      <td>0.920846</td>
      <td>0.342242</td>
      <td>0.351829</td>
      <td>0.529702</td>
    </tr>
    <tr>
      <th>27</th>
      <td>0.905952</td>
      <td>0.124906</td>
      <td>0.531291</td>
      <td>0.571168</td>
      <td>0.778201</td>
      <td>0.177498</td>
      <td>0.354741</td>
      <td>0.950249</td>
      <td>0.653792</td>
      <td>0.715288</td>
    </tr>
    <tr>
      <th>28</th>
      <td>0.265424</td>
      <td>0.981468</td>
      <td>0.207388</td>
      <td>0.148392</td>
      <td>0.378744</td>
      <td>0.340396</td>
      <td>0.403250</td>
      <td>0.047198</td>
      <td>0.544206</td>
      <td>0.893234</td>
    </tr>
    <tr>
      <th>29</th>
      <td>0.418578</td>
      <td>0.438400</td>
      <td>0.953008</td>
      <td>0.338786</td>
      <td>0.224299</td>
      <td>0.715502</td>
      <td>0.854097</td>
      <td>0.623577</td>
      <td>0.458004</td>
      <td>0.803907</td>
    </tr>
    <tr>
      <th>30</th>
      <td>0.017059</td>
      <td>0.798813</td>
      <td>0.024458</td>
      <td>0.217546</td>
      <td>0.956897</td>
      <td>0.482415</td>
      <td>0.586127</td>
      <td>0.706572</td>
      <td>0.764481</td>
      <td>0.254894</td>
    </tr>
    <tr>
      <th>31</th>
      <td>0.519713</td>
      <td>0.551098</td>
      <td>0.241497</td>
      <td>0.432095</td>
      <td>0.799119</td>
      <td>0.960757</td>
      <td>0.772033</td>
      <td>0.576961</td>
      <td>0.284823</td>
      <td>0.402346</td>
    </tr>
    <tr>
      <th>32</th>
      <td>0.553568</td>
      <td>0.231214</td>
      <td>0.314316</td>
      <td>0.531990</td>
      <td>0.876227</td>
      <td>0.817838</td>
      <td>0.537415</td>
      <td>0.063343</td>
      <td>0.081819</td>
      <td>0.912077</td>
    </tr>
    <tr>
      <th>33</th>
      <td>0.089148</td>
      <td>0.589056</td>
      <td>0.332736</td>
      <td>0.453457</td>
      <td>0.997070</td>
      <td>0.363791</td>
      <td>0.604407</td>
      <td>0.174842</td>
      <td>0.155208</td>
      <td>0.972860</td>
    </tr>
    <tr>
      <th>34</th>
      <td>0.584773</td>
      <td>0.503478</td>
      <td>0.910300</td>
      <td>0.419354</td>
      <td>0.218088</td>
      <td>0.624074</td>
      <td>0.764950</td>
      <td>0.536753</td>
      <td>0.675413</td>
      <td>0.992573</td>
    </tr>
    <tr>
      <th>35</th>
      <td>0.318096</td>
      <td>0.817763</td>
      <td>0.726798</td>
      <td>0.622104</td>
      <td>0.324168</td>
      <td>0.331630</td>
      <td>0.280507</td>
      <td>0.413786</td>
      <td>0.100163</td>
      <td>0.369489</td>
    </tr>
    <tr>
      <th>36</th>
      <td>0.293968</td>
      <td>0.956395</td>
      <td>0.957582</td>
      <td>0.526110</td>
      <td>0.599490</td>
      <td>0.080477</td>
      <td>0.026725</td>
      <td>0.236875</td>
      <td>0.601163</td>
      <td>0.646984</td>
    </tr>
    <tr>
      <th>37</th>
      <td>0.332393</td>
      <td>0.201691</td>
      <td>0.508894</td>
      <td>0.649153</td>
      <td>0.030576</td>
      <td>0.728143</td>
      <td>0.734058</td>
      <td>0.686936</td>
      <td>0.689867</td>
      <td>0.139234</td>
    </tr>
    <tr>
      <th>38</th>
      <td>0.332700</td>
      <td>0.370488</td>
      <td>0.676232</td>
      <td>0.697341</td>
      <td>0.011987</td>
      <td>0.611988</td>
      <td>0.317103</td>
      <td>0.678583</td>
      <td>0.444064</td>
      <td>0.276098</td>
    </tr>
    <tr>
      <th>39</th>
      <td>0.075799</td>
      <td>0.215485</td>
      <td>0.484596</td>
      <td>0.379642</td>
      <td>0.122936</td>
      <td>0.271644</td>
      <td>0.260531</td>
      <td>0.632989</td>
      <td>0.118887</td>
      <td>0.444602</td>
    </tr>
    <tr>
      <th>40</th>
      <td>0.516104</td>
      <td>0.918034</td>
      <td>0.375482</td>
      <td>0.718234</td>
      <td>0.523434</td>
      <td>0.329958</td>
      <td>0.174468</td>
      <td>0.980582</td>
      <td>0.168990</td>
      <td>0.587153</td>
    </tr>
    <tr>
      <th>41</th>
      <td>0.892218</td>
      <td>0.630006</td>
      <td>0.021497</td>
      <td>0.590710</td>
      <td>0.840492</td>
      <td>0.021032</td>
      <td>0.564734</td>
      <td>0.496298</td>
      <td>0.949759</td>
      <td>0.331275</td>
    </tr>
    <tr>
      <th>42</th>
      <td>0.893610</td>
      <td>0.969152</td>
      <td>0.138721</td>
      <td>0.459614</td>
      <td>0.887449</td>
      <td>0.436690</td>
      <td>0.973090</td>
      <td>0.531544</td>
      <td>0.470597</td>
      <td>0.851099</td>
    </tr>
    <tr>
      <th>43</th>
      <td>0.168979</td>
      <td>0.183738</td>
      <td>0.389569</td>
      <td>0.335795</td>
      <td>0.814012</td>
      <td>0.254437</td>
      <td>0.799220</td>
      <td>0.771368</td>
      <td>0.739076</td>
      <td>0.857424</td>
    </tr>
    <tr>
      <th>44</th>
      <td>0.283487</td>
      <td>0.381312</td>
      <td>0.891064</td>
      <td>0.356640</td>
      <td>0.835555</td>
      <td>0.394001</td>
      <td>0.542568</td>
      <td>0.820629</td>
      <td>0.713009</td>
      <td>0.829285</td>
    </tr>
    <tr>
      <th>45</th>
      <td>0.540229</td>
      <td>0.110407</td>
      <td>0.370848</td>
      <td>0.630644</td>
      <td>0.555522</td>
      <td>0.190316</td>
      <td>0.694066</td>
      <td>0.925322</td>
      <td>0.192007</td>
      <td>0.886982</td>
    </tr>
    <tr>
      <th>46</th>
      <td>0.910398</td>
      <td>0.770296</td>
      <td>0.375176</td>
      <td>0.874180</td>
      <td>0.238180</td>
      <td>0.549058</td>
      <td>0.606015</td>
      <td>0.537657</td>
      <td>0.489395</td>
      <td>0.849969</td>
    </tr>
    <tr>
      <th>47</th>
      <td>0.185306</td>
      <td>0.734184</td>
      <td>0.437295</td>
      <td>0.168814</td>
      <td>0.631362</td>
      <td>0.707618</td>
      <td>0.867066</td>
      <td>0.067259</td>
      <td>0.895000</td>
      <td>0.343647</td>
    </tr>
    <tr>
      <th>48</th>
      <td>0.755459</td>
      <td>0.928459</td>
      <td>0.560591</td>
      <td>0.936809</td>
      <td>0.429886</td>
      <td>0.094069</td>
      <td>0.242715</td>
      <td>0.870583</td>
      <td>0.918831</td>
      <td>0.501261</td>
    </tr>
    <tr>
      <th>49</th>
      <td>0.115033</td>
      <td>0.352223</td>
      <td>0.300489</td>
      <td>0.106039</td>
      <td>0.843724</td>
      <td>0.188294</td>
      <td>0.167691</td>
      <td>0.250448</td>
      <td>0.306043</td>
      <td>0.238692</td>
    </tr>
    <tr>
      <th>50</th>
      <td>0.048098</td>
      <td>0.397600</td>
      <td>0.930515</td>
      <td>0.471940</td>
      <td>0.184979</td>
      <td>0.853488</td>
      <td>0.466588</td>
      <td>0.195691</td>
      <td>0.674463</td>
      <td>0.981052</td>
    </tr>
    <tr>
      <th>51</th>
      <td>0.328260</td>
      <td>0.625609</td>
      <td>0.911241</td>
      <td>0.770213</td>
      <td>0.445242</td>
      <td>0.944382</td>
      <td>0.503555</td>
      <td>0.790751</td>
      <td>0.248819</td>
      <td>0.461033</td>
    </tr>
    <tr>
      <th>52</th>
      <td>0.704239</td>
      <td>0.123670</td>
      <td>0.570907</td>
      <td>0.630500</td>
      <td>0.642372</td>
      <td>0.088316</td>
      <td>0.473208</td>
      <td>0.276729</td>
      <td>0.853004</td>
      <td>0.024567</td>
    </tr>
    <tr>
      <th>53</th>
      <td>0.557335</td>
      <td>0.487781</td>
      <td>0.933319</td>
      <td>0.450628</td>
      <td>0.647223</td>
      <td>0.928952</td>
      <td>0.677685</td>
      <td>0.759845</td>
      <td>0.421906</td>
      <td>0.917048</td>
    </tr>
    <tr>
      <th>54</th>
      <td>0.949302</td>
      <td>0.428107</td>
      <td>0.360178</td>
      <td>0.371857</td>
      <td>0.563187</td>
      <td>0.540173</td>
      <td>0.106079</td>
      <td>0.260925</td>
      <td>0.470566</td>
      <td>0.607503</td>
    </tr>
    <tr>
      <th>55</th>
      <td>0.992566</td>
      <td>0.200645</td>
      <td>0.691491</td>
      <td>0.614313</td>
      <td>0.332441</td>
      <td>0.302892</td>
      <td>0.775142</td>
      <td>0.768002</td>
      <td>0.652362</td>
      <td>0.193426</td>
    </tr>
    <tr>
      <th>56</th>
      <td>0.060659</td>
      <td>0.877359</td>
      <td>0.000184</td>
      <td>0.398445</td>
      <td>0.505876</td>
      <td>0.146950</td>
      <td>0.651236</td>
      <td>0.655722</td>
      <td>0.433748</td>
      <td>0.465840</td>
    </tr>
    <tr>
      <th>57</th>
      <td>0.268321</td>
      <td>0.438708</td>
      <td>0.904841</td>
      <td>0.315058</td>
      <td>0.260582</td>
      <td>0.783342</td>
      <td>0.413231</td>
      <td>0.820277</td>
      <td>0.085062</td>
      <td>0.357371</td>
    </tr>
    <tr>
      <th>58</th>
      <td>0.197154</td>
      <td>0.162166</td>
      <td>0.158260</td>
      <td>0.611666</td>
      <td>0.871201</td>
      <td>0.444899</td>
      <td>0.891937</td>
      <td>0.568396</td>
      <td>0.175935</td>
      <td>0.262231</td>
    </tr>
    <tr>
      <th>59</th>
      <td>0.745748</td>
      <td>0.743093</td>
      <td>0.721912</td>
      <td>0.642776</td>
      <td>0.236228</td>
      <td>0.370768</td>
      <td>0.039049</td>
      <td>0.942022</td>
      <td>0.094764</td>
      <td>0.697757</td>
    </tr>
    <tr>
      <th>60</th>
      <td>0.150056</td>
      <td>0.434566</td>
      <td>0.683580</td>
      <td>0.535905</td>
      <td>0.100654</td>
      <td>0.306971</td>
      <td>0.776867</td>
      <td>0.717173</td>
      <td>0.988672</td>
      <td>0.583406</td>
    </tr>
    <tr>
      <th>61</th>
      <td>0.756005</td>
      <td>0.406733</td>
      <td>0.229135</td>
      <td>0.126763</td>
      <td>0.423662</td>
      <td>0.950955</td>
      <td>0.024078</td>
      <td>0.375733</td>
      <td>0.231525</td>
      <td>0.845092</td>
    </tr>
    <tr>
      <th>62</th>
      <td>0.221371</td>
      <td>0.999162</td>
      <td>0.560617</td>
      <td>0.705418</td>
      <td>0.340005</td>
      <td>0.202388</td>
      <td>0.399453</td>
      <td>0.421820</td>
      <td>0.785433</td>
      <td>0.689861</td>
    </tr>
    <tr>
      <th>63</th>
      <td>0.788888</td>
      <td>0.193850</td>
      <td>0.161116</td>
      <td>0.927865</td>
      <td>0.814412</td>
      <td>0.562899</td>
      <td>0.963289</td>
      <td>0.334050</td>
      <td>0.892634</td>
      <td>0.309280</td>
    </tr>
    <tr>
      <th>64</th>
      <td>0.420729</td>
      <td>0.305408</td>
      <td>0.111384</td>
      <td>0.288702</td>
      <td>0.817835</td>
      <td>0.275271</td>
      <td>0.100576</td>
      <td>0.180303</td>
      <td>0.649721</td>
      <td>0.124223</td>
    </tr>
    <tr>
      <th>65</th>
      <td>0.242197</td>
      <td>0.552735</td>
      <td>0.051019</td>
      <td>0.062505</td>
      <td>0.625107</td>
      <td>0.810788</td>
      <td>0.277415</td>
      <td>0.353279</td>
      <td>0.732477</td>
      <td>0.552762</td>
    </tr>
    <tr>
      <th>66</th>
      <td>0.962498</td>
      <td>0.896762</td>
      <td>0.786726</td>
      <td>0.576547</td>
      <td>0.224934</td>
      <td>0.134526</td>
      <td>0.199355</td>
      <td>0.729110</td>
      <td>0.595514</td>
      <td>0.911123</td>
    </tr>
    <tr>
      <th>67</th>
      <td>0.465990</td>
      <td>0.395026</td>
      <td>0.764971</td>
      <td>0.647772</td>
      <td>0.539335</td>
      <td>0.657188</td>
      <td>0.333151</td>
      <td>0.459969</td>
      <td>0.547179</td>
      <td>0.030846</td>
    </tr>
    <tr>
      <th>68</th>
      <td>0.060259</td>
      <td>0.022711</td>
      <td>0.009638</td>
      <td>0.465674</td>
      <td>0.069538</td>
      <td>0.036433</td>
      <td>0.471857</td>
      <td>0.410469</td>
      <td>0.346333</td>
      <td>0.841073</td>
    </tr>
    <tr>
      <th>69</th>
      <td>0.426822</td>
      <td>0.777543</td>
      <td>0.645665</td>
      <td>0.651559</td>
      <td>0.247116</td>
      <td>0.309256</td>
      <td>0.429231</td>
      <td>0.285500</td>
      <td>0.447413</td>
      <td>0.990726</td>
    </tr>
    <tr>
      <th>70</th>
      <td>0.785851</td>
      <td>0.625053</td>
      <td>0.572484</td>
      <td>0.344429</td>
      <td>0.465417</td>
      <td>0.851989</td>
      <td>0.055669</td>
      <td>0.101646</td>
      <td>0.970665</td>
      <td>0.023909</td>
    </tr>
    <tr>
      <th>71</th>
      <td>0.612778</td>
      <td>0.054991</td>
      <td>0.931069</td>
      <td>0.368668</td>
      <td>0.139984</td>
      <td>0.929182</td>
      <td>0.646530</td>
      <td>0.673750</td>
      <td>0.925752</td>
      <td>0.381135</td>
    </tr>
    <tr>
      <th>72</th>
      <td>0.525891</td>
      <td>0.243055</td>
      <td>0.833502</td>
      <td>0.175938</td>
      <td>0.566473</td>
      <td>0.955329</td>
      <td>0.547075</td>
      <td>0.138392</td>
      <td>0.932905</td>
      <td>0.638634</td>
    </tr>
    <tr>
      <th>73</th>
      <td>0.091340</td>
      <td>0.314255</td>
      <td>0.224582</td>
      <td>0.708030</td>
      <td>0.051977</td>
      <td>0.939406</td>
      <td>0.848416</td>
      <td>0.436854</td>
      <td>0.008277</td>
      <td>0.569559</td>
    </tr>
    <tr>
      <th>74</th>
      <td>0.784897</td>
      <td>0.883513</td>
      <td>0.368309</td>
      <td>0.487432</td>
      <td>0.482025</td>
      <td>0.278562</td>
      <td>0.769802</td>
      <td>0.655161</td>
      <td>0.390509</td>
      <td>0.937977</td>
    </tr>
    <tr>
      <th>75</th>
      <td>0.473963</td>
      <td>0.856605</td>
      <td>0.279710</td>
      <td>0.672958</td>
      <td>0.003968</td>
      <td>0.094930</td>
      <td>0.247854</td>
      <td>0.924776</td>
      <td>0.129369</td>
      <td>0.291227</td>
    </tr>
    <tr>
      <th>76</th>
      <td>0.703505</td>
      <td>0.478669</td>
      <td>0.812769</td>
      <td>0.307390</td>
      <td>0.122931</td>
      <td>0.824975</td>
      <td>0.073262</td>
      <td>0.784912</td>
      <td>0.015453</td>
      <td>0.201764</td>
    </tr>
    <tr>
      <th>77</th>
      <td>0.865534</td>
      <td>0.239719</td>
      <td>0.078379</td>
      <td>0.045903</td>
      <td>0.911878</td>
      <td>0.788672</td>
      <td>0.283483</td>
      <td>0.093282</td>
      <td>0.830255</td>
      <td>0.766615</td>
    </tr>
    <tr>
      <th>78</th>
      <td>0.423895</td>
      <td>0.592060</td>
      <td>0.992649</td>
      <td>0.265216</td>
      <td>0.928685</td>
      <td>0.819428</td>
      <td>0.982527</td>
      <td>0.448558</td>
      <td>0.103979</td>
      <td>0.791247</td>
    </tr>
    <tr>
      <th>79</th>
      <td>0.607598</td>
      <td>0.588940</td>
      <td>0.749097</td>
      <td>0.276011</td>
      <td>0.151373</td>
      <td>0.806061</td>
      <td>0.219677</td>
      <td>0.818870</td>
      <td>0.055326</td>
      <td>0.590411</td>
    </tr>
    <tr>
      <th>80</th>
      <td>0.833418</td>
      <td>0.689373</td>
      <td>0.301834</td>
      <td>0.085809</td>
      <td>0.549914</td>
      <td>0.548821</td>
      <td>0.933423</td>
      <td>0.411951</td>
      <td>0.963576</td>
      <td>0.157433</td>
    </tr>
    <tr>
      <th>81</th>
      <td>0.339780</td>
      <td>0.330240</td>
      <td>0.991863</td>
      <td>0.573516</td>
      <td>0.198036</td>
      <td>0.271417</td>
      <td>0.978376</td>
      <td>0.367005</td>
      <td>0.043040</td>
      <td>0.060756</td>
    </tr>
    <tr>
      <th>82</th>
      <td>0.699433</td>
      <td>0.860513</td>
      <td>0.875375</td>
      <td>0.146366</td>
      <td>0.896943</td>
      <td>0.829047</td>
      <td>0.380595</td>
      <td>0.939119</td>
      <td>0.841969</td>
      <td>0.414682</td>
    </tr>
    <tr>
      <th>83</th>
      <td>0.443156</td>
      <td>0.207281</td>
      <td>0.712977</td>
      <td>0.708367</td>
      <td>0.034060</td>
      <td>0.590776</td>
      <td>0.449715</td>
      <td>0.580867</td>
      <td>0.974195</td>
      <td>0.376413</td>
    </tr>
    <tr>
      <th>84</th>
      <td>0.372621</td>
      <td>0.222289</td>
      <td>0.967124</td>
      <td>0.716900</td>
      <td>0.203352</td>
      <td>0.269697</td>
      <td>0.875133</td>
      <td>0.639082</td>
      <td>0.939790</td>
      <td>0.641608</td>
    </tr>
    <tr>
      <th>85</th>
      <td>0.209431</td>
      <td>0.973103</td>
      <td>0.391327</td>
      <td>0.086957</td>
      <td>0.130221</td>
      <td>0.970904</td>
      <td>0.122996</td>
      <td>0.233551</td>
      <td>0.769321</td>
      <td>0.503878</td>
    </tr>
    <tr>
      <th>86</th>
      <td>0.733307</td>
      <td>0.521312</td>
      <td>0.085773</td>
      <td>0.530152</td>
      <td>0.540769</td>
      <td>0.028274</td>
      <td>0.110089</td>
      <td>0.130177</td>
      <td>0.041520</td>
      <td>0.053816</td>
    </tr>
    <tr>
      <th>87</th>
      <td>0.168084</td>
      <td>0.795403</td>
      <td>0.168718</td>
      <td>0.641627</td>
      <td>0.269878</td>
      <td>0.180220</td>
      <td>0.002460</td>
      <td>0.077573</td>
      <td>0.229146</td>
      <td>0.414962</td>
    </tr>
    <tr>
      <th>88</th>
      <td>0.922233</td>
      <td>0.729566</td>
      <td>0.592433</td>
      <td>0.493143</td>
      <td>0.056267</td>
      <td>0.509290</td>
      <td>0.991020</td>
      <td>0.230096</td>
      <td>0.337699</td>
      <td>0.655821</td>
    </tr>
    <tr>
      <th>89</th>
      <td>0.272808</td>
      <td>0.262849</td>
      <td>0.439887</td>
      <td>0.333854</td>
      <td>0.006816</td>
      <td>0.154985</td>
      <td>0.158194</td>
      <td>0.649633</td>
      <td>0.345370</td>
      <td>0.293209</td>
    </tr>
    <tr>
      <th>90</th>
      <td>0.388727</td>
      <td>0.885146</td>
      <td>0.980652</td>
      <td>0.986809</td>
      <td>0.489800</td>
      <td>0.710364</td>
      <td>0.360581</td>
      <td>0.672850</td>
      <td>0.732091</td>
      <td>0.178658</td>
    </tr>
    <tr>
      <th>91</th>
      <td>0.109873</td>
      <td>0.385418</td>
      <td>0.945586</td>
      <td>0.704235</td>
      <td>0.559176</td>
      <td>0.065068</td>
      <td>0.370641</td>
      <td>0.500224</td>
      <td>0.342265</td>
      <td>0.247806</td>
    </tr>
    <tr>
      <th>92</th>
      <td>0.607254</td>
      <td>0.349004</td>
      <td>0.186659</td>
      <td>0.482044</td>
      <td>0.617586</td>
      <td>0.441053</td>
      <td>0.853020</td>
      <td>0.664501</td>
      <td>0.679353</td>
      <td>0.471175</td>
    </tr>
    <tr>
      <th>93</th>
      <td>0.819564</td>
      <td>0.058033</td>
      <td>0.764257</td>
      <td>0.011152</td>
      <td>0.570296</td>
      <td>0.194823</td>
      <td>0.911448</td>
      <td>0.965955</td>
      <td>0.329357</td>
      <td>0.865604</td>
    </tr>
    <tr>
      <th>94</th>
      <td>0.978589</td>
      <td>0.535665</td>
      <td>0.254834</td>
      <td>0.328345</td>
      <td>0.656761</td>
      <td>0.731830</td>
      <td>0.681263</td>
      <td>0.431331</td>
      <td>0.076384</td>
      <td>0.221947</td>
    </tr>
    <tr>
      <th>95</th>
      <td>0.868240</td>
      <td>0.341487</td>
      <td>0.287054</td>
      <td>0.123176</td>
      <td>0.036959</td>
      <td>0.212604</td>
      <td>0.349453</td>
      <td>0.143924</td>
      <td>0.852241</td>
      <td>0.249461</td>
    </tr>
    <tr>
      <th>96</th>
      <td>0.287267</td>
      <td>0.459559</td>
      <td>0.694408</td>
      <td>0.509333</td>
      <td>0.542265</td>
      <td>0.103343</td>
      <td>0.605976</td>
      <td>0.278894</td>
      <td>0.439112</td>
      <td>0.070768</td>
    </tr>
    <tr>
      <th>97</th>
      <td>0.234008</td>
      <td>0.534439</td>
      <td>0.546413</td>
      <td>0.622258</td>
      <td>0.323104</td>
      <td>0.778915</td>
      <td>0.121307</td>
      <td>0.960940</td>
      <td>0.888444</td>
      <td>0.896266</td>
    </tr>
    <tr>
      <th>98</th>
      <td>0.764786</td>
      <td>0.543223</td>
      <td>0.806690</td>
      <td>0.862232</td>
      <td>0.550400</td>
      <td>0.986274</td>
      <td>0.646843</td>
      <td>0.188763</td>
      <td>0.313791</td>
      <td>0.974190</td>
    </tr>
    <tr>
      <th>99</th>
      <td>0.608924</td>
      <td>0.090545</td>
      <td>0.371937</td>
      <td>0.074920</td>
      <td>0.645989</td>
      <td>0.933297</td>
      <td>0.196211</td>
      <td>0.082198</td>
      <td>0.345270</td>
      <td>0.518197</td>
    </tr>
  </tbody>
</table>
</div>



# Auto reload files
Often I will be developing a python module while I'm writing the notebook. I will typically put functions for plotting or some pre-processing inside such a file. But this means that if I want to change I will have to manually reload the file. However, using the `autoreload` Notebook extension, I no longer have to worry about that


```python
%load_ext autoreload
%autoreload 2
%aimport someModule
```


```python
someModule.some_function()
```

    Some function has run. And now the result is different!



```python
# I should write a script that changes the file 
# here, so I dont have to do it behind the scene.
```

I then change the file and run it again below:


```python
someModule.some_function()
```

    Some function has run. And now the result is different!


# Conclusion
I have shown how you customize you jupyter notebook by using three different config files and a CSS file. I hope you found it useful.

# References
I have found the following references useful when developing my customization.
1. [Gerrit Gruben - Leveling up your Jupyter notebook skills](https://www.youtube.com/watch?v=b8g-8T0amuk&t=335s)
