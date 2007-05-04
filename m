From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: shrinking memory for suspend?
Date: Fri, 04 May 2007 12:48:32 +0200
Message-ID: <1178275712.7408.0.camel@johannes.berg>
References: <1177943076.5102.83.camel@johannes.berg>
	<200705031217.30979.rjw@sisk.pl>
	<1178192016.13233.94.camel@johannes.berg>
	<200705031456.51546.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3732638723762291252=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031456.51546.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============3732638723762291252==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-c/kfPDRoTZPbm8vSEHA9"


--=-c/kfPDRoTZPbm8vSEHA9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 14:56 +0200, Rafael J. Wysocki wrote:

> Besides, preemptible kernels are not much different from SMP in that resp=
ect,
> so ...

Yeah, we just disable preempt in the interesting code paths on
powermac ;)

johannes

--=-c/kfPDRoTZPbm8vSEHA9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOw+A/ETPhpq3jKURAlIDAJ4zljArWO3etrttwj68WiU9CivUdgCdHwId
DB2HTKb0pDFFEuFL4Nnu1Zc=
=zo2V
-----END PGP SIGNATURE-----

--=-c/kfPDRoTZPbm8vSEHA9--


--===============3732638723762291252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3732638723762291252==--
