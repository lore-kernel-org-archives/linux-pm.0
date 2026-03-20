Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AF35F19C;
	Fri, 20 Mar 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002477; cv=none; b=Gk1HXUm+j0tL1nTW55Xv5BwonSzOEqkvJijr+L4Va8VU8Ce673jTYBpbg2RK0pSRA+T0PTpR1JOsMpgHMbqMFNoSJb7h+7IbyAgQwpfOa6mLRaRhyJR3FBP1V+6/UUPD/mJ97KewyosMCh8XEnb+hdZt1IKv7TgYs6F24Eh2uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002477; c=relaxed/simple;
	bh=BsOsBC9LFbofD/uU10JIdQ8i22sp99i9Uymom+J1/IM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AH2GnRRAFJJp4lLYfM09D1cMNiziOASE6qA9XU2oPVlBnWi0w9ANHIuQoyYbJBxPeuijliEaA5n+nSnJCt3Z6IFMKAEwEqdGzKsAwL1VQccw9rZNlr42xkIuUSSN8XYBs94IegA0scpPpQP+lqW8JHEO9XCuOxLfKTExJBjLvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drMt1vmv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drMt1vmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002476; x=1805538476;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BsOsBC9LFbofD/uU10JIdQ8i22sp99i9Uymom+J1/IM=;
  b=drMt1vmv4OV3LVQ8al70HMOgatvSBD9OCLfMR37J/jN7EhvP/gXocGVP
   RgDNh3LEvvAZZPFVF2UnPPiDzQGr2RdCfvrZ3ofom9vTV3m8CFSIcTz6s
   /JPcFgA+hBJvJbAAeYZZhMBdrpF+/bMF0ZTVQLbcq6GBxc88u8fdowrJI
   3p7VL459umawOOi0eq4UQSnRCogqhoqLAjgzGl3IImcZQdiScoKMkQ52O
   rqjhiVtWKGVAxArFniJJkc4nLSYmj/Mw3FEkWPOjEQkfvgKsoyWC+kJLm
   g/4GSuY3OY+PICchfnzJpp+6RzulvOTA21GVeukF9GMGHz3L+6Q7N7veM
   Q==;
X-CSE-ConnectionGUID: 66lYHC9oRPWjSFsZVh6GYw==
X-CSE-MsgGUID: 0LqufFcFQKOTlX5g/sUiSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78989234"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78989234"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:27:55 -0700
X-CSE-ConnectionGUID: 71itVEgYRda5TFtgc/0Jhg==
X-CSE-MsgGUID: +nfUFAiXTuKeeiFW2GS2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222339260"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:27:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:27:49 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/6] platform/x86/intel/pmc: Enable Pkgc blocking residency
 counter
In-Reply-To: <20260302223214.484585-3-xi.pardee@linux.intel.com>
Message-ID: <c78bc413-d946-9a2e-ec90-670320e3a8a0@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com> <20260302223214.484585-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-888350789-1774002469=:1024"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-888350789-1774002469=:1024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 2 Mar 2026, Xi Pardee wrote:

> Enable the Package C-state blocking counter in the PMT telemetry
> region. This counter reports the number of 10=E2=80=AF=C2=B5s intervals d=
uring
> which a Package C-state 10.2/3 entry was blocked for the specified
> reasons.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 27 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  8 ++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index bf95a1f2ba428..e5b48a68cf495 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1093,6 +1093,28 @@ static int pmc_core_pkgc_ltr_blocker_show(struct s=
eq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
> =20
> +static int pmc_core_pkgc_blocker_residency_show(struct seq_file *s, void=
 *unused)
> +{
> +=09struct pmc_dev *pmcdev =3D s->private;
> +=09const char **pkgc_blocker_counters;
> +=09u32 counter, offset;
> +=09unsigned int i;
> +=09int ret;
> +
> +=09offset =3D pmcdev->pkgc_blocker_offset;
> +=09pkgc_blocker_counters =3D pmcdev->pkgc_blocker_counters;
> +=09for (i =3D 0; pkgc_blocker_counters[i]; i++, offset++) {
> +=09=09ret =3D pmt_telem_read32(pmcdev->pc_ep, offset,
> +=09=09=09=09       &counter, 1);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09seq_printf(s, "%-30s %-30u\n", pkgc_blocker_counters[i], counter);
> +=09}
> +
> +=09return 0;

I wonder if it would be create a common helper as this looks practically=20
the same as pmc_core_pkgc_ltr_blocker_show() added in the previous patch?

> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_blocker_residency);
> +
>  static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused=
)
>  {
>  =09struct pmc_dev *pmcdev =3D s->private;
> @@ -1380,6 +1402,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev=
, struct pmc_dev_info *pmc_de
>  =09=09pmcdev->pc_ep =3D ep;
>  =09=09pmcdev->pkgc_ltr_blocker_counters =3D pmc_dev_info->pkgc_ltr_block=
er_counters;
>  =09=09pmcdev->pkgc_ltr_blocker_offset =3D pmc_dev_info->pkgc_ltr_blocker=
_offset;
> +=09=09pmcdev->pkgc_blocker_counters =3D pmc_dev_info->pkgc_blocker_count=
ers;
> +=09=09pmcdev->pkgc_blocker_offset =3D pmc_dev_info->pkgc_blocker_offset;
>  =09}
> =20
>  release_dev:
> @@ -1512,6 +1536,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev =
*pmcdev, struct pmc_dev_info
>  =09=09debugfs_create_file("pkgc_ltr_blocker_show", 0444,
>  =09=09=09=09    pmcdev->dbgfs_dir, pmcdev,
>  =09=09=09=09    &pmc_core_pkgc_ltr_blocker_fops);
> +=09=09debugfs_create_file("pkgc_blocker_residency_show", 0444,
> +=09=09=09=09    pmcdev->dbgfs_dir, pmcdev,
> +=09=09=09=09    &pmc_core_pkgc_blocker_residency_fops);
>  =09}
> =20
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index a20aab73c1409..829b1dee3f636 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -455,6 +455,8 @@ struct pmc {
>   *
>   * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
>   * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry re=
gion
> + * @pkgc_blocker_counters: Array of PKGC blocker counters
> + * @pkgc_blocker_offset: Offset to PKGC blocker in telemetry region
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -480,6 +482,8 @@ struct pmc_dev {
> =20
>  =09const char **pkgc_ltr_blocker_counters;
>  =09u32 pkgc_ltr_blocker_offset;
> +=09const char **pkgc_blocker_counters;
> +=09u32 pkgc_blocker_offset;
>  };
> =20
>  enum pmc_index {
> @@ -495,6 +499,7 @@ enum pmc_index {
>   * @dmu_guids:=09=09List of Die Management Unit GUID
>   * @pc_guid:=09=09GUID for telemetry region to read PKGC blocker info
>   * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry re=
gion
> + * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
>   * @regmap_list:=09Pointer to a list of pmc_info structure that could be
>   *=09=09=09available for the platform. When set, this field implies
>   *=09=09=09SSRAM support.
> @@ -502,6 +507,7 @@ enum pmc_index {
>   *=09=09=09specific attributes of the primary PMC
>   * @sub_req_show:=09File operations to show substate requirements
>   * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
> + * @pkgc_blocker_counters: Array of PKGC blocker counters
>   * @suspend:=09=09Function to perform platform specific suspend
>   * @resume:=09=09Function to perform platform specific resume
>   * @init:=09=09Function to perform platform specific init action
> @@ -512,10 +518,12 @@ struct pmc_dev_info {
>  =09u32 *dmu_guids;
>  =09u32 pc_guid;
>  =09u32 pkgc_ltr_blocker_offset;
> +=09u32 pkgc_blocker_offset;
>  =09struct pmc_info *regmap_list;
>  =09const struct pmc_reg_map *map;
>  =09const struct file_operations *sub_req_show;
>  =09const char **pkgc_ltr_blocker_counters;
> +=09const char **pkgc_blocker_counters;
>  =09void (*suspend)(struct pmc_dev *pmcdev);
>  =09int (*resume)(struct pmc_dev *pmcdev);
>  =09int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info=
);
>=20

--=20
 i.

--8323328-888350789-1774002469=:1024--
