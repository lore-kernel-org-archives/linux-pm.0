From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/power/64: Use char arrays for asm function names
Date: Thu, 11 May 2017 22:13:38 +0200
Message-ID: <20170511201338.GA2285@amd>
References: <20170509210051.GA36504@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57644 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdEKUNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 16:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20170509210051.GA36504@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-05-09 14:00:51, Kees Cook wrote:
> This switches the hibernate_64.S function names into character arrays
> to match other areas of the kernel where this is done (e.g., linker
> scripts). Specifically this fixes a compile-time error noticed by the
> future CONFIG_FORTIFY_SOURCE routines that complained about PAGE_SIZE
> being copied out of the "single byte" core_restore_code variable.

Can we get equivalent fix for suspend_32.h?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkUxfIACgkQMOfwapXb+vIuYQCfaCErpuuOOist7cZ4+b03T757
3XgAoJ4rZW4lPokaaaDuhXUCgm+Rn6cR
=AuNX
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
