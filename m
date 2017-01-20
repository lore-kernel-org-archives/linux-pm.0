From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 13:44:04 +0100
Message-ID: <20170120124404.wmlpiuqyizi7uhyi@earth>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tz5acogfm3x4beis"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbdATMoL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Jan 2017 07:44:11 -0500
Content-Disposition: inline
In-Reply-To: <20170119232934.GA18102@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>


--tz5acogfm3x4beis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 19, 2017 at 03:29:34PM -0800, Guenter Roeck wrote:
> On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
> I actually have a set of patches somewhere which transforms the remaining
> direct users of arm_pm_restart to use the framework (unless I removed it
> from my trees - I don't really recall). I just never got around to submit
> it, and then [2] happened and I lost interest.

I found a patchset from you from 2016. I see a few Acks and no
negative feedback. Looks like they only need to be uploaded at
Russel's patch system?

arch/arm/mach-prima2/rstc.c			https://patchwork.kernel.org/patch/8844441/
arch/arm/xen/enlighten.c			https://patchwork.kernel.org/patch/8844481/
drivers/firmware/psci.c				https://patchwork.kernel.org/patch/8844411/
arch/arm/kernel/setup.c				https://patchwork.kernel.org/patch/8844451/
removal of ARM64 arm_pm_restart		https://patchwork.kernel.org/patch/8844471/
removal of ARM32 arm_pm_restart		https://patchwork.kernel.org/patch/8844391/

> > No such thing exists for poweroff. Guenter also wrote something for
> > that [1], but Linus intervened [2]. Anyways, pm_power_off is at
> > least architecture independent.
> >=20
> That was by far the most frustrating kernel development experience
> I ever head :-(.

Sorry for the reminder.

-- Sebastian

--tz5acogfm3x4beis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliCBhIACgkQ2O7X88g7
+poKThAAgg3Y6c7OzpVzxSfVwGsb1NYJk9B7hIeSW5lq5qs8oz06gsf0FYA5NYPC
v1SBelyim6CQY4V83TlB1YTi7PqQRLWDBEOng7Cngt9G5SuXDMY+33OfANG8RD4N
LcWohVTUnoDbRKr+YKk3tsoWSW4ttQKBOV3HKmDATpEBO1s3saL2feEWvUy9NQpm
yfL+hWL8ALazxvZ5aLz4X/aRkGTKOttfj2KKxKi/4PZ5/5fcmYrN4RUtD+qZPS+u
/dyKVXMiVOrtsC0lk6vZkRB7Tke30R9Nd6f+PJ0D3RNFJmWrlAFWwFStlOdhVKic
TJU41zpxd2QaR2DbKdMCIf+t0cY7RYerLMSwsms0QySAkgM0x+k/0/dSBx3XkXNF
TDTRpEYpJdoXz89Bk0yPb97JdNJTa1CuMEQb0uLf53ZJPLsCgn/V0ouyHHcYBKG8
TywzGViqOtxaqAIZXaicCFAyHrBORcjTr8ewhdqok4mwnCBsU4ibJQxxDWXvnVr0
uGNn4uLZi3Bn8bFSsQ1q9rpUtC2WHRIIidi6vNKTZZ6aqPqZjKZvexy1LHC/FM98
DUUvRU5oXCRiufI/FIkFVidWIm5+IU9fm2GZw8wXeLp24U7iQbZBPQeaJNHsiGp/
Fsi6M2b5l+l797n3LU4e7Li7LTvBKcDJeuCwKJdVXks9lfXiorg=
=RVlC
-----END PGP SIGNATURE-----

--tz5acogfm3x4beis--
