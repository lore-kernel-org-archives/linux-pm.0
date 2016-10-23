From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v12] PM / hibernate: Verify the consistent of e820
 memory map by md5 digest
Date: Sun, 23 Oct 2016 10:01:22 +0200
Message-ID: <20161023080122.GA25889@amd>
References: <1476951292-19619-1-git-send-email-yu.c.chen@intel.com>
 <20161022030302.GB26548@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161022030302.GB26548@linux-rxt1.site>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-pm@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 2. Another case is, this patch replies on comparing the e820_saved, but
> >    currently the e820_save might not be strictly the same across
> >    hibernation, even if BIOS has provided consistent e820 map - In
> >    theory mptable might modify the BIOS-provided e820_saved dynamically
> >    in early_reserve_e820_mpc_new, which would allocate a buffer from
> >    E820_RAM, and marks it from E820_RAM to E820_RESERVED).
> >    This is a potential and rare case we need to deal with in OS in
> >    the future.
> >=20
> > Suggested-by: Pavel Machek <pavel@ucw.cz>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rafael, can we get this merged? 12 versions is a bit too much..

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgMblIACgkQMOfwapXb+vJ4ugCfekU/yzPi5UaGFXUpuRDiwTSL
j+AAn3n2wDMDjEltMGBNjJbosw3gr7gB
=Gfin
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
