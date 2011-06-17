From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Sat, 18 Jun 2011 01:19:05 +0600
Message-ID: <20110617191905.GI4307__12067.7026258365$1308338408$gmane$org@belkar.wrar.name>
References: <20110617183329.GH4307@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106171447210.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2482207423705626506=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171447210.2143-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============2482207423705626506==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2011 at 02:54:41PM -0400, Alan Stern wrote:
> > After "usb 1-1: usb suspend" I have a message after
> > usb_set_device_state(udev, USB_STATE_SUSPENDED); but not the message af=
ter
> > the next line (msleep(10);). This is at the end of usb_port_suspend();
>=20
> Heh -- you've just reached the limit of my expertise.  I have no idea
> why msleep(10) would hang during suspend.  It sounds like some sort of
> problem with the clock/timer subsystem, but whatever it is, I won't be
> able to help you fix it.  Maybe Thomas can do more.
I've removed that msleep, now I have all proper messages up to the end of
generic_suspend() for usb1 (all in a 0.01 second) but the system still
hangs after them.

--=20
WBR, wRAR

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+6ipAAoJEDNi9wMaSZLh7QYP/3DQT+4+D3BLYvfBwMsbP+NP
kumfJSByo1XBdjxD3Q+lLyhpxaAOiEDFX4Ck91fVfKdMgPa2g8vZs0RCrYHKYVzF
a95gCr35uHy/bu0ycyroJNMkP64AoB1dRHfGRpj7Y8WbeS0Hi7qj5QiZwHht/Qbb
rmijKhZm3qVfJk/qvGJCUfyHK0Q/rWWLEFde6UIKJrApTraC//manQb1RBpqrCv2
erf3CvA6Mjrbl4H5LBDuTOFiaKMJTqiE7LOfZiMHed2CLOS8upBk+rYUbnxrw5be
qN667Ox5uf7ZpClAmTJspYmPIfaUMR7nx4cWTafLQUCjNkAJB6nFu6dtVJGAK+Lw
ekKMP4T2mhqzPZRQboWr1f1uwOOSglZ2Nu3t6u2CVu3wEWO8nJOvpfHtPPUJXMt3
l2w65F3G8PfEGOHdqTJKroDL+4h+rslwX18rf/8C5aXP3Pl9MDrQNSyoy96XWuFJ
e5Z5iQw+QEXINgHR5s8knh6FPNYm534uRWi+RMA27SByJT7SQRgnWTvJmkpiHsUD
xjRkjtAdMiVlUw4Wu+zaQyovgBa9jQ5ImmEv6YaljGO0wH6lP1a+rvGyA3sW5a40
p4irkw9znexbMdbtG5LvEq1xk8fkipW/xlaCATqM0fOE2pkIUtMTMZMLJ9WsaW9M
mNad0mrf28QYQz34h/TQ
=Df7S
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--

--===============2482207423705626506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2482207423705626506==--
