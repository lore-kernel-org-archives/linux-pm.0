Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3123CAE74;
	Mon,  7 Sep 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777961; cv=none; b=ASLxlS7895HcAT1XXbnbbVwk7cSRfR/8pK09ei6baIMmdfDs71hp4dkUp5vsLzics7+lF56eK9RmSQN9gylxgPXw2cFcoWunz/8PsKUis0mDRwUkSAItc3tgCoPxej7qB6NwVrYKNpPaSuFqrlFszjCXRbhltUBX3kRwdV98kYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777961; c=relaxed/simple;
	bh=IHW4ElspRSr+LrSKGPqi5jMnKmVL/wMLlZaBzNvbh/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGaZ89fmBcAyK0Tzq0bLiTB0uNy+iOEyjaZd6dRQM9gYNV9qcx/h5KfIcdNmjzeziAw4F+WEPc/02mdC+6U//xy/I4KHTyZ578iKC2jDUKo02RA0dxAaALcqsK9xgorl9rqP3BQGKavipog5PIqer1o0WPAZgYC+1oN06rBSGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M5J1CwXR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M5J1CwXR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAA11477;
	Mon,  7 Sep 2026 03:45:55 -0700 (PDT)
Received: from [10.57.7.146] (unknown [10.57.7.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40643F7B4;
	Mon,  7 Sep 2026 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788777959; bh=IHW4ElspRSr+LrSKGPqi5jMnKmVL/wMLlZaBzNvbh/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M5J1CwXRn/v7lZ07wG1/TO9w6vbFSSdIrC+5T5ZqaEGDNo0TPCmWtZBHRNNY6jcL0
	 /Juz8tpTYawEGGm5m22ww+B7nX6xbDkWDvmdUvlLkTMhIJ7mbnQyquAcGAzqGm3IqB
	 EyNKVcfVu+La8Tnk7vB3BobyOko1PI/ZGVhrO1N8=
Message-ID: <350caba2-4a95-4945-91dd-0be89b2d3e22@arm.com>
Date: Mon, 7 Sep 2026 11:46:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and
 selftests
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 9/7/26 11:03, Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> On 8/6/26 13:01, Daniel Lezcano wrote:
>> Powercap controllers frequently expose a hierarchy of power zones (for
>> example package, clusters and CPUs). Until now, each driver had to
>> implement its own hierarchy traversal, parent lookup, error handling and
>> teardown logic.
>>
>> This series introduces a generic hierarchy description and helper
>> functions allowing a controller to instantiate and destroy an entire
>> powercap hierarchy from a static description. The framework takes care of
>> duplicating the hierarchy description, rebasing parent pointers,
>> creating zones in dependency order and performing the appropriate
>> rollback and cleanup on errors.
>>
>> The series also adds a kselftest exercising the new API by creating a
>> synthetic hierarchy, validating the exported sysfs hierarchy and
>> attributes, and ensuring that all resources are correctly released when
>> the hierarchy is destroyed.
>>
>> The patches are organized as follows:
>>
>> 1. powercap: Add generic zone hierarchy creation helpers
>> 2. selftests/powercap: Add powercap hierarchy creation API tests
>>
>> The API was primarily motivated by the recently posted SPEL series and
>> also provides a migration path for DTPM to use the same generic
>> infrastructure instead of maintaining its own hierarchy handling.
>>
>> Link: SPEL cover letter <https://lore.kernel.org/lkml/20260702- 
>> qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com/>
>>
>> Daniel Lezcano (2):
>> powercap: Add generic zone hierarchy creation helpers
>> selftests/powercap: Add powercap hierarchy creation API tests
>>
>> -- 
> It was easy to migrate DTPM to this API and AFAICT Manaf was able to 
> migrate also its series to this new API.
> 
> Is it possible to consider it for merging ?

I will do a review for this patch set today...

I can see some potential improvements there.

Regards,
Lukasz

