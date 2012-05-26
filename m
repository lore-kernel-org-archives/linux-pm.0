From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 26 May 2012 14:51:35 +0600
Message-ID: <20120526085135.GB5012@belkar.wrar.name>
References: <20120419163055.GB11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405886424400478599=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============1405886424400478599==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2012 at 10:01:44PM -0400, Alan Stern wrote:
> Steve and Andrey:
>=20
> It turns out that the proposed solution for your problem causes a
> regression on other ASUS computers (see Bugzilla 43278).  Rafael's got a
> proposal for a replacement.
>=20
> Can you try out the patch attached to comment #61 of Bugzilla 42728?  It
> may even allow USB wakeup to work for you (but I wouldn't count on it!).
> Thanks.
With the patch from #61 and with 151b61284776 reverted suspending works,
though USB resuming doesn't.

--=20
WBR, wRAR

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPwJmXAAoJEDNi9wMaSZLhMMAQAJB0E/ADkH44yJ1ocXa6ZWJ2
vUWdX/JdmiaA8GSkUTfxmBFBsPQdYrkgzQukv8WgyOBdGMzQ1brcz2slG0EurhJM
gYMEoZKyAlSUqoGHmPYDIQ7qPnE4Kodj6Nybb/oSCBktLHoCTPDj0BaE1oyrJOb2
NdtbzAQU/yPSq4H89Agv79CrMRO6CsFkiRh/oGBYYq/BXb/FghE03uh6tJjmLfgx
Pdp7MfPxLrKaM+G0GUNIaCcaTuOEToRpsSnsBly3e676pf1RjmdW330ipIBuuNYs
qgt9MZTpmaUcE8tLuPlkm3yJ2gy+OOA0P2yMI+pyrKDmzlirrQnHV+/OzjT5rvn3
d/0WxLA2I1WaHLfl95FfFFhdV+M0Mlz/HZuYU/aOzu5cMU0qzpJ6280HohlCxkb9
hkq9Kp6ToPFbzyuTPXYOKflh9oHexUeQKLRdsZu9xSkg83QYRkxieNCy5ZM2F29S
kqbq1BhTQW7FeWW9aTFl5fXGIAW2zD93om3h1f5x959bZ5lPzTwRiAGUFbdEsrZi
ocuTsZUTgEzcdZdpCOWbGQdlUsznq3S4SbII8E5rHg3BuUN6DbqVkPhcZv26ghKl
nyAlEeYUzr0C1r+UezGfggX7v0O8aKwpzvtSm8O5mpzxvWIEWp5xrhSDSziXXjP8
iuH8AQn25wa9dWzVMCDV
=IUZ4
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============1405886424400478599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1405886424400478599==--
