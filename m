From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: rtc suspend()/resume() restores system clock
Date: Fri, 23 Feb 2007 21:24:35 +0100
Message-ID: <1172262275.3870.65.camel@johannes.berg>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
	<1172229450.3870.5.camel@johannes.berg>
	<Pine.LNX.4.60.0702231927220.8712@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1549794615=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0702231927220.8712@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Torrance <torrance123@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============1549794615==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JjbS1zQ0owr6QPZ/V+s1"


--=-JjbS1zQ0owr6QPZ/V+s1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-23 at 19:31 +0100, Guennadi Liakhovetski wrote:

> Johannes, is there any special meaning in "migrate all of powerpc to=20
> genrtc"? Or is it just porting every single rtc driver to the generic rtc=
=20
> API, moving it under drivers/rtc and adjusting its users or are there any=
=20
> global changes required to arch/powerpc?

I don't know. powerpc has some platform-specific rtc hooks that will
want conversion (or deletion?), I think.

johannes

--=-JjbS1zQ0owr6QPZ/V+s1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF302D/ETPhpq3jKURAo4sAKCFgLQ4ijCOpAuiNu9f8FhP0h/IzgCfTJYH
HgAnaJqH7UX5RnEWy+kV9zE=
=Fm8Y
-----END PGP SIGNATURE-----

--=-JjbS1zQ0owr6QPZ/V+s1--


--===============1549794615==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1549794615==--
