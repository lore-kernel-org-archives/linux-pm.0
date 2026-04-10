Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A63D348F;
	Fri, 10 Apr 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831273; cv=none; b=FApThxiAMa58pm3AX+ZAhNbc+p5TYHggZNlmk62EHi25KDs9VUE9oBE+yJGArkulXE38KRB1b6IH0elh4PjWYZWSXdzbMjTM4YTm4pNMXzfGwOrg8Ogy7CuZopwOvjcBr3oamGoM7DN7csxoeCQsrXrTGX6z1cU+9qUzXSvyeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831273; c=relaxed/simple;
	bh=+3yYlKzmj8tkdGMtBH//q1VOy0Jsh0dUvQWLGe+yGmk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kv3f/CiDDMd5UOKV9YRsYymVLcheBM7IoYP5VSnOs9X8jn43EdygE1dkabOkcx9xp8DV1jEUnZ0RuhYWKrMTB87GJWoYYELUwy5KXi40o6Hso9aeIqGDeL4YFLYFsnK8zxULLgfMr14pIspC4ftHTt4QBp1WtF+RYdqqsNFO/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhsfvUf7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhsfvUf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775831272; x=1807367272;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+3yYlKzmj8tkdGMtBH//q1VOy0Jsh0dUvQWLGe+yGmk=;
  b=mhsfvUf7zoogZZ0P87iJyQkO2pehW5IgTG15ZG12AtGmRbNcqwWpOpQy
   hTo3LDk5+0vcTElFXcX+Iz9WwXrs3WZ6fbq9HYCwC0NNxEy/xfk55lW/a
   H+vkH+H5M/BcnSEv3dWxaVI5wl376rZZxDdPRRyyW1XmFLn5i6SuBa75l
   +aTdHLWQtdi17CgHipe73AXHEOQGEpaQyq+dCcO2GbeQf1Ix0U0MIzQIm
   yWeR4dAnMFYdw6Y0AxgqWiD04QQgj088s2swHv1dAmCiDCQ25V/hK7FFR
   QiB3L4J7SAFJXooot8XjhylWHZcrhrQ4PWZwzefBFzxQz/U0XmJXrGJUV
   g==;
X-CSE-ConnectionGUID: ElpXyAqvRTmo3FVIdFAYew==
X-CSE-MsgGUID: Wyu2Nj+cTmGVn6FBFjuFuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76020182"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76020182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:27:51 -0700
X-CSE-ConnectionGUID: TGsXO/1OSHCPCDXXRZG/hQ==
X-CSE-MsgGUID: Dymp7urqTn2dO+qFnOiERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="233175084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:27:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 17:27:44 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] platform/x86/intel/pmc: Enable Pkgc blocking
 residency counter
In-Reply-To: <20260408222144.3288928-4-xi.pardee@linux.intel.com>
Message-ID: <c2c0a4bf-92e3-022d-1e39-2f039faa3a66@linux.intel.com>
References: <20260408222144.3288928-1-xi.pardee@linux.intel.com> <20260408222144.3288928-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-474505665-1775831264=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-474505665-1775831264=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Apr 2026, Xi Pardee wrote:

> Enable the Package C-state blocking counter in the PMT telemetry
> region. This counter reports the number of 10=E2=80=AF=C2=B5s intervals d=
uring
> which a Package C-state 10.2/3 entry was blocked for the specified
> reasons.
>=20
> Create a common helper for pmc_core_pkgc_ltr_blocker_show() and
> pmc_core_pkgc_blocker_residency_show() as these two functions
> share similar logic.

Please don't do back and forth changes like this within a series. You=20
should add it in the right form from the beginning.

--=20
 i.

> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 40 ++++++++++++++++++++-------
>  drivers/platform/x86/intel/pmc/core.h |  8 ++++++
>  2 files changed, 38 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 5c519942ec58c..94ae098a155a6 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1071,29 +1071,44 @@ static int pmc_core_die_c6_us_show(struct seq_fil=
e *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
> =20
> -static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unus=
ed)
> +static int pmc_core_pkgc_counters_show(struct seq_file *s,
> +=09=09=09=09       struct telem_endpoint *ep,
> +=09=09=09=09       u32 offset, const char **counters)
>  {
> -=09struct pmc_dev *pmcdev =3D s->private;
> -=09const char **pkgc_ltr_blocker_counters;
>  =09unsigned int i;
>  =09u32 counter;
>  =09int ret;
> =20
> -=09pkgc_ltr_blocker_counters =3D pmcdev->pkgc_ltr_blocker_counters;
> -=09for (i =3D 0; pkgc_ltr_blocker_counters[i]; i++) {
> -=09=09ret =3D pmt_telem_read32(pmcdev->pc_ep,
> -=09=09=09=09       pmcdev->pkgc_ltr_blocker_offset + i,
> -=09=09=09=09       &counter, 1);
> -
> +=09for (i =3D 0; counters[i]; i++) {
> +=09=09ret =3D pmt_telem_read32(ep, offset + i, &counter, 1);
>  =09=09if (ret)
>  =09=09=09return ret;
> -=09=09seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], count=
er);
> +=09=09seq_printf(s, "%-30s %-30u\n", counters[i], counter);
>  =09}
> =20
>  =09return 0;
>  }
> +
> +static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unus=
ed)
> +{
> +=09struct pmc_dev *pmcdev =3D s->private;
> +
> +=09return pmc_core_pkgc_counters_show(s, pmcdev->pc_ep,
> +=09=09=09=09=09   pmcdev->pkgc_ltr_blocker_offset,
> +=09=09=09=09=09   pmcdev->pkgc_ltr_blocker_counters);
> +}
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
> =20
> +static int pmc_core_pkgc_blocker_residency_show(struct seq_file *s, void=
 *unused)
> +{
> +=09struct pmc_dev *pmcdev =3D s->private;
> +
> +=09return pmc_core_pkgc_counters_show(s, pmcdev->pc_ep,
> +=09=09=09=09=09   pmcdev->pkgc_blocker_offset,
> +=09=09=09=09=09   pmcdev->pkgc_blocker_counters);
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_blocker_residency);
> +
>  static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused=
)
>  {
>  =09struct pmc_dev *pmcdev =3D s->private;
> @@ -1381,6 +1396,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev=
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
>  }
> =20
> @@ -1510,6 +1527,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev =
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

--8323328-474505665-1775831264=:1195--
