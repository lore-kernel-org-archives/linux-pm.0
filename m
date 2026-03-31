Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11C2AD25;
	Tue, 31 Mar 2026 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917262; cv=none; b=utb2shsfGYFh0Q+/4+KFTstOCYSgk6/eyPshb7EqIsFS1DxT7R86I87/Cjr5Ks73m55EzKjdFTGaG24vIGQbv1Pw2wu0ktTVhxEQzBuumiEqMAiHMNq7r1xFV//nQPHHTllDw0B8acbNSZ/xL+iZ6+VLkrhphcB4jIi5n3mAHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917262; c=relaxed/simple;
	bh=rF1zUP+au1Ih+DJgs4cFk+PLznAl2LollPYbvZ8g7ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdBZ7tZUHtWZibdOwfIQL4hlXcwCVddIO2Lvyq3cBlpeiIcajeOenoMZwk32gOUu+I0+2x1a5SsAGhdATJgXVSYTNQZWnKOPFd9RwsJUB9J9hUs3vzqswKojAJKYLePuVRkfqEzQAgEefPs4kbd9tUNZDXPAtB7E6X9MJ36sjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQmB9sps; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQmB9sps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774917260; x=1806453260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rF1zUP+au1Ih+DJgs4cFk+PLznAl2LollPYbvZ8g7ls=;
  b=hQmB9spstM7mTlq/1uFpTi2/d6da5owlKenuyo1c99ZrBDP/9GM8TDfk
   Q9IdIU3+GuH6C5I0PwFey4atlzVjlo9qO1oKmF66EnocqM5poRsfJfZsZ
   qSc/vHLPq6xVjH78845Gsq4qvfKN0IHDBRj+FWWnUwhZiw8wLcTHGneEX
   Q6zI5xWS8kjRruxS83Gbpl0nehgVs67nxOedWq2MexejCmOZaMwGGrKfX
   I7Khnw3ewudDf+ZxAdsRRKBJY5hivJcYuPYxNAWLOs4ymZnbAGxGRd6Jm
   mSf8t6FV1WT3iscG/dp0AiE4T3W6XS9eh2EfUzcWM5bE3R4zrnEJmhUhW
   g==;
X-CSE-ConnectionGUID: XCkx21ILRSCN51C4T1/Tww==
X-CSE-MsgGUID: y+ZbyYUhRNmmAAsHKIbxKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76110519"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="76110519"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:34:20 -0700
X-CSE-ConnectionGUID: JeGsOHPSQxiKNoOLAX+WFw==
X-CSE-MsgGUID: qSjCpsDlTRuDBQHk2a4eKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249253079"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.32]) ([10.125.111.32])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:34:19 -0700
Message-ID: <52c38ccd-0a4a-4959-bb07-ac4a34ab7883@linux.intel.com>
Date: Mon, 30 Mar 2026 17:34:18 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] platform/x86/intel/pmc: Retrieve PMC info only for
 available PMCs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
 <20260302223214.484585-6-xi.pardee@linux.intel.com>
 <33f4caaf-8e1a-33d8-8521-357a80a70eb7@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <33f4caaf-8e1a-33d8-8521-357a80a70eb7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/20/26 03:58, Ilpo Järvinen wrote:
> On Mon, 2 Mar 2026, Xi Pardee wrote:
>
>> Update the Intel PMC Core driver to fetch PMC information only for
>> available PMCs. Previously, the driver attempted to retrieve PMC info
>> even when the corresponding PMC was not present.
>>
>> This change aligns with recent updates to the Intel SSRAM Telemetry
>> driver. Starting with NVL, the SSRAM Telemetry driver is probed for
>> each individual SSRAM device. The prior implementation could not
>> differentiate between an unavailable PMC and one that had not yet
>> completed information retrieval. To resolve this, the PMC Core driver
>> now skips obtaining PMC info for unavailable PMCs.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  |  5 +++++
>>   drivers/platform/x86/intel/pmc/core.c | 19 +++++++++++--------
>>   drivers/platform/x86/intel/pmc/core.h |  2 ++
>>   drivers/platform/x86/intel/pmc/lnl.c  |  3 +++
>>   drivers/platform/x86/intel/pmc/mtl.c  |  3 +++
>>   drivers/platform/x86/intel/pmc/ptl.c  |  3 +++
>>   drivers/platform/x86/intel/pmc/wcl.c  |  3 +++
>>   7 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index 4d91ee010f6d0..34506542c94da 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -672,6 +672,9 @@ static struct pmc_info arl_pmc_info_list[] = {
>>   	{}
>>   };
>>   
>> +static u8 arl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_PCH, PMC_IDX_MAX};
>> +static u8 arl_h_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};
> This seems a bit dangerous approach if somebody forgets to add that
> PMC_IDX_MAX. It would be better to do it with sizeof() for safety).

Will add another field num_pmcs in pmc_dev_info struct to store the 
number of available PMCs.

Will use ARRAY_SIZE() on pmc_list variable to retrieve the number of 
available PMCs and store in num_pmcs variable and check that in 
pmc_core_ssram_get_reg_base().

>> +
>>   #define ARL_NPU_PCI_DEV			0xad1d
>>   #define ARL_GNA_PCI_DEV			0xae4c
>>   #define ARL_H_NPU_PCI_DEV		0x7d1d
>> @@ -721,6 +724,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
>>   static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
>>   struct pmc_dev_info arl_pmc_dev = {
>>   	.dmu_guids = ARL_PMT_DMU_GUIDS,
>> +	.pmc_list = arl_pmc_list,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &arl_socs_reg_map,
>>   	.sub_req_show = &pmc_core_substate_req_regs_fops,
>> @@ -735,6 +739,7 @@ struct pmc_dev_info arl_pmc_dev = {
>>   static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
>>   struct pmc_dev_info arl_h_pmc_dev = {
>>   	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
>> +	.pmc_list = arl_h_pmc_list,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &mtl_socm_reg_map,
>>   	.sub_req_show = &pmc_core_substate_req_regs_fops,
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 7bd0e1eaa32e2..85fff5e3abe0d 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1744,16 +1744,19 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
>>   	return 0;
>>   }
>>   
>> -static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
>> +static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev, u8 *pmc_list)
>>   {
>> +	unsigned int i;
>>   	int ret;
>>   
>> -	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
>> -	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
>> +	for (i = 0; pmc_list[i] != PMC_IDX_MAX; ++i) {
>> +		if (pmc_list[i] == PMC_IDX_MAIN) {
>> +			ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
>> +			if (ret)
>> +				return ret;
>> +		} else
>> +			pmc_core_pmc_add(pmcdev, pmc_list[i]);
> Isn't this same as:
>
> 		/* Non-MAIN PMCs are allowed to fail */
> 		ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
> 		if (ret && (pmc_list[i] == PMC_IDX_MAIN))
> 			return ret;
>
>
Will change to this format in next version.

Thanks!

Xi

>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -1775,7 +1778,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   	ssram = pmc_dev_info->regmap_list != NULL;
>>   	if (ssram) {
>>   		pmcdev->regmap_list = pmc_dev_info->regmap_list;
>> -		ret = pmc_core_ssram_get_reg_base(pmcdev);
>> +		ret = pmc_core_ssram_get_reg_base(pmcdev, pmc_dev_info->pmc_list);
>>   		/*
>>   		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
>>   		 * has not finished probe and PMC info is not available yet. Try
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index f09791f866223..c4984e44f7b80 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -501,6 +501,7 @@ enum pmc_index {
>>    * @pc_guid:		GUID for telemetry region to read PKGC blocker info
>>    * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
>>    * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
>> + * @pmc_list:		Index list of available PMC
>>    * @regmap_list:	Pointer to a list of pmc_info structure that could be
>>    *			available for the platform. When set, this field implies
>>    *			SSRAM support.
>> @@ -521,6 +522,7 @@ struct pmc_dev_info {
>>   	u32 pc_guid;
>>   	u32 pkgc_ltr_blocker_offset;
>>   	u32 pkgc_blocker_offset;
>> +	u8 *pmc_list;
>>   	struct pmc_info *regmap_list;
>>   	const struct pmc_reg_map *map;
>>   	const struct file_operations *sub_req_show;
>> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
>> index 18f303af328e3..7b09b59e1326c 100644
>> --- a/drivers/platform/x86/intel/pmc/lnl.c
>> +++ b/drivers/platform/x86/intel/pmc/lnl.c
>> @@ -544,6 +544,8 @@ static struct pmc_info lnl_pmc_info_list[] = {
>>   	{}
>>   };
>>   
>> +static u8 lnl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
>> +
>>   #define LNL_NPU_PCI_DEV		0x643e
>>   #define LNL_IPU_PCI_DEV		0x645d
>>   
>> @@ -571,6 +573,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   }
>>   
>>   struct pmc_dev_info lnl_pmc_dev = {
>> +	.pmc_list = lnl_pmc_list,
>>   	.regmap_list = lnl_pmc_info_list,
>>   	.map = &lnl_socm_reg_map,
>>   	.sub_req_show = &pmc_core_substate_req_regs_fops,
>> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
>> index b724dd8c34dba..6438fca266392 100644
>> --- a/drivers/platform/x86/intel/pmc/mtl.c
>> +++ b/drivers/platform/x86/intel/pmc/mtl.c
>> @@ -965,6 +965,8 @@ static struct pmc_info mtl_pmc_info_list[] = {
>>   	{}
>>   };
>>   
>> +static u8 mtl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};
>> +
>>   #define MTL_GNA_PCI_DEV	0x7e4c
>>   #define MTL_IPU_PCI_DEV	0x7d19
>>   #define MTL_VPU_PCI_DEV	0x7d1d
>> @@ -995,6 +997,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
>>   struct pmc_dev_info mtl_pmc_dev = {
>>   	.dmu_guids = MTL_PMT_DMU_GUIDS,
>> +	.pmc_list = mtl_pmc_list,
>>   	.regmap_list = mtl_pmc_info_list,
>>   	.map = &mtl_socm_reg_map,
>>   	.sub_req_show = &pmc_core_substate_req_regs_fops,
>> diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
>> index 6c68772e738c8..538ca5ae2e9ec 100644
>> --- a/drivers/platform/x86/intel/pmc/ptl.c
>> +++ b/drivers/platform/x86/intel/pmc/ptl.c
>> @@ -543,6 +543,8 @@ static struct pmc_info ptl_pmc_info_list[] = {
>>   	{}
>>   };
>>   
>> +static u8 ptl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
>> +
>>   #define PTL_NPU_PCI_DEV                0xb03e
>>   #define PTL_IPU_PCI_DEV                0xb05d
>>   
>> @@ -569,6 +571,7 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   }
>>   
>>   struct pmc_dev_info ptl_pmc_dev = {
>> +	.pmc_list = ptl_pmc_list,
>>   	.regmap_list = ptl_pmc_info_list,
>>   	.map = &ptl_pcdp_reg_map,
>>   	.sub_req_show = &pmc_core_substate_blk_req_fops,
>> diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
>> index b55069945e9e7..429f53f22a89f 100644
>> --- a/drivers/platform/x86/intel/pmc/wcl.c
>> +++ b/drivers/platform/x86/intel/pmc/wcl.c
>> @@ -469,6 +469,8 @@ static struct pmc_info wcl_pmc_info_list[] = {
>>   	{}
>>   };
>>   
>> +static u8 wcl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
>> +
>>   #define WCL_NPU_PCI_DEV                0xfd3e
>>   
>>   /*
>> @@ -494,6 +496,7 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
>>   
>>   struct pmc_dev_info wcl_pmc_dev = {
>>   	.regmap_list = wcl_pmc_info_list,
>> +	.pmc_list = wcl_pmc_list,
>>   	.map = &wcl_pcdn_reg_map,
>>   	.sub_req_show = &pmc_core_substate_blk_req_fops,
>>   	.suspend = cnl_suspend,
>>
