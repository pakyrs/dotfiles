# Dotfiles Collection 👨‍💻

This is my collection of dotfiles, which includes configurations and settings for various tools and applications. It emphasizes the usage of Zsh, Oh My Zsh, Starship, and the Dracula theme to create a powerful and visually appealing terminal environment.

## Prerequisites 🛠️

To make the most out of this dotfiles collection, ensure that the following dependencies are installed:

- Zsh: A powerful shell with advanced features and customization options. 🐚
- Oh My Zsh: A community-driven framework for managing Zsh configurations. 🙌
- Starship: A minimalistic and fast shell prompt. ⭐
- Stow: A symlink manager that simplifies the organization and installation of dotfiles. 📦
- Dracula Theme: A dark color scheme for various applications and environments. 🧛‍♂️🌙

## Installation 🚀

1. Clone the repository:
```shell
git clone https://github.com/yourusername/dotfiles.git
```
2. Change to the dotfiles directory:
```shell
cd dotfiles
```
## 3. Install Zsh:

#### On macOS, use Homebrew:
```shell
brew install zsh
```
#### On Ubuntu, use apt:

```shell
 sudo apt-get install zsh
```
## 4. Install Oh My Zsh:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
## 5. Install Starship:

#### On macOS, use Homebrew:

```shell
brew install starship
```
#### On Ubuntu, use snap:

```shell
    sudo snap install starship
```
## 6. Install GNU Stow
- On macOS, use Homebrew:

```shell
brew install stow
```
On Ubuntu, use apt:
```shell
sudo apt-get install stow
```
## 7. Configure Zsh, Oh My Zsh, and Starship:

Copy the dotfiles to the appropriate locations and unstow.
```shell
 cd ~/dotfiles
 stow -v */
```

Edit the configurations to customize them according to your preferences.

Set Zsh as the default shell:

```shell
chsh -s $(which zsh)
```

 Restart your terminal or start a new session to see the changes.

## Customization 🎨

Feel free to customize the dotfiles and configurations to match your preferences. Explore the different themes and options provided by Oh My Zsh, Starship, and the Dracula theme to create your own unique terminal environment.
Contributing

## Contributing 🤝

Contributions to this dotfiles collection are welcome! If you have any suggestions, improvements, or bug fixes, please feel free to open an issue or submit a pull request.
License

## License 📝

This project is licensed under the MIT License.
