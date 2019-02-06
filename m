From: Pavel Machek <pavel@ucw.cz>
Subject: Re: REGRESSION - System does not resume from suspend
Date: Wed, 6 Feb 2019 22:20:23 +0100
Message-ID: <20190206212023.GA5353@amd>
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>, kugel@rockbox.org, ulf.hansson@linaro.org, johan@kernel.org, rafael.j.wysocki@intel.com
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Since kernel version 4.19, my computer is unable to resume from suspend to
> RAM. I've run git bisect and filed bug report at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D201519
> three months ago, however, I received no reaction. Bug is still present in
> 5.0-rc5 kernel version. Is there any possibility to fix this?

Thanks for all the work bisecting / etc... Note that you can get patch
reverted if it causes regression, but it needs to be done over
email. (If maintainer does not reply, up-to Linus).

For the record, patch is:

git bisect output:
c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue May 22 13:02:17 2018 +0200

    PM / core: Fix direct_complete handling for devices with no
    callbacks
=2E..
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D199693
        Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
        SMART_PREPARE driver flags)
 Reported-by: Thomas Martitz <kugel@rockbox.org>
 Tested-by: Thomas Martitz <kugel@rockbox.org>
		    Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
 Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
 Reviewed-by: Johan Hovold <johan@kernel.org>

And the patch was tagged for stable, which sounds like a lot of fun.

I added Ccs to people involved with the patch.

									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxbT5YACgkQMOfwapXb+vJy9ACfZtp1V+wP4pmoLWtVw7u4H0ka
PS8AnRFvZNV9/mltGDcJjsYQ8XigGigV
=zr7S
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
