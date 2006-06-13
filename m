From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Remote wake up not working
Date: Tue, 13 Jun 2006 18:12:47 +0200
Message-ID: <1150215167.6305.6.camel@johannes>
References: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
	<20060610132832.GB4547@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852729125=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060610132832.GB4547@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, rasmit.ranjan@wipro.com, linux-kernel-digest@lists.us.dell.com, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org


--===============1852729125==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vCHoafVUmMf4LJnK9EMA"


--=-vCHoafVUmMf4LJnK9EMA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-10 at 13:28 +0000, Pavel Machek wrote:

> I do not think we support remote wakeup these days. Code may be there,
> but as noone ever uses it... perhaps it needs some fixing.

Works fine with bluetooth on my powerbook, but then again, I can't turn
it *off* which is rather annoying, but I think caused by the missing
suspend/resume handlers in hci_usb :/

johannes

--=-vCHoafVUmMf4LJnK9EMA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI7j/KVg1VMiehFYAQLJ0RAAw+5WpymdOFdIs1Oqv4dAUeGL38fl4FcS
ULe0JK2op5wQneAnIcrhgjvte0zKvjemb07N3JikTLhOmhYGXzWXQOz6QF1q+vEz
UjP5pkE0J4n8kloHj3+vgcXJe2uXCDjrcpIhv7rmgIydtGxGoP1jFVoP/0sskyAc
uUMjWb60AD0ZHTCpyF953YYe4idQBgh2LPrYDS27LFRl4SNNNnyeDvc+jB6uXq2D
Bz01DuYsRXYLoK9ty23pqpG6TA+5xcWRUe1WKnPBF0/Xs6ZwBKe+w0mbjHO4jvdv
8cy4fGbXlfUkbjpO66fm8Qz72IrZ9CnrQB8O0sqjBmCmexSCrxDPPULYp9ejNDfT
fxk/s2sQONbWERg2VCAv5vI4ACFDsfwGLz6ScmbYCT4XAeACK6LTge68x6U7eQKS
Mb3R1glDSKBQuBQTw620yaCLa3F1kfIOMZyZc5R6wwHjeCLm/uXFROakD/fK/y8W
2KKJrdW7Rvhr8O96kyatxqV6NgrPkdrOzGbvjwMFNLbPRH5H1FTqC9MQIf8NnJ42
zNVRNbpKzS/Kw71fb5HzVDnWUF+CUG+8sYi3n937EZNIpwNMlmk9DXYBrWAqRRsC
nRygzBrQsvKKTpfbHbpgqLpSczQckJDHghP+BpOwhW7UP8EIfED0osqeQhg/j4Oe
NYDF0qCTYgM=
=Fov4
-----END PGP SIGNATURE-----

--=-vCHoafVUmMf4LJnK9EMA--


--===============1852729125==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1852729125==--
