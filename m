Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25105399378;
	Fri, 20 Mar 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004336; cv=none; b=mXRDpWA5WzAskXcyMiEx2TCQTNlB/DkntsEt6ZVYnFpMyZEIjrCQJ6+5fhzW/2h+ICrFSgmtYqP10VNvkGQ1XQGOCl+VTMpH+kDLrj+xemFBfiq7kkwnvNvfilFeFLWL6QuBxm5PK7M+vmOLCH2atazRwfsN8Mn59pwwrMgTISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004336; c=relaxed/simple;
	bh=6rkL5Y11W8vblxHdinq1mUvdydUtN//15Bik/nVBFkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OUYkJOtLv2FevgGc332ijAMKZIB4WTSSfGlMK9ho4oqdusABGBr2MwA5eUMLg6tRWXbs3TVBNTwNaHj8RgolU+zhbFs6rkfCOjG2WPk2r4vIpULUfBg+upwoaN7vdKlumAhtb9Gs8Gi9SmVjGjQ5ST+fvBonME362DQj3v+3iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctS6KP8E; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctS6KP8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774004332; x=1805540332;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6rkL5Y11W8vblxHdinq1mUvdydUtN//15Bik/nVBFkI=;
  b=ctS6KP8EzfV2Sd4oILX5bfe3V0ejrGyZvkLJqhYmSGlbz/ffGqXdaKij
   kHWZ+kqAQhqPga1mfAGW3Htl517vJVZ9ZiCzcBduX+SD2QHb0VOwc42/s
   DM4wj2JxDjNAioEYKyVqso0HKqJpGgUft2d6Ux3kM3UZ26SNO+wIi7lZn
   HPwaUC3i8jX2lfiwYSSU60pC5wBrDyphpWAmUwDTkQULOEpPPX6sLHwle
   o4j0bBX4c9gmr6m13gEgcc8yyvTw+W3ZMjrqztkjhKKrHayce7hO8iUCG
   aFLdHsxWxCCt5uPW3yK4nqEvtHf5tU1zVC2oH4wXvtbh7M20gNjn80j1/
   g==;
X-CSE-ConnectionGUID: O8hTV9jlSo2tWzOhj+uMWA==
X-CSE-MsgGUID: H/VCKwubRmOcrwF8p3lk0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="97703410"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="97703410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:58:51 -0700
X-CSE-ConnectionGUID: cWZK5RpzRY6iAbkenogUNA==
X-CSE-MsgGUID: eTvNnlPiRai9wMXeAX52rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228190987"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:58:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:58:46 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/x86/intel/pmc: Retrieve PMC info only for
 available PMCs
In-Reply-To: <20260302223214.484585-6-xi.pardee@linux.intel.com>
Message-ID: <33f4caaf-8e1a-33d8-8521-357a80a70eb7@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com> <20260302223214.484585-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Mar 2026, Xi Pardee wrote:

> Update the Intel PMC Core driver to fetch PMC information only for
> available PMCs. Previously, the driver attempted to retrieve PMC info
> even when the corresponding PMC was not present.
> 
> This change aligns with recent updates to the Intel SSRAM Telemetry
> driver. Starting with NVL, the SSRAM Telemetry driver is probed for
> each individual SSRAM device. The prior implementation could not
> differentiate between an unavailable PMC and one that had not yet
> completed information retrieval. To resolve this, the PMC Core driver
> now skips obtaining PMC info for unavailable PMCs.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  |  5 +++++
>  drivers/platform/x86/intel/pmc/core.c | 19 +++++++++++--------
>  drivers/platform/x86/intel/pmc/core.h |  2 ++
>  drivers/platform/x86/intel/pmc/lnl.c  |  3 +++
>  drivers/platform/x86/intel/pmc/mtl.c  |  3 +++
>  drivers/platform/x86/intel/pmc/ptl.c  |  3 +++
>  drivers/platform/x86/intel/pmc/wcl.c  |  3 +++
>  7 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 4d91ee010f6d0..34506542c94da 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -672,6 +672,9 @@ static struct pmc_info arl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static u8 arl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_PCH, PMC_IDX_MAX};
> +static u8 arl_h_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};

This seems a bit dangerous approach if somebody forgets to add that
PMC_IDX_MAX. It would be better to do it with sizeof() for safety).

> +
>  #define ARL_NPU_PCI_DEV			0xad1d
>  #define ARL_GNA_PCI_DEV			0xae4c
>  #define ARL_H_NPU_PCI_DEV		0x7d1d
> @@ -721,6 +724,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
>  static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
>  struct pmc_dev_info arl_pmc_dev = {
>  	.dmu_guids = ARL_PMT_DMU_GUIDS,
> +	.pmc_list = arl_pmc_list,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &arl_socs_reg_map,
>  	.sub_req_show = &pmc_core_substate_req_regs_fops,
> @@ -735,6 +739,7 @@ struct pmc_dev_info arl_pmc_dev = {
>  static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
>  struct pmc_dev_info arl_h_pmc_dev = {
>  	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
> +	.pmc_list = arl_h_pmc_list,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &mtl_socm_reg_map,
>  	.sub_req_show = &pmc_core_substate_req_regs_fops,
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 7bd0e1eaa32e2..85fff5e3abe0d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1744,16 +1744,19 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
>  	return 0;
>  }
>  
> -static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
> +static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev, u8 *pmc_list)
>  {
> +	unsigned int i;
>  	int ret;
>  
> -	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
> -	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
> +	for (i = 0; pmc_list[i] != PMC_IDX_MAX; ++i) {
> +		if (pmc_list[i] == PMC_IDX_MAIN) {
> +			ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
> +			if (ret)
> +				return ret;
> +		} else
> +			pmc_core_pmc_add(pmcdev, pmc_list[i]);

Isn't this same as:

		/* Non-MAIN PMCs are allowed to fail */
		ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
		if (ret && (pmc_list[i] == PMC_IDX_MAIN))
			return ret;



> +	}
>  
>  	return 0;
>  }
> @@ -1775,7 +1778,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  	ssram = pmc_dev_info->regmap_list != NULL;
>  	if (ssram) {
>  		pmcdev->regmap_list = pmc_dev_info->regmap_list;
> -		ret = pmc_core_ssram_get_reg_base(pmcdev);
> +		ret = pmc_core_ssram_get_reg_base(pmcdev, pmc_dev_info->pmc_list);
>  		/*
>  		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
>  		 * has not finished probe and PMC info is not available yet. Try
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index f09791f866223..c4984e44f7b80 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -501,6 +501,7 @@ enum pmc_index {
>   * @pc_guid:		GUID for telemetry region to read PKGC blocker info
>   * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
>   * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
> + * @pmc_list:		Index list of available PMC
>   * @regmap_list:	Pointer to a list of pmc_info structure that could be
>   *			available for the platform. When set, this field implies
>   *			SSRAM support.
> @@ -521,6 +522,7 @@ struct pmc_dev_info {
>  	u32 pc_guid;
>  	u32 pkgc_ltr_blocker_offset;
>  	u32 pkgc_blocker_offset;
> +	u8 *pmc_list;
>  	struct pmc_info *regmap_list;
>  	const struct pmc_reg_map *map;
>  	const struct file_operations *sub_req_show;
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index 18f303af328e3..7b09b59e1326c 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -544,6 +544,8 @@ static struct pmc_info lnl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static u8 lnl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
> +
>  #define LNL_NPU_PCI_DEV		0x643e
>  #define LNL_IPU_PCI_DEV		0x645d
>  
> @@ -571,6 +573,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  }
>  
>  struct pmc_dev_info lnl_pmc_dev = {
> +	.pmc_list = lnl_pmc_list,
>  	.regmap_list = lnl_pmc_info_list,
>  	.map = &lnl_socm_reg_map,
>  	.sub_req_show = &pmc_core_substate_req_regs_fops,
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index b724dd8c34dba..6438fca266392 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -965,6 +965,8 @@ static struct pmc_info mtl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static u8 mtl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};
> +
>  #define MTL_GNA_PCI_DEV	0x7e4c
>  #define MTL_IPU_PCI_DEV	0x7d19
>  #define MTL_VPU_PCI_DEV	0x7d1d
> @@ -995,6 +997,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
>  struct pmc_dev_info mtl_pmc_dev = {
>  	.dmu_guids = MTL_PMT_DMU_GUIDS,
> +	.pmc_list = mtl_pmc_list,
>  	.regmap_list = mtl_pmc_info_list,
>  	.map = &mtl_socm_reg_map,
>  	.sub_req_show = &pmc_core_substate_req_regs_fops,
> diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
> index 6c68772e738c8..538ca5ae2e9ec 100644
> --- a/drivers/platform/x86/intel/pmc/ptl.c
> +++ b/drivers/platform/x86/intel/pmc/ptl.c
> @@ -543,6 +543,8 @@ static struct pmc_info ptl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static u8 ptl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
> +
>  #define PTL_NPU_PCI_DEV                0xb03e
>  #define PTL_IPU_PCI_DEV                0xb05d
>  
> @@ -569,6 +571,7 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  }
>  
>  struct pmc_dev_info ptl_pmc_dev = {
> +	.pmc_list = ptl_pmc_list,
>  	.regmap_list = ptl_pmc_info_list,
>  	.map = &ptl_pcdp_reg_map,
>  	.sub_req_show = &pmc_core_substate_blk_req_fops,
> diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
> index b55069945e9e7..429f53f22a89f 100644
> --- a/drivers/platform/x86/intel/pmc/wcl.c
> +++ b/drivers/platform/x86/intel/pmc/wcl.c
> @@ -469,6 +469,8 @@ static struct pmc_info wcl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static u8 wcl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
> +
>  #define WCL_NPU_PCI_DEV                0xfd3e
>  
>  /*
> @@ -494,6 +496,7 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>  
>  struct pmc_dev_info wcl_pmc_dev = {
>  	.regmap_list = wcl_pmc_info_list,
> +	.pmc_list = wcl_pmc_list,
>  	.map = &wcl_pcdn_reg_map,
>  	.sub_req_show = &pmc_core_substate_blk_req_fops,
>  	.suspend = cnl_suspend,
> 

-- 
 i.

