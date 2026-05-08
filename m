Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3D33B97B;
	Fri,  8 May 2026 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236517; cv=none; b=n0CApQGIrluR1ZNpAuLdwRwINevOYSjpfsS+FZ3vwq4oB89rwn4PALysuCtRJUGouZePQvd5me3u9It2fRfjEhwHcg1kBpnJJIALujId8xj6Uux690SjNqogoeVpVlyAj+xsqOsgUunlKJhPrsTD6r8SAsg+Gr8pWL5kqvoQ+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236517; c=relaxed/simple;
	bh=RinE6Qqw5D+3/Xg38mnb+wwSYgqoEoP/oeoxRHzz7aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mh+DYCvg6mllnhRWXXrlkYe9CiHF8n5SgL5orb2IyGwSlr8PuQUJfF15Ein4CudYefRSs/zjnK03SY9r89NwMDYFqcVmCmHQBIA3pBC3gIy/BU6xW2JZIgxo8j50ORaMe2scTuW3W4fjKWgiAutamUY9DBaM4B9U5ZHXPdJs4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QrTlsGpK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QrTlsGpK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 096651BCA;
	Fri,  8 May 2026 03:35:10 -0700 (PDT)
Received: from [10.57.24.14] (unknown [10.57.24.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3075C3F763;
	Fri,  8 May 2026 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778236515; bh=RinE6Qqw5D+3/Xg38mnb+wwSYgqoEoP/oeoxRHzz7aM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QrTlsGpKHH5ENPJ5rqUmas8W0ejXRIPHBj1ytDfIDkM6kLUhJkI6zEGXM1ByoiUtU
	 dYQpVan+ld90Lef6c+WoNFr4LKQpk2swmbaT2i4ylEvw2IYQ91uPLr9KaAxD+HKKRA
	 vNFg/lg6JTmV4tI6HVkVPW24MV9+KTIxHpx/qBfU=
Message-ID: <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com>
Date: Fri, 8 May 2026 11:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
 <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/7/26 19:26, Daniel Lezcano wrote:
> On 5/7/26 12:02, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 5/5/26 15:44, Daniel Lezcano wrote:
>>> In preparation for the upcoming changes separating OF and non-OF code,
>>> split __thermal_cooling_device_register() into allocation and addition
>>> phases.
>>>
>>> This allows moving the device node assignment out of the core
>>> initialization path.
>>>
>>> This change is not a trivial split. The lifetime of the cooling device
>>> is managed by the device core through put_device(), which triggers
>>> thermal_release() to free all associated resources.
>>>
>>> With the introduction of thermal_cooling_device_alloc(), the allocation
>>> path must mirror what thermal_release() undoes. In contrast,
>>> thermal_cooling_device_add() must not perform any rollback and relies
>>> on put_device() for cleanup on error paths. This avoids both double
>>> free and resource leaks.
>>>
>>> As part of this rework, add the missing device_initialize() call when
>>> allocating the cooling device.
>>>
>>> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>> ---
> 
> [ ... ]
> 
>>> +static int thermal_cooling_device_add(struct thermal_cooling_device 
>>> *cdev, void *devdata)
>>> +{
>>> +    unsigned long current_state;
>>> +    int ret;
>>> +
>>>       mutex_init(&cdev->lock);
>>>       INIT_LIST_HEAD(&cdev->thermal_instances);
>>> -    cdev->np = np;
>>> -    cdev->ops = ops;
>>>       cdev->updated = false;
>>>       cdev->device.class = &thermal_class;
>>> +    device_initialize(&cdev->device);
>>>       cdev->devdata = devdata;
>>> +    thermal_cooling_device_setup_sysfs(cdev);
>>> +
>>> +    ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>>> +    if (ret)
>>
>> In case of error here, when the cdev->device won't have this name,
>> would thermal_release() still be able to call the cleanup
>> for the sysfs bits?
>> IMHO the check 'if()' there might bite us and we might not free
>> the sysfs allocated memory.
> 
> Hmm, I wondering if we can invert dev_set_name() and 
> thermal_cooling_device_setup_sysfs() ?
> 


I've checked that. It looks like the guarded 'if()'
in thermal_release which needs a dev_name() to clean-up the memory i
an issue in this case.

When this dev_set_name() fails, we won't go into the
clean up code to free cdev->type, ida, cdev...

I would call them explicitly in case of 'if(ret)'
error from dev_set_name()...
Then the rest could end in case of error with that new
'put_device()' logic at the bottom.
Would you agree?

A different option would be to refactor thermal_release()
and somehow recognize the cooling device not based on name.
