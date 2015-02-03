From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for
 module build
Date: Tue, 3 Feb 2015 15:31:25 -0400
Message-ID: <20150203193123.GC3486@developer.amazonguestwifi.org>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
 <CAKohpokgNwdYnc30yd72eJJtpwcDAHx=PmCRWRWPRuXLOq9bnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60444 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966273AbbBCTba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 14:31:30 -0500
Received: by mail-pa0-f44.google.com with SMTP id rd3so99869938pab.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 11:31:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpokgNwdYnc30yd72eJJtpwcDAHx=PmCRWRWPRuXLOq9bnw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Linux PM <linux-pm@vger.kernel.org>


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 09:35:01AM +0530, Viresh Kumar wrote:
> On 3 February 2015 at 02:28, Eduardo Valentin <edubezval@gmail.com> wrote:
> > Dear all,
> >
> > The exynos cpufreq driver needs to be build as module. The need is to f=
ix
> > the problem risen by Arnd due to the added OF thermal dependency [1].
> >
> > Therefore, this series, in preparation to allow building this driver as
> > a module, changes the way this driver handles allocated resources. Now
> > it is expected to free the allocated resources uppon driver exit.
> >
> > A couple of changes in the data structure organization and callbacks we=
re necessary.
> > Therefore, changes were added accordingly.
> >
> > Please review. I do not have a way to test these patch in a board today=
 though. So, testing
> > is more than welcome :-).
> >
> > [1] - https://lkml.org/lkml/2015/1/31/175
> >
> > Cheers,
> >
> > Eduardo Valentin (14):
> >   cpufreq: exynos4210: properly put of node
> >   cpufreq: exynos4210: iounmap in error path
> >   cpufreq: exynos4210: use devm_clk_get
> >   cpufreq: exynos4x12: properly put of node
> >   cpufreq: exynos4x12: iounmap in error path
> >   cpufreq: exynos4x12: use devm_clk_get
> >   cpufreq: exynos5250: properly put of node
> >   cpufreq: exynos5250: iounmap in error path
> >   cpufreq: exynos5250: use devm_clk_get
> >   cpufreq: exynox-cpufreq: pass exynos_dvfs_info to .set_freq callback
> >   cpufreq: exynos4210: remove unused symbol cpufreq
> >   cpufreq: exynos4x12: remove unused symbol cpufreq
> >   cpufreq: exynos5250: remove unused symbol cpufreq
> >   cpufreq: exynos-cpufreq: release resources by using managed allocation
>=20
> Some of this might be unnecessary ..
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/30498=
4.html

OK. Pick what makes sense.=20


>=20
> And please cc samsung maintainers next time ..

Sure. The patches were all copied to what get_maintainers.pl told me.
I missed them in Patch 0 though.

I would appreciate if we can fix this issue so that I can send out the
thermal changes in exynos code without breaking things apart.

What would be the best way to proceed here? Would you be picking the
rework in exynos cpufreq code and then the cleanups to make to make
possible to build it as a module? Or should this go together with the
thermal changes?

Cheers,

Eduardo Valentin


--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0SICAAoJEMLUO4d9pOJWMg8H/3WU8QQ6yGPHvSqIgTtRTZEJ
bD1QgL8MGfhz4VuPpyRmku0dtGj/H8BeOhaLMGwEGAdpXolGrSufmRdBJZWODwf2
JczNKGQ/pBgqNzqT52K5eIlUK8gr9wmiNexqbx4dnrqOB8s799G/NAmkWEs8C2e8
1s6naOB9E3FHlDhkiJLALcu7ul7veHeig0rcna4hplJNeEA3aV+KD7FjR0E6Of69
t/OwiixDf2xK3S09r8ikXVzUFEkREisMOrhodrTcoVy8pgIZITMApAs7/ZtJXxDB
k0E6AT6dkj5hadTce4jkUg10fwpgvQu6fAFiSQg5r5BJHgPJOIp2KNaYQWw+lGg=
=Bs2k
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
