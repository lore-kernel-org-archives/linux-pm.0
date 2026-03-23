Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73978313267
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293747; cv=none; b=ogFbvgHKQUiZTQjpyFmWleen5bKUz2xPeSno5lxoCkFUp4p2Hk/nEmrIMnmugFDxBfW9FONZivMACx4CpQoY6Z8iAf1rF6vBhOQd7ctLV+tXUvmm6yp7CWZOPt/rMXIHhBS8wSaD4W9L98ZbKw/zQ9zrGRyTxll+amt8YVVphw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293747; c=relaxed/simple;
	bh=KCvUJ+n935Vi45vqw4sJBx7G8qvm9UZbujs0tn3T1ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgtEDxuY3/vthRof2VvdtZuredm559rDQYKZ7Sgh7vZNXnjW4OCb7Hp4cvBq6u8KwPUy/Cc2rfZ6sgG/cznNzFkNKJhSD+ixNRxNEBHD0gUyYZQ9vDLuOkupmWVyL9Aw0peZFA8/hnMLUzlO05AE4eITVcT2PaVeyHKyCDv4ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFOZ7IN3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFOZ7IN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B7C4CEF7
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774293747;
	bh=KCvUJ+n935Vi45vqw4sJBx7G8qvm9UZbujs0tn3T1ME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YFOZ7IN3XeVgdCNRjbj1ckZuCDW0wqd5yrjMjn3bylGiQfj5Wgzpg/MDB3+qYsbh3
	 uUmZOua8hNgQ/oYsWBv4oT+JU7Anb7x8A2CYJ4lnnmTiWOWNR4OHhAfWA7yia6BXJ2
	 Dm4gkDyQxzHxeX40exKalghvWZWHRwKn8CZ0JuVlYdWTZAtFB3N3SA1nH4yDXN481d
	 MJfeBICk1ETNsN2Mvf5YtLRtdF89usX/Bgr1owuVEV6CtVVcwNZvgEdkBUr/n05c/u
	 h2nTw0MbhMJPRt7O24+Mh4Gm5XWwt0LzWLLMrituBgWwdY/1QEM0a/tqSHl/pHdBPT
	 fKID8irguKqgQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67ba5921b84so1814714eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:22:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjGIJJRIwkk6kDAcBKCrinBpoSfESvit+Bbqis7jp/i4fZrd2y
	1Rt0dMv+88Nv+ImTMEAMpYCAaV9SyZwPHG7uS/b4j+S2gCoIxHweRUZXsrJ6ORFd1I44/7ht+Hq
	77sW/VU9a6Rbxe/BTXVZyvHtu4U7kYeA=
X-Received: by 2002:a05:6820:180e:b0:67b:dad6:dbdc with SMTP id
 006d021491bc7-67c22fbd5bamr9703467eaf.55.1774293746222; Mon, 23 Mar 2026
 12:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313190052.2370963-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ed821010a38d535bd123e3d1999d3fd722ccd1ba.camel@linux.intel.com>
In-Reply-To: <ed821010a38d535bd123e3d1999d3fd722ccd1ba.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Mar 2026 20:22:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZwyY923=tAGFVmjWk2JpddppdCqNv3rAoSiQ14xM_-Q@mail.gmail.com>
X-Gm-Features: AQROBzDc1_3lstBQ6vU2t66tvvvFudVLYPXqlczJPiOWByeCMJekagKjn-eYLYQ
Message-ID: <CAJZ5v0iZwyY923=tAGFVmjWk2JpddppdCqNv3rAoSiQ14xM_-Q@mail.gmail.com>
Subject: Re: [PATCH v1] powercap: intel_rapl: Consolidate PL4 and PMU support
 flags into rapl_defaults
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:20=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-03-13 at 12:00 -0700, Kuppuswamy Sathyanarayanan wrote:
> > Currently, PL4 and MSR-based RAPL PMU support are detected using
> > separate CPU ID tables (pl4_support_ids and pmu_support_ids) in the
> > MSR driver probe path. This creates a maintenance burden since adding
> > a new CPU requires updates in two places: the rapl_ids table and one
> > or both of these capability tables.
> >
> > Consolidate PL4 and PMU capability information directly into
> > struct rapl_defaults by adding msr_pl4_support and msr_pmu_support
> > flags. This allows per-CPU capability to be expressed in a single
> > place alongside other per-CPU defaults, eliminating the duplicate
> > CPU ID tables entirely.
> >
> > No functional changes are intended.
> >
> > Co-developed-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.1 material, thanks!

> > ---
> >  drivers/powercap/intel_rapl_msr.c | 83 ++++++++++++++---------------
> > --
> >  include/linux/intel_rapl.h        |  2 +
> >  2 files changed, 38 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/powercap/intel_rapl_msr.c
> > b/drivers/powercap/intel_rapl_msr.c
> > index cfb35973f0b5..a34543e66446 100644
> > --- a/drivers/powercap/intel_rapl_msr.c
> > +++ b/drivers/powercap/intel_rapl_msr.c
> > @@ -216,33 +216,6 @@ static int rapl_msr_write_raw(int cpu, struct
> > reg_action *ra)
> >       return ra->err;
> >  }
> >
> > -/* List of verified CPUs. */
> > -static const struct x86_cpu_id pl4_support_ids[] =3D {
> > -     X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
> > -     X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
> > -     X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
> > -     X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
> > -     X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
> > -     X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
> > -     X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
> > -     X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> > -     X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> > -     {}
> > -};
> > -
> > -/* List of MSR-based RAPL PMU support CPUs */
> > -static const struct x86_cpu_id pmu_support_ids[] =3D {
> > -     X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> > -     X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> > -     {}
> > -};
> > -
> >  static int rapl_check_unit_atom(struct rapl_domain *rd)
> >  {
> >       struct reg_action ra;
> > @@ -420,6 +393,23 @@ static const struct rapl_defaults
> > rapl_defaults_amd =3D {
> >       .check_unit =3D rapl_default_check_unit,
> >  };
> >
> > +static const struct rapl_defaults rapl_defaults_core_pl4 =3D {
> > +     .floor_freq_reg_addr =3D 0,
> > +     .check_unit =3D rapl_default_check_unit,
> > +     .set_floor_freq =3D rapl_default_set_floor_freq,
> > +     .compute_time_window =3D rapl_default_compute_time_window,
> > +     .msr_pl4_support =3D 1,
> > +};
> > +
> > +static const struct rapl_defaults rapl_defaults_core_pl4_pmu =3D {
> > +     .floor_freq_reg_addr =3D 0,
> > +     .check_unit =3D rapl_default_check_unit,
> > +     .set_floor_freq =3D rapl_default_set_floor_freq,
> > +     .compute_time_window =3D rapl_default_compute_time_window,
> > +     .msr_pl4_support =3D 1,
> > +     .msr_pmu_support =3D 1,
> > +};
> > +
> >  static const struct x86_cpu_id rapl_ids[]  =3D {
> >       X86_MATCH_VFM(INTEL_SANDYBRIDGE,                &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,              &rapl_defaul
> > ts_core),
> > @@ -443,35 +433,35 @@ static const struct x86_cpu_id rapl_ids[]  =3D {
> >       X86_MATCH_VFM(INTEL_KABYLAKE_L,                 &rap
> > l_defaults_core),
> >       X86_MATCH_VFM(INTEL_KABYLAKE,                   &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_CANNONLAKE_L,               &rapl_defaul
> > ts_core),
> > -
> >       X86_MATCH_VFM(INTEL_ICELAKE_L,                  &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_ICELAKE_L,                  &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_ICELAKE,                    &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_ICELAKE_NNPI,               &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_ICELAKE_X,                  &rapl_defaul
> > ts_hsw_server),
> >       X86_MATCH_VFM(INTEL_ICELAKE_D,                  &rapl_defaul
> > ts_hsw_server),
> >       X86_MATCH_VFM(INTEL_COMETLAKE_L,                &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_COMETLAKE,                  &rapl_defaul
> > ts_core),
> > -
> >       X86_MATCH_VFM(INTEL_TIGERLAKE_L,                &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_TIGERLAKE_L,                &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_TIGERLAKE,                  &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_ROCKETLAKE,                 &rap
> > l_defaults_core),
> > -
> >       X86_MATCH_VFM(INTEL_ALDERLAKE,                  &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_ALDERLAKE_L,                &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,             &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_RAPTORLAKE,                 &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_RAPTORLAKE_P,               &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_ALDERLAKE,                  &rapl_defaul
> > ts_core_pl4),
> > +     X86_MATCH_VFM(INTEL_ALDERLAKE_L,                &rapl_defaul
> > ts_core_pl4),
> > +     X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,             &rapl_defaul
> > ts_core_pl4),
> > +     X86_MATCH_VFM(INTEL_RAPTORLAKE,                 &rap
> > l_defaults_core_pl4),
> > +     X86_MATCH_VFM(INTEL_RAPTORLAKE_P,               &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_RAPTORLAKE_S,               &rapl_defaul
> > ts_core),
> >       X86_MATCH_VFM(INTEL_BARTLETTLAKE,               &rapl_defaul
> > ts_core),
> > -
> >       X86_MATCH_VFM(INTEL_METEORLAKE,                 &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_METEORLAKE_L,               &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_METEORLAKE,                 &rap
> > l_defaults_core_pl4),
> > +     X86_MATCH_VFM(INTEL_METEORLAKE_L,               &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,           &rapl_defaul
> > ts_spr_server),
> >       X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,            &rapl_defaul
> > ts_spr_server),
> >       X86_MATCH_VFM(INTEL_LUNARLAKE_M,                &rapl_defaul
> > ts_core),
> > -
> >       X86_MATCH_VFM(INTEL_PANTHERLAKE_L,              &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_WILDCATLAKE_L,              &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_NOVALAKE,                   &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_NOVALAKE_L,                 &rapl_defaults_co=
re),
> > -
> >       X86_MATCH_VFM(INTEL_ARROWLAKE_H,                &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_PANTHERLAKE_L,              &rapl_defaul
> > ts_core_pl4_pmu),
> > +     X86_MATCH_VFM(INTEL_WILDCATLAKE_L,              &rapl_defaul
> > ts_core_pl4_pmu),
> > +     X86_MATCH_VFM(INTEL_NOVALAKE,                   &rapl_defaul
> > ts_core_pl4),
> > +     X86_MATCH_VFM(INTEL_NOVALAKE_L,                 &rap
> > l_defaults_core_pl4),
> > +     X86_MATCH_VFM(INTEL_ARROWLAKE_H,                &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_ARROWLAKE,                  &rapl_defaul
> > ts_core),
> > -
> >       X86_MATCH_VFM(INTEL_ARROWLAKE_U,                &rapl_defaults_co=
re),
> > +     X86_MATCH_VFM(INTEL_ARROWLAKE_U,                &rapl_defaul
> > ts_core_pl4),
> >       X86_MATCH_VFM(INTEL_LAKEFIELD,                  &rapl_defaul
> > ts_core),
> >
> >       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,            &rapl_defaul
> > ts_byt),
> > @@ -498,7 +488,6 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> >
> >  static int rapl_msr_probe(struct platform_device *pdev)
> >  {
> > -     const struct x86_cpu_id *id =3D
> > x86_match_cpu(pl4_support_ids);
> >       int ret;
> >
> >       switch (boot_cpu_data.x86_vendor) {
> > @@ -518,16 +507,16 @@ static int rapl_msr_probe(struct
> > platform_device *pdev)
> >       rapl_msr_priv->defaults =3D (const struct rapl_defaults
> > *)pdev->dev.platform_data;
> >       rapl_msr_priv->rpi =3D rpi_msr;
> >
> > -     if (id) {
> > +     if (rapl_msr_priv->defaults->msr_pl4_support) {
> >               rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |=3D
> > BIT(POWER_LIMIT4);
> >               rapl_msr_priv-
> > >regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4].msr =3D
> >                       MSR_VR_CURRENT_CONFIG;
> > -             pr_info("PL4 support detected.\n");
> > +             pr_info("PL4 support detected (updated).\n");
> >       }
> >
> > -     if (x86_match_cpu(pmu_support_ids)) {
> > +     if (rapl_msr_priv->defaults->msr_pmu_support) {
> >               rapl_msr_pmu =3D true;
> > -             pr_info("MSR-based RAPL PMU support enabled\n");
> > +             pr_info("MSR-based RAPL PMU support enabled
> > (updated)\n");
> >       }
> >
> >       rapl_msr_priv->control_type =3D
> > powercap_register_control_type(NULL, "intel-rapl", NULL);
> > diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> > index 01f290de3586..328004f605c3 100644
> > --- a/include/linux/intel_rapl.h
> > +++ b/include/linux/intel_rapl.h
> > @@ -135,6 +135,8 @@ struct rapl_defaults {
> >       unsigned int dram_domain_energy_unit;
> >       unsigned int psys_domain_energy_unit;
> >       bool spr_psys_bits;
> > +     bool msr_pl4_support;
> > +     bool msr_pmu_support;
> >  };
> >
> >  #define PRIMITIVE_INFO_INIT(p, m, s, i, u, f) {      \
