From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm]
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 04:25:14 +0600
Message-ID: <20120531222514.GA4879@belkar.wrar.name>
References: <201205292116.33587.rjw@sisk.pl>
 <Pine.LNX.4.44L0.1205311704340.1178-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205311704340.1178-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2012 at 05:07:36PM -0400, Alan Stern wrote:
> Here's my attempt.  Everybody, please try this patch with the
> 151b61284776 commit removed.  Make sure that CONFIG_USB_DEBUG is
> enabled so we can check the controller's power state during suspend,=20
> and check that the "broken D3 during system sleep on ASUS" message=20
> shows up during booting.
dmesg attached

--=20
WBR, wRAR

--bp/iNruPH9dso1Pn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

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

--bp/iNruPH9dso1Pn--

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPx+/KAAoJEDNi9wMaSZLhWrgP/RPF+sTEpv4dDU3T772o7Egl
1s0enm9SHzqmUppFQPl5Dk56dj8Hyx8SSpjMekz3f1SzA7GsfGSQhynmKP/q3JYo
lCP6gpgdEowgxGLrzBfdCjj19GWhg1EIomENFiQMOr45kN1OX9CusT+FGeyPjdQL
5GacPWdI76Xv0g/MF2vMabi7WpjVoA2cXee6WOcQC0I3NDSqTKXsOcT5ZFUJAQiG
Q7XLrNXkFoyFiY5VtRUFpRJQZKqlQV+oLFbwc7wt/GZfd8KDNOepEX9AUoCthtzF
lsi54eM9lZQ+dsvPdt2pABrFyHsY/L1VrJz/IpZEioCfKo3u59fnly7OjvhfgHLX
IiszuHxMqqcknwZ4mg0OC7Vsr6rgL6IdvA5JNtcQGjXo+0xGfYg0ZHvurd8d1SHe
r6UJUSavOHP+vDUwNvcNjCO8rit6XngNCN1b/CL79YftuRM2A0uOfmQDmnzCf3lE
1ueb7f26AV5+5NOgiX47CHRVVq43EUd8yYsQliT7uB9kY0VT26beHaO5jBh/IBJL
p97CfpgMS8B/nBzDQrbuNj1ym0jTmCVNDRgiW7rYKO3upvktgrNh/9SjqUpJX4Te
XwuBFghtvP8j+NgVtrlyJCP8ukOLEuouiq9pSEzRVBWM8aN9RI6t+mVGu/hTnI6L
It6iwWPcpXNQdNqe02yp
=k4Gn
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
