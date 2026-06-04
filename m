Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45263DA5C1;
	Thu,  4 Jun 2026 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556185; cv=none; b=lsD8l0WiFTdzsApqnZAQTe/ARZ9188Ny1XU7zqCbE/G02TXBq6OS07kYhB7FvM6aLe2yugs2ObnK/84KgehowaCLNwMFP0ILO/Xd/OspYxWiLQtewPHFHzPx9kkZm5wb9GBU0W3kCdfMtLtVYiIl2RTzLZsd8b55NXiV1Kvgitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556185; c=relaxed/simple;
	bh=j2G7PHYkYh9n8mySp/jFj4nbsz9tn7v1S1aLKTDSF6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4Ww/mlXkBBokGf7658QPQfL+5PyHEIcJu2HnETgX17JqTh1CgXXJ+YuxOyrngStUJQ5rm58t1SxOIav19+lL/rFLMHPaLOmv9gOOIkf/9VpwyDf6WABDengrfE0YeMXTRAsbLdoWMX/Yefns6um7EGH6jB4CH9vsDimK6Y6LpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SXn66iLx; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SXn66iLx"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 82F3A272A2;
	Thu,  4 Jun 2026 08:56:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QrZ6mqCWCFHE; Thu,  4 Jun 2026 08:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780556173; bh=j2G7PHYkYh9n8mySp/jFj4nbsz9tn7v1S1aLKTDSF6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXn66iLx/AMzsoBwAA1eKSqPmssJPJSTP9L7+NLkgDHQ2SF/X+ZMHmKLjDN3Lm0/2
	 NpPBBK2jhvP9hsg0TeS/1FMhReSlHg6MICIfvlMgE8wBjHMcnZYpcS5KcBbEaHLTVG
	 LigwEliGaUcFeyDJawVd90AvV5nZdx0iMcXya6LNl3sL5xDLZrKah1uRInRgXt8Om9
	 mbJxWTsK8R9MyRKi1wl8sKJev2roVx/svZ+NHleJo5D1BQIDetJn0zea5yXZoX39pe
	 5DfaCMxh8sowqTbrUUdKmVc9DksGyG5MFpQ3QsSc+q/tRzcrnyP+/JwKEHNJ2lcxx1
	 QleEzGzeCE+pg==
From: Marco Scardovi <scardracs@disroot.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
Subject:
 Re: [PATCH v2 1/2] cpufreq/amd-pstate: Fix EPP initialization for shared
 memory systems
Date: Thu, 04 Jun 2026 08:56:00 +0200
Message-ID: <CO-q9BQiTf6GLfZiYh_W4g@disroot.org>
In-Reply-To: <b4e23498-492a-40b2-8517-6d44eaec8502@amd.com>
References:
 <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <2e3a5f9a-69fe-4790-8b8b-2d1622977a2f@amd.com>
 <b4e23498-492a-40b2-8517-6d44eaec8502@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data gioved=C3=AC 4 giugno 2026 05:56:20 Ora legale dell=E2=80=99Europa =
centrale, K=20
Prateek Nayak ha scritto:
> Hello Mario,
>=20
> On 6/4/2026 12:23 AM, Mario Limonciello wrote:
> >> --- a/drivers/cpufreq/amd-pstate.h
> >> +++ b/drivers/cpufreq/amd-pstate.h
> >> @@ -128,6 +128,8 @@ struct amd_cpudata {
> >>       u8    epp_default_dc;
> >>       bool    dynamic_epp;
> >>       bool    raw_epp;
> >> +    /* Indicates that EPP has been successfully programmed at least o=
nce
> >> since boot. */ +    bool    epp_hw_programmed;
> >>       struct notifier_block power_nb;
> >>         /* platform profile */
> >=20
> > I'm having a hard time following why this is needed.  Let me explain my
> > chain of thought.
> >=20
> > We start at amd_pstate_epp_cpu_init().
> > * cpudata (and thus cppc_req_cached) is initalized to 0 via kzalloc()
> >    - On a server we initialize "epp_default" via a lookup to the HW
> > (amd_pstate_get_epp). - On a non-server we initialize "epp_default" to
> > 0x80.
> > * we call amd_pstate_set_epp() with epp_deafult as the argument.
> >=20
> > Now in the shared mem backend (shmem_set_epp) we do a lookup of epp_cac=
hed
> > and it should be 0.  We do a comparison of the argument sent to the
> > function, and this should be 0x80.
> >=20
> > So how do we get into a case that amd_pstate_set_epp() is actually call=
ed
> > with 0?
> This was the path I traced yesterday considering amd_dynamic_epp enabled =
for
> a shared memory system that is plugged into the wall:
>=20
>   amd_pstate_epp_cpu_init()
>     cpudata->epp_default_ac =3D AMD_CPPC_EPP_PERFORMANCE;
>     cpudata->epp_default_dc =3D AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>     cpudata->current_profile =3D PLATFORM_PROFILE_BALANCED;
>=20
>     /* cpudata->cppc_req_cached has epp_cached as 0 */
>=20
>     amd_pstate_set_dynamic_epp(policy)
>       epp =3D amd_pstate_get_balanced_epp(policy); /* returns
> cpudata->epp_default_ac which is EPP_PERFORMANCE */
>=20
>       amd_pstate_set_epp(policy, epp /* AMD_CPPC_EPP_PERFORMANCE */)
>         if (epp =3D=3D epp_cached)
>           return;
>=20
>         /*
>          * Skips cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1)
>          * where the last argument "enable" enables EPP via the
>          * AUTO_SEL_ENABLE path.
>          */
>=20
> > There are some trace points specifically for this purpose - you could
> > confirm there really is such a call by using them at bootup (or by
> > starting in passive and with a mode change to active at runtime).
> It should show up in the traces yes!
>=20
> > Then we call amd_pstate_set_epp() with that epp_default value.
>=20
> I think this patch has some merit, although the second patch, I'm not
> too sure of. After some digging, it seems we always had AUTO_SEL_ENABLE
> and ENERGY_PERF right from the time CPPC was introduced (including Zen1
> systems that had CPPC support).
>=20
> Marco, do you have actually have a system that neither has
> AUTO_SEL_ENABLE, nor ENERGY_PERF? Seems very unlikely a configuration
> like that made it out.

Hi Prateek, Mario,

No, I don't have a system lacking AUTO_SEL_ENABLE or ENERGY_PERF support.
The only AMD system I currently have access to is an 8940HX.

I think I understand the reasoning behind both of your comments. My=20
understanding is that the main question is whether there is a real boot pat=
h=20
where amd_pstate_set_epp() returns early before EPP has ever been programme=
d=20
in hardware, which would justify tracking that state separately from the=20
cached EPP value.

However, I'm not familiar enough with this part of the driver to confidentl=
y=20
turn that reasoning into a correct implementation, so I'd prefer to defer t=
o=20
your judgement on whether the additional state tracking is the right approa=
ch.

Thanks,
Marco



