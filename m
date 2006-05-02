From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: /sys/power/state contents
Date: Tue, 02 May 2006 11:07:36 +0200
Message-ID: <1146560856.27351.78.camel@localhost>
References: <1146300258.5019.16.camel@localhost>
	<200605011531.00656.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45664633206676086=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605011531.00656.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============45664633206676086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Wm4uMkuUblUYJEf+JzQR"


--=-Wm4uMkuUblUYJEf+JzQR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 15:31 -0700, David Brownell wrote:

> You mean, exactly like the valid_state() function already does??

Which actually opens up another question. Why is the default 1 instead
of 0? If an arch doesn't have any callbacks, why announce that it can do
it? It would seem more sensible to me to force an arch that wants to
support this to also have a valid call in order to announce it. Not that
it actually will work, but why even show it?

johannes

--=-Wm4uMkuUblUYJEf+JzQR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFchVqVg1VMiehFYAQLtJA//S5DOSI1PJQAzvXzkk2WEIzCDl5/lAP54
kVXuFIWuEqX8PP31BqhHdtMsZ3qs0FYesdD4gSxjRCFJrmjc/neuFLMncCO407PI
mz3eLQYo13e9sC2JQhmGn/aP2bio3kH9w54/II+bS+H5euzP4ceSoDz2J/8K+JG2
PiZVulex14y2YPcDLTRtf3GeVzVP9q0ru9ELwMUz/JJ1cS/u14zAMsjAKJqmHe9+
0ndoJGSpF3IWnkO0ahf8j3Lf3FkJSwqZJNrlykVOmhsZB2iuml2PDCqqSKkxi/VX
T9wVOQt+j22A5moV4DN/uwBhv5oll1cjjxKUC5zs2QgxfGB4vdEwEoSzRaQQ6z0A
OxYSPDxMO7MJ7AydWkuE8N5S78Fw1JGxRe7YPFu5OZnjtzqJ/725YKY75UPfFdfi
TtRyxg5fesF2tMdXKhBtZGoCooHdJFm4evJvFbQp/xMoaiaYS/XlurUO52Z/tJJ9
qsSfTG1IgVP5nMAr4OugLg86FgT1dnoskbEGWw6v6pOZWs2C4fRwePRwX5bpyCqk
w8GZDEp5w0yw8bxJ1c4zAFIT3o1iNgtCKk9v0/lqmXwXcfJ6QNIY/ZrAK5GQEyfI
fnn3wx+jNWKwP0P360bpaxtmLuiqAhySZIsSdMwqkpVL1H/Ns2C7o9aQ1e1QCDOL
K9JxCWy67Yk=
=VW2G
-----END PGP SIGNATURE-----

--=-Wm4uMkuUblUYJEf+JzQR--


--===============45664633206676086==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45664633206676086==--
