Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96911A9F91;
	Tue, 31 Mar 2026 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916892; cv=none; b=j/GLKRQzrAJFeAjAzMknGCOxC4pGMzVNvr05BDPMuIGoYvCvNBm6uMAA0vhHV2wuGHUwQBOgtPXSkuK/N2JCjfzRKEXwOS4OSUamu1uY02wPbm//Ll5ikIMWtoT7VAOdxLDgrmT1dXl6BAhrfZdu5LT1+NVER1fFn7LObe89QAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916892; c=relaxed/simple;
	bh=UTS6bRaYEmoVwsUk2vstxZD3tjGvGgIrXPc9ZvxdVvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr1NEUxwKMOKby6YuKrIdjlpexWKVkZ/jLRPPUUfJ5xSPFk/uZDyRKRrYXXRanbQxK2wjqjgbMWUHg5kL13HiVWvXkpHam3VBa4YqGRgMgMWQKDkYCeLNybmL7ygXmixM2IvtXeKyckftrqu4/qfak1yl83+m4nWih3XkpDSdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqoa+Zmn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqoa+Zmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774916890; x=1806452890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UTS6bRaYEmoVwsUk2vstxZD3tjGvGgIrXPc9ZvxdVvY=;
  b=gqoa+ZmnppaWDl+Zn5S7MeuqL/lXEHHlf0CsidVkYgplUIgiQ2MgoHny
   AfoEa5vGcKfLYrprNzSvh5sOyFaO2jSushaCd3A7f0LSsqqgWg3nAW6RL
   3/wLzet0WboVs6k62CnnpVJ+wp8jHNY3UbU3iAk8frr85ahcDO2js59Q2
   FirF1tZD0hJp5Afpy27FclDD7GKCBi+slV3MofrSQQq/r1q1rKLr/flsT
   9gsLSNLD2QlfPCdWj+3CKt2fJeTGj6kWioTlh99A2ATuTjsVtxYEKVWhj
   vUyeCqm2g5sz+H1R+rgKx6T+sRMPQPZpRLV4Au7Yecc8h+eLw9Y3/5F60
   w==;
X-CSE-ConnectionGUID: I7YwufsLQqqzlcG0S+8NiQ==
X-CSE-MsgGUID: ywVU/1yqSomMo5jB4GlQvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="98530699"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98530699"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:28:09 -0700
X-CSE-ConnectionGUID: Q7iGtlB2Qt61LkUbEWtHFQ==
X-CSE-MsgGUID: SooVwb9cSwyT+/GwjMWaog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="222897558"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.32]) ([10.125.111.32])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:28:08 -0700
Message-ID: <0586c4f9-6311-497d-9d41-76f3125de115@linux.intel.com>
Date: Mon, 30 Mar 2026 17:28:05 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] platform/x86/intel/pmc: Enable Pkgc blocking
 residency counter
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
 <20260302223214.484585-3-xi.pardee@linux.intel.com>
 <c78bc413-d946-9a2e-ec90-670320e3a8a0@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <c78bc413-d946-9a2e-ec90-670320e3a8a0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/20/26 03:27, Ilpo Järvinen wrote:
> On Mon, 2 Mar 2026, Xi Pardee wrote:
>
>> Enable the Package C-state blocking counter in the PMT telemetry
>> region. This counter reports the number of 10 µs intervals during
>> which a Package C-state 10.2/3 entry was blocked for the specified
>> reasons.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 27 +++++++++++++++++++++++++++
>>   drivers/platform/x86/intel/pmc/core.h |  8 ++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index bf95a1f2ba428..e5b48a68cf495 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1093,6 +1093,28 @@ static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
>>   
>> +static int pmc_core_pkgc_blocker_residency_show(struct seq_file *s, void *unused)
>> +{
>> +	struct pmc_dev *pmcdev = s->private;
>> +	const char **pkgc_blocker_counters;
>> +	u32 counter, offset;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	offset = pmcdev->pkgc_blocker_offset;
>> +	pkgc_blocker_counters = pmcdev->pkgc_blocker_counters;
>> +	for (i = 0; pkgc_blocker_counters[i]; i++, offset++) {
>> +		ret = pmt_telem_read32(pmcdev->pc_ep, offset,
>> +				       &counter, 1);
>> +		if (ret)
>> +			return ret;
>> +		seq_printf(s, "%-30s %-30u\n", pkgc_blocker_counters[i], counter);
>> +	}
>> +
>> +	return 0;
> I wonder if it would be create a common helper as this looks practically
> the same as pmc_core_pkgc_ltr_blocker_show() added in the previous patch?

Thanks!

Will add a common helper in next version.

Xi

>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_blocker_residency);
>> +
>>   static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>>   {
>>   	struct pmc_dev *pmcdev = s->private;
>> @@ -1380,6 +1402,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
>>   		pmcdev->pc_ep = ep;
>>   		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
>>   		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
>> +		pmcdev->pkgc_blocker_counters = pmc_dev_info->pkgc_blocker_counters;
>> +		pmcdev->pkgc_blocker_offset = pmc_dev_info->pkgc_blocker_offset;
>>   	}
>>   
>>   release_dev:
>> @@ -1512,6 +1536,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
>>   		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
>>   				    pmcdev->dbgfs_dir, pmcdev,
>>   				    &pmc_core_pkgc_ltr_blocker_fops);
>> +		debugfs_create_file("pkgc_blocker_residency_show", 0444,
>> +				    pmcdev->dbgfs_dir, pmcdev,
>> +				    &pmc_core_pkgc_blocker_residency_fops);
>>   	}
>>   
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index a20aab73c1409..829b1dee3f636 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -455,6 +455,8 @@ struct pmc {
>>    *
>>    * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
>>    * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
>> + * @pkgc_blocker_counters: Array of PKGC blocker counters
>> + * @pkgc_blocker_offset: Offset to PKGC blocker in telemetry region
>>    *
>>    * pmc_dev contains info about power management controller device.
>>    */
>> @@ -480,6 +482,8 @@ struct pmc_dev {
>>   
>>   	const char **pkgc_ltr_blocker_counters;
>>   	u32 pkgc_ltr_blocker_offset;
>> +	const char **pkgc_blocker_counters;
>> +	u32 pkgc_blocker_offset;
>>   };
>>   
>>   enum pmc_index {
>> @@ -495,6 +499,7 @@ enum pmc_index {
>>    * @dmu_guids:		List of Die Management Unit GUID
>>    * @pc_guid:		GUID for telemetry region to read PKGC blocker info
>>    * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
>> + * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
>>    * @regmap_list:	Pointer to a list of pmc_info structure that could be
>>    *			available for the platform. When set, this field implies
>>    *			SSRAM support.
>> @@ -502,6 +507,7 @@ enum pmc_index {
>>    *			specific attributes of the primary PMC
>>    * @sub_req_show:	File operations to show substate requirements
>>    * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
>> + * @pkgc_blocker_counters: Array of PKGC blocker counters
>>    * @suspend:		Function to perform platform specific suspend
>>    * @resume:		Function to perform platform specific resume
>>    * @init:		Function to perform platform specific init action
>> @@ -512,10 +518,12 @@ struct pmc_dev_info {
>>   	u32 *dmu_guids;
>>   	u32 pc_guid;
>>   	u32 pkgc_ltr_blocker_offset;
>> +	u32 pkgc_blocker_offset;
>>   	struct pmc_info *regmap_list;
>>   	const struct pmc_reg_map *map;
>>   	const struct file_operations *sub_req_show;
>>   	const char **pkgc_ltr_blocker_counters;
>> +	const char **pkgc_blocker_counters;
>>   	void (*suspend)(struct pmc_dev *pmcdev);
>>   	int (*resume)(struct pmc_dev *pmcdev);
>>   	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>>
