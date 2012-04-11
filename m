From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 02:52:04 +0600
Message-ID: <20120411205204.GB3677@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204111324100.1351-100000@iolanthe.rowland.org>
	<Pine.LNX.4.44L0.1204111429510.1351-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8285303724542861156=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204111429510.1351-100000@iolanthe.rowland.org>
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
Cc: jrnieder@gmail.com, greg@kroah.com, linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============8285303724542861156==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 03:12:13PM -0400, Alan Stern wrote:
> You can try getting rid of the call to pci_prepare_to_sleep in=20
> drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq.  This will prevent=20
> the controller from being put into D3hot and might interfere with=20
> wakeup detection.
>=20
> I don't know how sigificant the difference is between
> pci_disable_device and pci_disable_enabled_device.  Probably not very,=20
> since all it involves is whether or not to disable bus-mastering on the=
=20
> controller.
I replaced the hcd_pci_suspend_noirq call with retval=3D0 and suspend/resume
was successful.

--=20
WBR, wRAR

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhe70AAoJEDNi9wMaSZLhy40P/iWX/TEMe99596pbVrdb37NH
EAv+AthFn9yjd0kviBgFApRz2k0EgZj9wE0HcnBhNPazOwRzpcqY7bpmGu6r0mDi
zAJCx6hOgM4B2qjKvVo4stDt/WGjsYa6CfwXBoZyI4NacNjW0ERmT02oAFQjdZJv
j+ZtHAd/ZwlXMPnma4zUL9h+WT/ukWUsdkyYdMWIc6Us7NsKk9bu+D7wqbB2pao9
02ywN+aYhETxgt/k79qiMJH0WKSmwRktsuaCQTR0cObE3RURlMALe8tIrkRbbmsH
38shIgpfk+/+/MPYyg4wWQE+XGrwWCXU/s175hdwIsBxQFdJCt6HyePaexctGbBP
mZhyRcbOd/qtY9XXQgWCIZVeOLlBFWZHzEB0NkhPHdlrV7wAe7dgvIUbga54Mxpw
LZFc71hp75D5TEaXdNEbGkc66wAZOU3xiUZZwAW/fsDL0k7wrmmwKkeetnn9xxeG
TNNFCxERfGCLWWFHWt6M5ecKvly1kwugMElIQ+nAhICmEHEHt3Ku9ZY/uuXItItx
SEvTGUvdFz2xz9uWKVUSFKnKlT9rRW6BhxSsicZwW5D72zgfV1Mrm4KuOGYQxJxB
f8NMk+mqxffK/DTjpIZOLpxU54pdljJUhRswsfwU9vhnTwxgRUkIlcltqC3TIHKg
2563IL6/A/EXJLwQsO5y
=yTVr
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

--===============8285303724542861156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8285303724542861156==--
