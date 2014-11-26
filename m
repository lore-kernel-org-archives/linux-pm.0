From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Wed, 26 Nov 2014 11:10:32 -0400
Message-ID: <20141126151030.GA3925@developer>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
 <2189780.D9n5NYrXn8@vostro.rjw.lan>
 <1447952.pbyqNN4RJG@vostro.rjw.lan>
 <CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:59256 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbaKZPKm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 10:10:42 -0500
Received: by mail-qa0-f50.google.com with SMTP id w8so1985563qac.23
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 07:10:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Viresh, Rafael,

On Wed, Nov 26, 2014 at 11:27:42AM +0530, Viresh Kumar wrote:
> On 26 November 2014 at 03:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > And what bad things are going to happen if this is not pushed for 3.18?
>=20
> This is what Eduardo reported in one of the mails:
>=20
> ---
>=20
> As an example, I am taking the ti-soc-thermal, but we already have other
> of-thermal based drivers. Booting with this patch ti-soc-thermal
> (of-based boot) loads fine, but the cpu_cooling never gets bound to the
> thermal zone.
>=20
> The thing is that the bind may happen before cpufreq-dt code loads the
> cpufreq driver, and when cpu_cooling is checking what is the max freq,
> by using cpufreq table, it won't be able to do it, as there is no table.
>=20
> While, without the patch, it will use wrong in the binding, but after
> it gets bound, and cpufreq loads, the max will be used correctly.
>=20
> ----
>=20
> And so it looked like things aren't going to work smoothly in 3.18
> and so I thought we should get it in.
>=20

The bug exists, it is there for 3.18. But also, as I explained in that
thread, the current code is able to initialize the of cooling device and
to register it in its thermal zone. But that works by lucky because we
do not have the proper return code checks in thermal core.

> But probably the problem will be worst only after applying Lukasz
> patchset?

The bug gets exposed by his patch.

>=20
> @Eduardo: Do you want Rafael to apply this for 3.18? or 3.19 will
> work as well ?


I believe, for this case, 3.19 is best option. Looks like we have a
possible API massage coming, so, targetting 3.18 would be rushy. I'd
rather think of a proper way to fix this, scalable and that makes
sense to everybody, even if takes extra merge window, than rushing for a
fix that we may need to revisit it again in near future.


BR,

Eduardo Valentin
>=20
> --
> viresh

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUde1cAAoJEMLUO4d9pOJWDnoH/j8nsuAesnM02jqnpWqVj9Q7
gC3ZRQs/uezDVplnm9pJGiWyib6qusFwYhyLEKAIuaN4gEhemR5u4lr3r05B0gdh
Ya1d6Jy77/jZ/WAZHvi4iiWzHBkitMK8iARVTbMRCQw9arZfWrKhhWc9viHQ5JBV
ZC00jRCHSM/+XjNmnlmIah8iq3iVHVxK+LvCqYGfvCOaAbsVWHhQu1qyAwwyM5fy
r31XmCtm4+IUMM3zja8cI3KZDSju2WA6Z/eVgtrCPY8IRhrYhJF/FIKA2W+8DPZD
vEvCLWmSbYS+/sjizqjQXOuyjXau73VpNREEdJODGI+NeFMxvyRCbxPgdnAYq0U=
=NEpA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
