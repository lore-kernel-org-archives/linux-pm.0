From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Mon, 13 Feb 2012 16:37:49 -0800
Message-ID: <20120214003748.GD11931@opensource.wolfsonmicro.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F1C082D.2080005@gmail.com>
 <20120122152234.GA2915@opensource.wolfsonmicro.com>
 <4F1C45C6.1040003@gmail.com>
 <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com>
 <4F1C4BF4.5040409@gmail.com>
 <20120122213952.GA29022@opensource.wolfsonmicro.com>
 <20120213233139.GJ2999@freya.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120213233139.GJ2999-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2012 at 11:31:39PM +0000, Ben Dooks wrote:
> On Sun, Jan 22, 2012 at 09:39:53PM +0000, Mark Brown wrote:

> > TBH I think most of the devices for which people are running these days
> > will be able to get some win from the system wide stuff - the WFI modes
> > aren't exactly the latest thing in hardware terms, it's just been a long
> > road to getting them supported.  Infrastructure like Mark's PM QoS work
> > and Raphael's PM domains work has really helped a lot here.

> The WFI stuff's been around for ages, and is generally just the core that
> is affected. The deep sleep options might be useful, so I don't see any
> reason not to do this. I also approve that it might allow people to shut
> down I2C units they're not using at the time to save power.

On the more recent devices they've got wider effects if you configure
the device to enter one of the lower power states on WFI - things will
break quite badly if you enter even SLEEP mode on s3c64xx right now for
example as we don't make sure things like the UARTs are quiesced enough.
The power savings are nice, though.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOazVAAoJEBus8iNuMP3djTIP/34ySicxBiw6abdAppgmuw/j
/7BRNbYaumoLxfr2HsC/uTzCeGd6XrtkIMSJsc7uAyuG9TxZNRvg2hFcFYjtRXRu
XrsHorpaZGPZjtTwMM0j/S4SsAhdL7OAqaJ7QCs12+PxTKaaQIHTrFvCU+1pOmWk
2QVOxzJgPz35mrluKjCANt4+K3/vFf2dxt7/fX2jw3k3/aTk7upbdPgu3lXaELfv
CNLR8uyNGQb3JJGCpfSBBvb0OpnWpXJYrYBQXD0i/ygOL6z2c+mYtXVHtmyfNsl6
F2cct9hHu3piEnCtHFyfwRrvP9LyYU5cVBHOMJxOn77+gvLJC0r5XFFjbFDJI/LT
WsMgID6R5oZvF4sOQIiJUG8BF195ZPhP9++HemPIaHWvzDKVIxRsxd1YKGwP5SMg
1zHe9wJuxAOXNrU8DOCBKZEcqaztzceLpPY5Xq8O40Zz2Jqh3H3Gf6Ki/1TYyU+K
nkAyxnaoSbGMeQ6QBKZbvPf0lNiU/UnS56wFy6PiZkfzpnA6WDGixozsba80TVJe
CVGQHm+N0tWfbrp8EI5SEjm82A7H5Azj1w0NzyQdCa8riClB+78aic7QIFA0VLSX
4WDr/SNq+dsmNToNZa06hDJifDdFMuA4iqqOo1rh2LxkoNOzpk5nPIynWVcPCDEI
Wbm7KFccTNE0u7DaFG8G
=0Fe3
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
