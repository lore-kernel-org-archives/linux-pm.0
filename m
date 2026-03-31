Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6925782A;
	Tue, 31 Mar 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916847; cv=none; b=AXA4fjw91srsNxPrZQBkIZPE8bhZhR7vgjgVumWRYwEOkByxZlwrvUzuPqUEsfldYOyN5CRmxVwTwD4R8Z+sh8XGM76b1Z9/pau0AEJS4qPnf3tKlaaCD+xwZxcYgScvgQGOrEJAEmZyENBNH8V6P32Vp/0T34EB1q1AvT1zxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916847; c=relaxed/simple;
	bh=GZYuYR64pHkv/tDbf6mCBbNVMqmReMB7YO+THIb85eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoSCjPtT51A9ICEbxZBDzeJ3Gj6ZfI7YyAQ5bGxFP7t6QeBmLDAAnf3Bl2vo/YKnbixG6vOzfnQxwem9pWlCkCxEEpPdWoUixR+rYgB7T0CdA8dHqxsHWE8j6bpKVz/md+nfZIp+vLlKmlFEwiKp6qirJXad8PYOs2PDgfllrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6yWg791; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6yWg791"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774916845; x=1806452845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GZYuYR64pHkv/tDbf6mCBbNVMqmReMB7YO+THIb85eU=;
  b=f6yWg791080jrGnRO4VZRmzcpdCkBLLhjlKjui4p3i/vTMqQC6lb1qDG
   IHIenh+Bxt9A7pBhs1p6cQgZQxmfq0gVSv1/os+nGCoGHa1H5ZKOT1b/T
   6UxoQV5Bwlwj3B5PgO3V3kfGEBBoGVc5IKfYiyOTXpwFCkUldeA4hVVLL
   mgBZjgVb0/dUSSctYGNE8DQZYSoDHLvDvZOJaUDPO7AZGXOi3TAu4NncE
   ndiHbFFp+JM0B+LX3otKMwhPOaDdwNMYh4prRha8U8X6ABEPS0QkPpSQG
   jc2QdQveFoBhX6SRUYzsZpy+BtaXQOA7RFrUL7yGbp/sUd5OQ6b5bIR4D
   w==;
X-CSE-ConnectionGUID: G0LEIzshS8uZFPgr9lKWYQ==
X-CSE-MsgGUID: uXIjQmO3R4+A2YB+CRl/Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="98530659"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98530659"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:27:24 -0700
X-CSE-ConnectionGUID: gL56vA5tSLOksOS5YpxurQ==
X-CSE-MsgGUID: QdCxvru+RDuw/8/B1Upztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="222897412"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.32]) ([10.125.111.32])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:27:24 -0700
Message-ID: <d1c66548-b69e-4525-bc16-cac53ba39944@linux.intel.com>
Date: Mon, 30 Mar 2026 17:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] platform/x86/intel/pmc: Enable PkgC LTR blocking
 counter
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
 <20260302223214.484585-2-xi.pardee@linux.intel.com>
 <9a428ef0-4511-25df-e8fe-988d96d0e2f6@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <9a428ef0-4511-25df-e8fe-988d96d0e2f6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/20/26 03:25, Ilpo Järvinen wrote:
> On Mon, 2 Mar 2026, Xi Pardee wrote:
>
>> Enable the Package C-state LTR blocking counter in the PMT telemetry
>> region. This counter records how many times any Package C-state entry
>> is blocked for the specified reasons.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 77 ++++++++++++++++++++++-----
>>   drivers/platform/x86/intel/pmc/core.h | 15 +++++-
>>   2 files changed, 79 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 02b303418d185..bf95a1f2ba428 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1071,6 +1071,28 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
>>   
>> +static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
>> +{
>> +	struct pmc_dev *pmcdev = s->private;
>> +	const char **pkgc_ltr_blocker_counters;
>> +	u32 counter, offset;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	offset = pmcdev->pkgc_ltr_blocker_offset;
>> +	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
>> +	for (i = 0; pkgc_ltr_blocker_counters[i]; i++, offset++) {
>> +		ret = pmt_telem_read32(pmcdev->pc_ep, offset,
>> +				       &counter, 1);
> Fits easily to one line. Though, I'm not sure if offset variable improves
> things, more like it makes this more complex than it need to be. To me it
> would look more straightforward to do just:
>
> 		ret = pmt_telem_read32(pmcdev->pc_ep,
> 				       pmcdev->pkgc_ltr_blocker_offset + i,
> 				       ...);

Will change in next version.

>> +		if (ret)
>> +			return ret;
>> +		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
>> +	}
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
>> +
>>   static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>>   {
>>   	struct pmc_dev *pmcdev = s->private;
>> @@ -1322,7 +1344,7 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
>>   	return ERR_PTR(-ENODEV);
>>   }
>>   
>> -void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
>> +void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>>   {
>>   	struct telem_endpoint *ep;
>>   	struct pci_dev *pcidev;
>> @@ -1333,17 +1355,35 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
>>   		return;
>>   	}
>>   
>> -	ep = pmc_core_register_endpoint(pcidev, guids);
>> -	pci_dev_put(pcidev);
>> -	if (IS_ERR(ep)) {
>> -		dev_err(&pmcdev->pdev->dev,
>> -			"pmc_core: couldn't get DMU telem endpoint %ld",
>> -			PTR_ERR(ep));
>> -		return;
>> +	if (pmc_dev_info->dmu_guids) {
>> +		ep = pmc_core_register_endpoint(pcidev, pmc_dev_info->dmu_guids);
>> +		if (IS_ERR(ep)) {
>> +			dev_err(&pmcdev->pdev->dev,
>> +				"pmc_core: couldn't get DMU telem endpoint %ld",
>> +				PTR_ERR(ep));
>> +			goto release_dev;
>> +		}
>> +
>> +		pmcdev->punit_ep = ep;
>> +		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
>> +	}
>> +
>> +	if (pmc_dev_info->pc_guid) {
>> +		ep = pmt_telem_find_and_register_endpoint(pcidev, pmc_dev_info->pc_guid, 0);
>> +		if (IS_ERR(ep)) {
>> +			dev_err(&pmcdev->pdev->dev,
>> +				"pmc_core: couldn't get Package C-state telem endpoint %ld",
>> +				PTR_ERR(ep));
>> +			goto release_dev;
>> +		}
>> +
>> +		pmcdev->pc_ep = ep;
>> +		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
>> +		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
>>   	}
>>   
>> -	pmcdev->punit_ep = ep;
>> -	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
>> +release_dev:
>> +	pci_dev_put(pcidev);
> Use __free(pci_dev_put) instead of complicating the code flow.
> Please remember to place the variable declaration at the place of
> assignment (no = NULL; assignments with __free()). You may want to do the
> __free() conversion in own patch preceeding this.

Thanks!

Will change and add another patch to convert to use __free() in next 
version.

Xi

