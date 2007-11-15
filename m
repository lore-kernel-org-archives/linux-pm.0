From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC][PATCH] Freezer: Make freezing failures
	less verbose by default
Date: Thu, 15 Nov 2007 18:06:53 +0100
Message-ID: <1195146413.13846.82.camel__4794.67327609218$1195146440$gmane$org@johannes.berg>
References: <200711150038.07538.rjw@sisk.pl>  <20071115002531.GA2343@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2435709515936097756=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071115002531.GA2343@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Arkadiusz Miskiewicz <arekm@maven.pl>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============2435709515936097756==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LivpPbX4Vmi1owsEXtAT"


--=-LivpPbX4Vmi1owsEXtAT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > Currently freezing failures are extremely verbose which sometimes is
> > unnecessary and prevents the user from seeing which task could not be f=
rozen.

That's a good thing.

> I don't think compile time option is right thing to do.
>=20
> Dump just the stacks of the non-frozen tasks?

That's harder to do because there's no support right now.

> acpi_sleep=3Dverbose?

ewwww

> Reorder dmesg so that you get backtraces, and _then_ list of the
> tasks?

That'd be good too.

johannes

--=-LivpPbX4Vmi1owsEXtAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzx8rKVg1VMiehFYAQLK8Q/+MPYv0/91Qq3TalzmlRxADN0Yb4jEWilB
hBEyH/5xUbOBgdmXHISCpYtwrmTnSpx8pZcvcmEw/9PUbGqLr7HM6Ec3zVqFYinh
N1rzjzmM/WalZHviTewVJHGvKTSZloxTT9O5PdLsj/hahKPz69c+gBGt/RoB/Gl/
fQD4nUGa0tRl5qEbm4l81yasdhVEXeGSbaBp9O6u5gG7Xzj6cWh/poCoM5wHcA+W
DRGt3fwC45GISx9wfKIBHYworTHaM01myQsTBT9ZxmXCYRw6A+WSFvi2f2TxqEEG
QvgLz+B5zboOT4yAXKzCsNcgPRuU+hrCKPGN+a/ftJh9rbqdVczh18BSL9fMukWi
g4qyQMI2t/2+nldRUw4ddKPSwc65SsRHeKKHs84Qrkmqk21Mh2+k8+2yzcuThCD1
NhU3t8tVIRxKU0Mcw3iouP/B1vvPZ6sb1H1C9/mUDcQVgHk3WVRFa2VewUO7uRAn
WQrss5+d/SM4w+tWoyaGXIHNXoxJaB2vdl0OKofUPtcC8SY/BbMjbRa6Qb1vHLTJ
Aprmnu6eOIt2td1XMgzt1dN3TisrqyyBko16U6m2dLygpKQxKLnP8a2mwMizLZP1
AwsaNtp+ciOBSrLc3U8pFHYaksvTBvs/i7lso+3BDB7Ru5AflDZSsKYMEpQkmv90
OtOWl4kZIeg=
=fNtl
-----END PGP SIGNATURE-----

--=-LivpPbX4Vmi1owsEXtAT--


--===============2435709515936097756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2435709515936097756==--
