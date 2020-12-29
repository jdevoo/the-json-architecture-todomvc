const HtmlWebpackPlugin = require('html-webpack-plugin')
const webpack = require('webpack')
const path = require('path')

module.exports = {
  mode: 'development',
  entry: {
    app: [path.resolve(__dirname, 'src', 'app.js')],
    vendor: [
      'jquery',
      'riot',
      'kefir',
      'ramda',
      'baobab',
      'json-patch-utils'
    ]
  },
  stats: {
    colors: true
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'build'),
    pathinfo: true
  },
  devtool: 'eval',
  devServer: {
    contentBase: path.resolve(__dirname, 'build'),
    historyApiFallback: true,
    inline: true,
    hot: true,
    stats: 'minimal',
    port: '3000',
    host: '0.0.0.0',
    publicPath: '/'
  },
  resolve: {
    modules: [
      path.join(__dirname, 'src'),
        'node_modules'
    ],
    alias: {
      lib: path.resolve(__dirname, 'lib'),
      schema: path.resolve(__dirname, 'src/schema')
    },
    extensions: ['.js', '.yaml', '.tag']
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    }),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      inject: false,
      mobile: true,
      template: path.resolve(__dirname, 'index.ejs'),
      appMountId: 'app',
      title: 'The JSON Architecture TodoMVC Demo',
      hash: true
    })
  ],
  module: {
    noParse: [
      /^jquery$/,
      /^riot$/,
      /^kefir$/,
      /^baobab$/,
      /^ramda$/,
      /^json-patch-utils$/
    ],
    rules: [
      { test: /\.ya?ml$/, exclude: /node_modules/,
        enforce: 'pre', type: 'json', use: 'yaml-loader'
      },
      { test: /\.js$/, exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      },
      { test: /\.js|\.tag$/, exclude: /node_modules/,
        use: {
          loader: 'ramda-loader',
          query: '?debug'
        }
      },
      { test: /\.tag$/, exclude: /node_modules/,
        use: {
          loader: '@riotjs/webpack-loader',
          options: { hot: true }
        }
      }
    ]
  }
}
