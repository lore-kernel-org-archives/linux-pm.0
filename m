From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 22:49:09 +0200
Message-ID: <1178311750.7408.34.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<200705042250.29760.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9078114654112933698=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042250.29760.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============9078114654112933698==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xceTg+dd4ZC3NGEXy/uG"


--=-xceTg+dd4ZC3NGEXy/uG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 22:50 +0200, Rafael J. Wysocki wrote:

> To prevent this from happening, we need a separate set of hibernation cal=
lbacks
> in device drivers.

You *can* actually do that now with prethaw and all that afaict. But all
the more argument for splitting up the callbacks as discussed
previously.

johannes

--=-xceTg+dd4ZC3NGEXy/uG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO5xF/ETPhpq3jKURAtAYAJ9LHrICoj/E5IqM8tV2mrMz1NH8jQCgocu+
xlOJLepqVSCZPxliE31et/s=
=ToOb
-----END PGP SIGNATURE-----

--=-xceTg+dd4ZC3NGEXy/uG--


--===============9078114654112933698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9078114654112933698==--
