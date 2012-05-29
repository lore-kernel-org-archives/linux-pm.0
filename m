From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Tue, 29 May 2012 13:48:52 +0600
Message-ID: <20120529074852.GF5028@belkar.wrar.name>
References: <20120526223611.GF5012@belkar.wrar.name>
	<Pine.LNX.4.44L0.1205271238040.14937-100000@netrider.rowland.org>
	<20120527211714.GC4994@belkar.wrar.name>
	<201205282213.01560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9064717837584024234=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205282213.01560.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============9064717837584024234==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline


--qoTlaiD+Y2fIM3Ll
Content-Type: multipart/mixed; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2012 at 10:13:01PM +0200, Rafael J. Wysocki wrote:
> > > > > > > Andrey, Stephen,
> > > > > > >=20
> > > > > > > We still have problems with this patch in https://bugzilla.ke=
rnel.org/show_bug.cgi?id=3D43278
> > > > > > > so some more testing will be necessary, I'm afraid.
> > > > > > >=20
> > > > > > > I will send a series of ACPI and PCI patches I have collected=
 so far,
> > > > > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > > > > 151b61284776 reverted.
> > > > > > >=20
> > > > > > > Please let me know if suspend/wakeup work for you with these =
patches applied.
> > > > > > I get the usual freeze on suspending with these patches.
> > > > >=20
> > > > > I see.
> > > > >=20
> > > > > Please try to unapply [4/4] and see if that helps.
> > > > It helps.
> > >=20
> > > Andrey, can you try out Rafael's patches 1-3 (with 151b... reverted) =
=20
> > > and see what happens if the EHCI controllers' power/wakeup sysfs
> > > atributes are first set to "disabled"?
> > It freezes.
>=20
> Well, that means trying to work around this through changing the algorithm
> of selecting the target state of a device wasn't a good idea after all.
>=20
> Still, we've found some bugs in the process, so it was worth the effort.
>=20
> Please attach the output of dmidecode from your machine.
Attached.


--=20
WBR, wRAR

--qftxBdZWiueWNAVY
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmidecode-K53E.txt.gz"
Content-Transfer-Encoding: base64

H4sICLx+xE8AA2RtaWRlY29kZS1LNTNFLnR4dADtXFtv4koSfk5+RWn3JUcaGN+5PK0vMEkm
BBRDZlar1ZFjOuCNsZFtJpPz67eqfcFNCJMZQsSsFkWR3d2266t72d39d5guginz4ykDpSnL
p+7Auhi6eGzAMmEpi7LmaasDaZas/GyFLRD7/mr5FEQzUNqKCndPGUubp2PvLmTgZSB9lySp
Z3U0qXl6eu5FU2zmbdIHcAYXkD0tseEDKFp+6Sl/3kV0HycLLwvi6PTklkXTOOmCuWBJ4HsR
DNjMyxJsTXGg36QRSYpDu/BZV3tNRe6cntywkHkpA8fLWBck9aNkfFQkWTk9MadTpDvFxu99
ogPHrqIsWDBwg79wrKHBg4WNw0HRoOiGxJvsuZd4foZUpFngp93Tk5ORfQFBCulquYyTjE2x
iQPAttVylnhTRowoW9O5N40fiVfY74Vh/JhfEccZ3CfxAmxn824u4vAzzs07GrbR3XOeXaE3
Ff1vH+WmAgML7sN4uXyClCXfAh+l5SVsPRjOgigDWZ3/gZepTbyqpRDSn71KabbbP/ewUUIn
qZ8wFpXjBRz5aJ0PbkuaAg/s6S72kunOu3f4eBcF5IW7ydDWZLBk99AWH2rao2eSnrgWhKiL
/tMzqS28JIM7L8O7P+vkqsCFmS6ZH9yjTpOibw4be8mMERl+jEQiJVNUuyS4W20ZzG95w74F
uRloTUM0NqVmbHgs66WxkYlYnK+CyQ28aHXvcQsnw3Mn7ph9BjteLFfEr9zqRkk8RS8A196C
5aZXs0S5KUH+Oy0Fcr1a3NHtLPdaVlRNN1rtjlQcoVmmKctg7M3weeNtA/rM4x6nyy2GSCYj
gnmMxogWxbWj3pWwZej5hf1dxQWTLyJAM07TAB3A4MJxrnog/LiVUzfk/OvmDFRPT8bIPLwm
zuYsKR5mo2S8IEIZDe/+g2ZaXEO+ReS/WuM/Hitywf/yWT/P/Jya6zhjqEkPHOBDF0a5j36d
HOxfkwN5q8ZqCW7GXavr3SN/R+jKEnBRI8MnsWeM7FrgU4VGl/mrJMjyoauUgETYPOwN6qwo
eC/lXvqcBbN51oVJVJgNKX6OBYb3kFNgx8kUbyfXZdML2QKZ8lwqWk0qeIxeJpcKKjY6gzRO
RLm4yGJkjcPSYBYVBNqjCT0sl4aNT0kQanU9Kq23CMKnLtGFlgfOKt6U7wUadyhq4IWDvG+B
ZICkgCRBvw99C3oWWH2kgj8cr+3CuIid+UPA+IDaOcWbaWjibsaWS7ILspzQm3Gz6SO1Z/0w
9shiGsuY/NsqCjKIo4Y/D5bk6G4HPTi7DZJshUgWlAiw7+h+SJuo28Feh92tZjO6udA1crFv
5M3QhWLcFPvGrg1nYwqyaeYtlujTVuR5qWvg3sBZTnjpD9F2Z+jsUIf5fU267/wpRUcZgpeH
b/H2AxuHDDzEEDHw58x/wH6fLbOi3/7ahjN7MPpqn39qQxDl+Qv5g8qJcic/ukAyhzkzgJ9h
yJ8+CmGBh5jeCBnppejCn5DOBSBlISdkfENo2CJGv88VK/Ei5IgI6FPJqFkY3yEmFpGXyoGY
m0C8BM8yxvWFYxkMbxFMHE0DQsCl9I29DGpkjounYTji8YNBVj4PZdZQDThTjcYd6sFyu/Ts
q757js+86l9N8ODFRzluoRwo5TinlsfNM/5fGDoYfEWg+A+RzaM4jGdP4oD+V9IL/G/e9gCN
FvBwPLypPzzdEArpn4uJIZoD6qZ7MXDWMNJihLJjCCj5IBzCwvtGGsUxN4nzMXJwsAqzoJHN
8dopXsuVeoA6Xbi3RYx2hB5DZL1FgsZElQcovPKhEDX1Vi6ae4Czmz+4kzgbD/6AQG8omiwN
uHv5B2bfqvTp/K/KP9zGYYaCQn+Gzv329KSHCBJSBDvkUUBGnzE4/4s8zXdwl4xNMSWQykZ7
lSSUThQdilp2lL54FC9XITrr6Qfo5dSenkzyZLYLQwp/GG5ksFFLmRgldexQtnUY2KFudGDs
Ik/5DeuN6bPYNI7BYtAPQnw6WE8wbPaag6YQnV4aMqLU60f34f7YJieEHChOC7A8eoy5nOsj
nuf+hsZtxveWPMcQQoteCy0tTLg6ZcDnLPhhWLmSG3wkD2P3wWyVFB0FjR849/Ir6eyKfUP3
iXQPlywfirwkn9qFLxhnMcfz/Id1FpTrHKkMBhu0J4+zJ692VIXXOqg6wWK1EBvdKjV2b8wB
jz+cE4VS1G5VdlcKU2jbJHqI4kdE3UuSmIfrhOWOpExoKA9wc6eaN02iItaj7GM/QADfMHPo
Qrvx6GECwbKGV3VsSMHYUwrKr0hB2SaFWy8JsL74EmRzKKJDUYe+TipYg24RS9n6u8mlVZOL
rBg1yVxEaGTPxrdr4/G4HDxCzEhqFCGpm8layUqsiu4Z+jusL0vZ0ruES9mUa4PWN6nDrfzq
9nuMXGUQr9L6wM37jNyPCiXHSGdZPuAFQA0iws5RIvxcFN0/g7C8ZgtI8xAgFXNflEXo4fS+
DNSxGh3ASM8EtLVrQTZ0XTJ5oYbUPwsJ1kHQW/uiv8X4G+/GLetwz55B5xdukbL99jhVU9kX
5jnStANl4Q1fAc85BDx1X3gT15J3wDN9KkjBWqVwhkP/EJBigwixd6wQlTeD2D9WiOpbQZSl
Y4WovRlE+e0havtHTSRTfzOIyrFCNN4MonqUEK/M6x0Iby4bmi7AumbZY5w8PI8Ysvb2+PT9
8dVeZIMz+qnQmLcIGPW3x9i+3Buja47NPDeTwAmooinvswOva7of8wvD1QxvTK8RPX8z78MB
IgeMt+dAa38OsDULdrndX8TcenvMxpti3hVNfxHzIWrR/t7prWnDxS5/9SojPkARqlsyNGBk
n8Pl2Py0A2VB4A9g8vct668/L8LNebYb7QGq0Y5JaMejwcfR8GYMbemoAB+gAO30NAR87pig
fG3DOfOm+fumo8F8gGK002sVmNujIDpG0AcoUdt9uQCdF9JHhPYA1WqnpyJal8818rIk+F57
E3ZEyA9QxLZ7JGd3dEGfZmaJtzgmwMoBStpOT0fAVyMbzpFQJ/Yfgmh2VKAPUOR2PikFaPfC
6YFlXjtHBfkARW+7X0EO4+yo0B6g/m2fq0Xa9ZVquyMCe4BiuPWJ+6wq6d+VTL+c9B+KB88q
COUAtXKLG/SaBbtqqGNgwQGKZeO8pgWPx5WRKQcolPVLwtsfHWECqhygRta4eM3x1yOU7iE+
3l6SAzdvB/ZRIT3EF1wuWMscj2HXt8z3x3qI77XnSol111fr98d6gDJZ4VGZJrD1veiowB6g
PJYdMtdjy7UOUBlrtyTVYgYTZdI7U433h3yAkli7VTYg70ow3x2yeoCiWLN5bmFew+jLzVGB
rRfDGHblVoG2mJnGxSNAFSb0Xep2NVn/u2wArd7qfV/y+eR4vp4bO0n5/FrzmxeExQISFs2y
eReuYv56wKHFBNsmhapNFW5p+cmymtpK0wGjYtFXilfwttGgB5yycHMpzyqF9RI1/HXv77uS
2hTXLqjKfowwbGXNiDofXsMDd86nShET5PdigiR3ZX+TCeqeTHBey4SLCI+2c2D73OBDcEAh
DsgiB7T9ONCq28MeaqC+oy0gExSRCfqeTHi1Guxmgva+TFBFJhj7OoS30QT9fZmgiUxo7ceE
9torqgqf3P+jCLHpGNbhwXg3v6ASI3SREe09tWFi/Z5xUtoMEZ39GCHr1qTihPY7BMqtXDD3
5IJa48I+3uH9gqW0hQv1ip6mRxoFF4ZRsQbaYXwhusCJHHUxS7pcIlWti0I++UmwzPmEvxfW
Gwlk2L9ORo8y4ohla0qcIN1GymvocH6dDjdeRdM3Yke9ZKPpjrqom8LSGxjye6e0xIafy8gB
97oLP/gJT9TqoZI+r5XWYK2CMGsEEYxoZSxpX86B9dpvvtqDl0P3ns/K1Q/WKsuQKEqDhOfU
oxEl7IokQuP7PoirkKrl0MBoIU4KU0ZLP5G3wvTlehmEx8qGPb/jWn79WjJdWe10ZFXuWMWg
yYSM3bZNW5baUqNlGnajLfekhoJNjb5mOJKm0qfN1unJF++B0XLynMXFOvLHIPPn+LDPk+pJ
Lwi2WmH9WdSq+rsPmidcahUtMXezBIWbErvpgJRo46ZFh/JSh/pSh9aFjnSt2qajal+UltK5
dWTV/GfVr3drg436Sat+0q6fdOonstTdVOf6CwCahljt7lCtmS5XnCWJ91Rfb1bpIVn7MBE3
N8C8phqR3+AHq8PKtWm2t/R8vhRMVeCTVV5VU8oX1oCuF/PndpdSTi1AFfQezUtpF1ALhKW9
cqTCElRNej0d4zhDpn0JphS9DA0wEURlcbzMe9ZYrMOTNNoABZUR7wx9z+fvPdyhczEYkMlk
JYs466kPo2AUsdBs0BAkzfKiB6h6LfP6M+VNOXcd56bYfgLxZRheSSyRP0/iCB1StYRPVlW1
XPZbt/heuAym3jPL1U1F7bccWVhT22m3DF1TFVnaWEfbsy4VedJrW/2J1HAuG33UyBukmUK6
ICHl/SVUrV2sS6hqzCWEDnWAHi6kaFYshtyQ1itlJW+VVVU7VY8VxFWsntxYaimK6V+9xTJ7
+vczOVXtrxFTNTiXTfkoQULq/5gNWTtsSHkHG+pQQfSmNqT9z9qQtcOG1N/IhupvnGhWWrV+
WZAQDLzlEhPfaqU3pncJzytre5BJ6x/KLt8qQuzuFz9O0azcpkzjobUK8cUTBWXQkD+1yL9B
jji2nXOBbykCN/EjZmJpkGcJ5ReekHnf2EvtU+Ca47Alac6GQnf+z65u9dXox+yqv7yhSflV
QreDvINya7ujWTOg8BcbyZopFHaIo73OwRvVVj9k5LS5E01i4fu8EGPorUBbBqkNmkk7IEky
/1Pwf5kJ8zcHfOuUP023Xz/+E+sjkRKh8KcPZlUl9kpSFJA10CwiRcEDGTQHdI1TVvszdVD6
SCVeUWsWSRGKf/qcZWg/R4oKmgSaTfdWZZGC1iZBqkEb6bTpUOuAbPOdpMo/ZKgiPb8B7dnj
gKTxP7Hfbpe7UfXr7SJcaOXiyo8N0PG/AoZ4hcAS4T0E7Y5W7sPFd7W7QrVc0bZEQlFbtdbe
OECf92ONe3eXoH17/N1QEav4DorlVfkOYSeMXlEW76/Cp3VUq8Z1gYYIxAp1Jc3rKsWH1kWV
yzjfC+a/56VN6ElTAAA=

--qftxBdZWiueWNAVY--

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPxH9kAAoJEDNi9wMaSZLh6IwP/i96U2eW49/DOIisnz2IXFm5
hYbYnDO1AaDKDoB/an8j7E3S6GIrd2uUwwmlQBSFFjp34hKduBhR2T1K9NUks192
UsXvPiXwqMBre1XhFINRvzI3Qg/e1RoAYLmk/qiSP8hghmA5FQKSMt0O5TORgCmL
wadnc8+h9jMBL/DhCWfmP3QMHjHThAKOAD+7qXuhkE5IFlr1eXnoiWWYvYUrCuZ2
9Hz6k5q7Adcen7e/bNNcyhNPdjvzTsKLFrP2IgWj8EqL1CRjtYp1+BK7TVRI3o2R
BmdIl70ElegVCLp30WK5la+7dJm7PG+Qblb7/wuIfXcqw79gD/hv/DsJ2jm5XHp6
MDrtXv1yZJTbYeYAph+KvmqgeI8o+R86G7/bEZPCM+LsjjTrbNqnsg14/8ehw3yj
z7VQoDT2jF3qdpHyUcJLq2YUDJ2mDI2M5NuQvmxEoLiVXyO5tufXtnhiuh4BvT4i
ByyKGSRgm8Uil/Ke3/TlsErmgQQKEiBrZlVLPNYMgjY08ZQgfdtceT2n6ussMpyI
ZlLutvfmlQhl1xlrsq4IAQijAyvjoJqdCGRsprHedRgOQX1n+uiEaNMXzywvpGs5
onFtOM4ieFFQKHgyvFn7KCI1UNCUzkSEXll4ggzctHDYgM6Pio5vL206+3A9qVQN
wW8A8y28LBKQ5GQKimdv
=rNtS
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--

--===============9064717837584024234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9064717837584024234==--
