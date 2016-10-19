From: Pavel Machek <pavel@ucw.cz>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Wed, 19 Oct 2016 11:42:27 +0200
Message-ID: <20161019094227.GB1461@amd>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8691348144616098884=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161018104539.GB15639@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, yoma sophian <sophian.yoma@gmail.com>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org


--===============8691348144616098884==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-10-18 11:45:39, Mark Rutland wrote:
> On Tue, Oct 18, 2016 at 12:00:02PM +0200, Pavel Machek wrote:
> > > >b. in arm64, if some platform has its own suspend flow,  couldn't it
> > > >adopts arm/match-xxx to register its own global suspend method?
> > >=20
> > > No, PSCI is highly recommended.
> >=20
> > Relying on firmware for suspend on x86 was a great disaster, lets not r=
epeat
> > that mistake. arm32 has better powermanagement than x86 ever will (see =
Nokia N900
> > for example) -- feel free to copy that code from arm32.
>=20
> Quite frankly, copying hundreds of lines of board-specific code
> (including assembly that won't compile) is unlikely to help.
>=20
> So far arm64 requires well-defined, standard, reusable interfaces (e.g.
> PSCI). That cleanly separates concerns (e.g. anyone can implement the
> backend without mandatory changes to the kernel), and keeps things
> maintainable.

Either the lowlevel suspend code is stable and bug free, and then
having that code is not a problem. Or the lowlevel suspend code is
complex enough to contain some bugs, and in such case it is better to
debug and update it with kernel.

> ARM publishes and maintains the ARM Trusted Firmware [1], which anyone
> can use and build atop of. It's open source (three-clause BSD with DCO),
> and accepts board ports. You can have a completely open stack,
> regardless of whether part of that stack is firmware.

If something is called "Trusted", it is not trustworthy.

BSD is better than closed source, but it also means that you will not
get the sources from your hw vendor.

Being separate module means it will be never updated.

Being separate module means it will be hard to debug, in area where
debugging is already pretty hard.

Can it do advanced stuff like deep powersaving on N900 idle?

Just don't do it.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgHQAMACgkQMOfwapXb+vI8AwCgtAayrm/l6wLoSn3/lczM2eSv
G9QAnA/jGiDOPwrLS7OgHLx5aVYKt0JA
=OT57
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


--===============8691348144616098884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8691348144616098884==--
