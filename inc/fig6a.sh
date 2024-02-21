#sudo npm i -g md-to-pdf-ng

# The graph was prepared with mermaid
# code is available in `docs-src/RS/states-collapse.mmd`
# we can copy and paste the code into the https://mermaid.live editor 
# and then download the PNG or SVG versions:

cd figs
wget --continue 'https://mermaid.ink/svg/pako:eNqdlV1v2jAUhv9K5AkJJMIySEiwBtIKqVaJ3azSdjHvwsROsWZslJghVPW_7yQ0n027bLmIsc_rJ6_tc8wjijTjCKNY6nO0p4mxtl-JsuDZ6vMPguBtMf6QUEaN0IqgnxhjGLw31PCr8Itm3wXjID5Dkx4TThkh6gDgJBMRVQcQFYWboTOZjVbOJLjyngk15lpLSY8pZ8MhQWWHoNEI5GW_NuGzeNh3udjD-CsOvJqDYnqLeKcMTwApsvbAmbiu529Qr4LmhBr1G08uWx1RCVSZtSJbF1G_Ydx6gxtk3NmVWzJa3Ffc9kJ7FbrLctfW9uIGFbexv2WOWcslQf5sQNByuSpyqYraNkFTfwDQj7vk_Yog215VR9NIwJzkBTVtRixOtim1JwR9cGvSCWDLfW1pMwvTty2UXasIVt8ssfDVF8Gil5t35y3z5XFYHepc5waDSpqHWvlg1YPNA81DVXGp56mRpGm64bFVlLkVa2Xs1Fwkx8JAykbjfOTMwY7BOy3ZOBZS4neO409vpuNIS53g814UKVQi65XeH-vNb9xw0UI1SrY_K5wvbh2ng1Wl_b-sdxH6sxasWZ79YbdO6LrTDtj_ONt4XvhimY0q7M9ar_3FJ7_Fal7CvWE7SaNf7QRBY3SAG4sKBv9Ej_n1gMyeHzhBGH4yHtOTNAQR9QRSejL6_qIihE1y4mN0OsLFwzeCwhV0QDimMuVPfwD4CU3c' --output-document=fig6a-diagram.svg
wget --continue 'https://mermaid.ink/img/pako:eNqdlV1v2jAUhv9K5AkJJMIySEiwBtIKqVaJ3azSdjHvwsROsWZslJghVPW_7yQ0n027bLmIsc_rJ6_tc8wjijTjCKNY6nO0p4mxtl-JsuDZ6vMPguBtMf6QUEaN0IqgnxhjGLw31PCr8Itm3wXjID5Dkx4TThkh6gDgJBMRVQcQFYWboTOZjVbOJLjyngk15lpLSY8pZ8MhQWWHoNEI5GW_NuGzeNh3udjD-CsOvJqDYnqLeKcMTwApsvbAmbiu529Qr4LmhBr1G08uWx1RCVSZtSJbF1G_Ydx6gxtk3NmVWzJa3Ffc9kJ7FbrLctfW9uIGFbexv2WOWcslQf5sQNByuSpyqYraNkFTfwDQj7vk_Yog215VR9NIwJzkBTVtRixOtim1JwR9cGvSCWDLfW1pMwvTty2UXasIVt8ssfDVF8Gil5t35y3z5XFYHepc5waDSpqHWvlg1YPNA81DVXGp56mRpGm64bFVlLkVa2Xs1Fwkx8JAykbjfOTMwY7BOy3ZOBZS4neO409vpuNIS53g814UKVQi65XeH-vNb9xw0UI1SrY_K5wvbh2ng1Wl_b-sdxH6sxasWZ79YbdO6LrTDtj_ONt4XvhimY0q7M9ar_3FJ7_Fal7CvWE7SaNf7QRBY3SAG4sKBv9Ej_n1gMyeHzhBGH4yHtOTNAQR9QRSejL6_qIihE1y4mN0OsLFwzeCwhV0QDimMuVPfwD4CU3c?type=png' --output-document=fig6a-diagram.png

# using rsvg keeps the forms but not the text
rsvg-convert -d 300 -p 300 -f pdf -o fig6a-diagram.pdf fig6a-diagram.svg 
rsvg-convert -d 300 -p 300 -f png -o fig6a-diagram.png fig6a-diagram.svg 

# But we can recreate and enhance the text using Powerpoint. From the pptx file we can export again to tiff or pdf 