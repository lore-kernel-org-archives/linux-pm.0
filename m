Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E7259CB2;
	Fri, 20 Mar 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002325; cv=none; b=rsFuZZLEK4VCXA14vv2TEIF4W+Rfi2fk+hpFxSeF6uIpJebz9EEYQp7vy/qHiYJC+/SizmwhnweUr/KevKdjfU5u2lZy5MthhzpwY3wkRTS+zUw8S3N+5or5CjIlz1m+AeX6LznOxAZRE1Naf0RtyALaAFtVxElekr8LkjvHlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002325; c=relaxed/simple;
	bh=rpPhEUknKDTMI4GdCYFRUf0RudbHHbtJAZ0mPWOaEBE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lvmSV+Md6N46WkBSiFzUWaDLkq0uYWvP/gm3BE1PQ7VdmUwAk2QqGAnU/5yjVG7TlhJNinrpOdvnNXX+ioM85iMMeOU7kSeNbMDxePKMv9tV7h3wa7Omqi3pj99acN9Y0byEUWOp0c+UApyzIv4RTf7pTrIbCYvHyhriP12YUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB8lnSEY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB8lnSEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002323; x=1805538323;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rpPhEUknKDTMI4GdCYFRUf0RudbHHbtJAZ0mPWOaEBE=;
  b=NB8lnSEYdaE4zOgOeBiyC0VVawirjmOy9Tq3zrtPqBrUjI7VkZcUYYlA
   UeiY+0qPDsw5716cRupVOAFFq17Z9J21pXSk22ZG9bIYo6dV5bFKFzh9I
   uBZ/+weM3wmCUHxJNrKAvuB7220I4e4xUYD3uiZDBj5FfA1ljg1tRxUIf
   Qklod/JVdGD9hApyeLOZB6v7B3WGnQu2pu4GxehUBlsUNCOOWOzOOOogY
   LIaXliLk1Qv7tHXpBLdi6Ta+fGQUwbfKOs0iEkNIA3p3hHgHIEwhzG5/c
   yJTqVqQDRsiX77R6ye78DDh8Y+tP/bh96kr2yT3Z+vvVXyrK711I8G7Ow
   Q==;
X-CSE-ConnectionGUID: 9diw6LIHS9CRAU65XTv+8A==
X-CSE-MsgGUID: 6zyj16gXQWC3QbCNmwolDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85399995"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85399995"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:25:22 -0700
X-CSE-ConnectionGUID: IH2XImb9Rm6By3Hbafj2EA==
X-CSE-MsgGUID: Amr4lcYoQb2tLmwAk1FxYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246275365"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:25:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:25:16 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] platform/x86/intel/pmc: Enable PkgC LTR blocking
 counter
In-Reply-To: <20260302223214.484585-2-xi.pardee@linux.intel.com>
Message-ID: <9a428ef0-4511-25df-e8fe-988d96d0e2f6@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com> <20260302223214.484585-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Mar 2026, Xi Pardee wrote:

> Enable the Package C-state LTR blocking counter in the PMT telemetry
> region. This counter records how many times any Package C-state entry
> is blocked for the specified reasons.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 77 ++++++++++++++++++++++-----
>  drivers/platform/x86/intel/pmc/core.h | 15 +++++-
>  2 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 02b303418d185..bf95a1f2ba428 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1071,6 +1071,28 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
>  
> +static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	const char **pkgc_ltr_blocker_counters;
> +	u32 counter, offset;
> +	unsigned int i;
> +	int ret;
> +
> +	offset = pmcdev->pkgc_ltr_blocker_offset;
> +	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
> +	for (i = 0; pkgc_ltr_blocker_counters[i]; i++, offset++) {
> +		ret = pmt_telem_read32(pmcdev->pc_ep, offset,
> +				       &counter, 1);

Fits easily to one line. Though, I'm not sure if offset variable improves 
things, more like it makes this more complex than it need to be. To me it 
would look more straightforward to do just:

		ret = pmt_telem_read32(pmcdev->pc_ep, 
				       pmcdev->pkgc_ltr_blocker_offset + i,
				       ...);

> +		if (ret)
> +			return ret;
> +		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
> +
>  static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> @@ -1322,7 +1344,7 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
>  	return ERR_PTR(-ENODEV);
>  }
>  
> -void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
> +void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  {
>  	struct telem_endpoint *ep;
>  	struct pci_dev *pcidev;
> @@ -1333,17 +1355,35 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
>  		return;
>  	}
>  
> -	ep = pmc_core_register_endpoint(pcidev, guids);
> -	pci_dev_put(pcidev);
> -	if (IS_ERR(ep)) {
> -		dev_err(&pmcdev->pdev->dev,
> -			"pmc_core: couldn't get DMU telem endpoint %ld",
> -			PTR_ERR(ep));
> -		return;
> +	if (pmc_dev_info->dmu_guids) {
> +		ep = pmc_core_register_endpoint(pcidev, pmc_dev_info->dmu_guids);
> +		if (IS_ERR(ep)) {
> +			dev_err(&pmcdev->pdev->dev,
> +				"pmc_core: couldn't get DMU telem endpoint %ld",
> +				PTR_ERR(ep));
> +			goto release_dev;
> +		}
> +
> +		pmcdev->punit_ep = ep;
> +		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
> +	}
> +
> +	if (pmc_dev_info->pc_guid) {
> +		ep = pmt_telem_find_and_register_endpoint(pcidev, pmc_dev_info->pc_guid, 0);
> +		if (IS_ERR(ep)) {
> +			dev_err(&pmcdev->pdev->dev,
> +				"pmc_core: couldn't get Package C-state telem endpoint %ld",
> +				PTR_ERR(ep));
> +			goto release_dev;
> +		}
> +
> +		pmcdev->pc_ep = ep;
> +		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
> +		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
>  	}
>  
> -	pmcdev->punit_ep = ep;
> -	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
> +release_dev:
> +	pci_dev_put(pcidev);

Use __free(pci_dev_put) instead of complicating the code flow. 
Please remember to place the variable declaration at the place of 
assignment (no = NULL; assignments with __free()). You may want to do the 
__free() conversion in own patch preceeding this.

-- 
 i.

>  }
>  
>  void pmc_core_set_device_d3(unsigned int device)
> @@ -1467,6 +1507,13 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
>  				    pmcdev->dbgfs_dir, pmcdev,
>  				    &pmc_core_die_c6_us_fops);
>  	}
> +
> +	if (pmcdev->pc_ep) {
> +		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
> +				    pmcdev->dbgfs_dir, pmcdev,
> +				    &pmc_core_pkgc_ltr_blocker_fops);
> +	}
> +
>  }
>  
>  /*
> @@ -1717,8 +1764,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  	}
>  
>  	pmc_core_get_low_power_modes(pmcdev);
> -	if (pmc_dev_info->dmu_guids)
> -		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guids);
> +	if (pmc_dev_info->dmu_guids || pmc_dev_info->pc_guid)
> +		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info);
>  
>  	if (ssram) {
>  		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
> @@ -1739,6 +1786,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  	if (pmcdev->punit_ep)
>  		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
>  
> +	if (pmcdev->pc_ep)
> +		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
> +
>  	return ret;
>  }
>  
> @@ -1835,6 +1885,9 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
>  	if (pmcdev->punit_ep)
>  		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
>  
> +	if (pmcdev->pc_ep)
> +		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
> +
>  	platform_set_drvdata(pdev, NULL);
>  }
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 118c8740ad3aa..a20aab73c1409 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -453,6 +453,9 @@ struct pmc {
>   * @suspend:		Function to perform platform specific suspend
>   * @resume:		Function to perform platform specific resume
>   *
> + * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
> + * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
> + *
>   * pmc_dev contains info about power management controller device.
>   */
>  struct pmc_dev {
> @@ -471,8 +474,12 @@ struct pmc_dev {
>  	u8 num_of_pkgc;
>  
>  	u32 die_c6_offset;
> +	struct telem_endpoint *pc_ep;
>  	struct telem_endpoint *punit_ep;
>  	struct pmc_info *regmap_list;
> +
> +	const char **pkgc_ltr_blocker_counters;
> +	u32 pkgc_ltr_blocker_offset;
>  };
>  
>  enum pmc_index {
> @@ -486,12 +493,15 @@ enum pmc_index {
>   * struct pmc_dev_info - Structure to keep PMC device info
>   * @pci_func:		Function number of the primary PMC
>   * @dmu_guids:		List of Die Management Unit GUID
> + * @pc_guid:		GUID for telemetry region to read PKGC blocker info
> + * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
>   * @regmap_list:	Pointer to a list of pmc_info structure that could be
>   *			available for the platform. When set, this field implies
>   *			SSRAM support.
>   * @map:		Pointer to a pmc_reg_map struct that contains platform
>   *			specific attributes of the primary PMC
>   * @sub_req_show:	File operations to show substate requirements
> + * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
>   * @suspend:		Function to perform platform specific suspend
>   * @resume:		Function to perform platform specific resume
>   * @init:		Function to perform platform specific init action
> @@ -500,9 +510,12 @@ enum pmc_index {
>  struct pmc_dev_info {
>  	u8 pci_func;
>  	u32 *dmu_guids;
> +	u32 pc_guid;
> +	u32 pkgc_ltr_blocker_offset;
>  	struct pmc_info *regmap_list;
>  	const struct pmc_reg_map *map;
>  	const struct file_operations *sub_req_show;
> +	const char **pkgc_ltr_blocker_counters;
>  	void (*suspend)(struct pmc_dev *pmcdev);
>  	int (*resume)(struct pmc_dev *pmcdev);
>  	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
> @@ -535,7 +548,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
>  
>  int pmc_core_resume_common(struct pmc_dev *pmcdev);
>  int get_primary_reg_base(struct pmc *pmc);
> -void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids);
> +void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>  void pmc_core_set_device_d3(unsigned int device);
>  
>  int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
> 
