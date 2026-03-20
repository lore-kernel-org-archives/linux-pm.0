Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19C2BE7DD;
	Fri, 20 Mar 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003856; cv=none; b=CHjo3EvZOsBVS1uBIBnbN3Urp86Nx//5KOSqDhx8+YuZFitAJfAG00gzeHDa17t7b73ilhYvnOgjDrLg8WRq6rOYwNsJXrc0IOBNmIDpAf3jRF3T1xT2onHvWKeuAmthr2vP2MkPyZhAaIL9RvSLEFxT/QdzhNnWpFIjoKxILPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003856; c=relaxed/simple;
	bh=lZjjdkCdhNwnNWnITl54hoaa9Dh7DNaD2wgyi4WaCQU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p2qz2ERZQv6NzR0KjCEmPeyMEuHfMtd2EfPQfVUvP+RXkBVvng9oHSs3La71Kyk3Lob+BppSsWlvAQFPEgl25uHIc3A7XGcnuTSklqjPMKJK9RI8+Ko+PxE7lJ+8McX+CAlEkL148FafagYHV29WgYdaNfPpRYGr6YfoNwZzueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECX0g3t9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECX0g3t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774003856; x=1805539856;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lZjjdkCdhNwnNWnITl54hoaa9Dh7DNaD2wgyi4WaCQU=;
  b=ECX0g3t9u87hhvFlGEiTO8VjOmT/sbiY7zXEORpRaBuJ5HsfAa0DdnZ7
   CAR3Qz/nuriqmOhq9RvdEMqVj8fLkuUIUMgC2g/10kK10TfrKtq9h70aj
   txZhNFHHnZMOyvFUFL827wWP+8XnG5275EHhVVVACx5wROtY5giOl6kcQ
   /l3rOYDFocF+HX2BXZtWDP1ITU9EwwOCV9bPWUSWanuScjbHLywOGUNN8
   CyWLkBuFmTB3SqJs2X8by2hH0MAT4fWb25Tgehg6R8v3BE3aSP5nSwE9s
   1H8ZCrQskISeCKkigVPdypmhMCmflwaeRg3OJZhmdlQy07VmqNy6wC10/
   w==;
X-CSE-ConnectionGUID: FtEsL/SLQaqC5nqQTASkEQ==
X-CSE-MsgGUID: u0slyQJoTLSR/F/lByO+6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86163608"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86163608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:50:55 -0700
X-CSE-ConnectionGUID: dU+EjAQqSjamSolI0+XCWQ==
X-CSE-MsgGUID: ATFPR6QiRAuHkb+MikGzOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246279341"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:50:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:50:49 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] platform/x86/intel/pmc: Add support for variable
 DMU offsets
In-Reply-To: <20260302223214.484585-5-xi.pardee@linux.intel.com>
Message-ID: <c9e22f8e-89cd-e497-7058-d12bc27c9950@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com> <20260302223214.484585-5-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Mar 2026, Xi Pardee wrote:

> Add support for handling different DMU Die C6 offsets across platforms.
> The previous implementation assumed a uniform DMU Die C6 offset for all
> platforms, which is no longer valid.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  | 2 ++
>  drivers/platform/x86/intel/pmc/core.c | 2 +-
>  drivers/platform/x86/intel/pmc/core.h | 2 ++
>  drivers/platform/x86/intel/pmc/mtl.c  | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 95372a0807acf..4d91ee010f6d0 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -729,6 +729,7 @@ struct pmc_dev_info arl_pmc_dev = {
>  	.init = arl_core_init,
>  	.sub_req = pmc_core_pmt_get_lpm_req,
>  	.ssram_hidden = true,
> +	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
>  };
>  
>  static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
> @@ -742,4 +743,5 @@ struct pmc_dev_info arl_h_pmc_dev = {
>  	.init = arl_h_core_init,
>  	.sub_req = pmc_core_pmt_get_lpm_req,
>  	.ssram_hidden = true,
> +	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 7670970c995b9..7bd0e1eaa32e2 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1387,7 +1387,7 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
>  		}
>  
>  		pmcdev->punit_ep = ep;
> -		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
> +		pmcdev->die_c6_offset = pmc_dev_info->die_c6_offset;
>  	}
>  
>  	if (pmc_dev_info->pc_guid) {
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 31fe71b01120b..f09791f866223 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -514,6 +514,7 @@ enum pmc_index {
>   * @init:		Function to perform platform specific init action
>   * @sub_req:		Function to achieve low power mode substate requirements
>   * @ssram_hidden:	Flag to indicate whether SSRAM is hidden
> + * @die_c6_offseyt:	Telemetry offset to read Die C6 residency

Typo (-t)

>   */
>  struct pmc_dev_info {
>  	u32 *dmu_guids;
> @@ -530,6 +531,7 @@ struct pmc_dev_info {
>  	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>  	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
>  	bool ssram_hidden;
> +	u32 die_c6_offset;
>  };
>  
>  extern const struct pmc_bit_map msr_map[];
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 193ebbe584023..b724dd8c34dba 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -1003,4 +1003,5 @@ struct pmc_dev_info mtl_pmc_dev = {
>  	.init = mtl_core_init,
>  	.sub_req = pmc_core_pmt_get_lpm_req,
>  	.ssram_hidden = true,
> +	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
>  };
> 

-- 
 i.

