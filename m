From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] regulator: Extend the power-management APIs
Date: Mon, 9 Jan 2017 19:17:58 +0000
Message-ID: <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34r3fwwdxgmnb23e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33662 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423308AbdAITSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 14:18:16 -0500
Content-Disposition: inline
In-Reply-To: <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--34r3fwwdxgmnb23e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 02, 2016 at 02:57:12PM +0100, Boris Brezillon wrote:

> The idea to solve #2 is to allow runtime changes. Since this kind of
> change is likely to have an impact on the whole system, we require the
> board to explicitly state that runtime changes are allowed (using a DT
> property).

> Allowing runtime changes, may also be a problem if devices are not
> suspended in the correct order: a device using a regulator should be
> suspended before the regulator itself, otherwise we may change the
> regulator state while it's still being used.
> Hopefully, this problem will be solved with the work done on device
> dependency description.

I'm not sure that adding an extra property is going to help with the
problems here - the system already has to provide explicit support for
setting the suspend configuration so that should be enough.  However it
*is* a bit more than just making sure that the device suspend ordering
is good (though that's definitely part of it), there will be things
kicked off by hardware signalling without software knowing about it.

Anything that doesn't affect a hardware supported runtime state probably
needs to be split off and handled separately as that's the much more
risky bit, moving changing of suspend mode earlier isn't going to cause
too much grief, that patch should just be split out and can probably
just go straight in.

> + * This function should be called from the regulator driver ->suspend() hook
> + * and after the platform has called regulator_suspend_begin() to properly set
> + * the rdev->suspend.target field.

Requring these functions to be called from every single driver seems
like we're doing something wrong - if we're going to do this we should
find some way to loop over all regulators and apply any unapplied
changes.  Batching things up at the end of suspend would also mean that
we'd be able to minimise the chances that we get the ordering wrong.

For the target bit...  we should be able to find some way to figure out
what kind of suspend we're doing without the platform being involved, a
callback from the PM core would be helpful here.

--34r3fwwdxgmnb23e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz4eUACgkQJNaLcl1U
h9CADwf9HGYubSkDYTENKrFI46noC5XLAjUZ69nwGXQqLTPuFPP1bu9JV7Imvou+
jDaxjwGFhdREstIopvO8/0fq3ms3FEHooSzr86HJ86yoLpSfCPPjlJupU3+gZSdw
AwF6uTGFYo/u2b/wWAlBaWjiQ6CaGDu+HLX85hPgPlQexr3fAMXDfjOJb4gdiFYo
tSZUtO3wk30+xhw9lluHxZi48RZKyGoOPvMv1z/VpAHAs+zG1fB3VWq1Z1t++qdj
lvodDwcGzcqukHdP6Wptu7GolcOejYKX+Kfa/e/yWC0kbpXLgfIGhwbZt8ZUX7Qd
Oibju3R5FmC8rzv80tDBvfW80QogAw==
=YWqK
-----END PGP SIGNATURE-----

--34r3fwwdxgmnb23e--
