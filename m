Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517593;
	b=hfXTqiHWZjVMBzfBP7YvK4zIh+pCzHewqcrD48bqvMop+vlpjtjoFj7QkEcXmy8CLlL/
	 OF6MnkrutAZkaNxKmIRjTBAid/Mhu0Oj1JfjSCp5MRgbBIRk8PUqLxRnpGFLXX5oXm52F
	 96k2uX8IiuJYVGvMc9d2ScAjEDor+RnWhdSLhpUCAxwFDXnthkkryMsuXpFYPUjG2S+Q1
	 GcJqgsCEhgsuQBBftynVPd0toCsJcP4sRT33wPZAXsPbT3B7+7Q6aQ6XJ+S38kj+qXobk
	 xLuP/n7T9KatRuSophYfjG1XTNXK5DNu984TosPcOP+pmGnbVy6UXGTNYSUyXxQVsZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VLTfCKEwueGHbRl3WyTB0+V2R3fvLjdyeKZ19VI2bSI=;
	b=uqkKbWu//nYf2oEcTNg+Pc29W8ZUty7XGlXZdoIdfRTccENart5idzXBA2kOITCxrHoN
	 VvNYegsLntpkpotb/iwy9oepxwtdVZn27suLlCUdDAaGQ4aQJeXyTl2MeMWyVh3bOlwl4
	 ckKDp5nG+/etj1kIsSjiEUwFk8rRfN5po6hI7/HfEnpNwG0JMHFiWlyhdHFKyaXklcU5a
	 S1SF5GUoU0VFfyTonyywWuR3c2IPTQmzZbOTGfLj91Jlb1puYT1wCO7eM0YwCB/bHUktQ
	 5TPw9i2JN+stNVv6wxkjKmxkchd0j3jEP2KZHZJx5W5XiS/CzHA24rYwX/5B8TkJwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Vb13PdSd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A8606A321;
	Thu, 12 Nov 2026 21:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Vb13PdSd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 760401516;
	Thu, 12 Nov 2026 13:06:29 -0800 (PST)
Received: from [10.57.15.226] (unknown [10.57.15.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916A93F632;
	Thu, 12 Nov 2026 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794517592; bh=foCA1guz/PuX6Re53l5emVf5KW/MfXRS+qU1BNc9/oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vb13PdSd/ylnUiZuIhTrXKO9L/nJpvelwG9Yp1eVH/luzlOYOWKz/sRqtUq7la8/4
	 KT7GtZPuZ/3CRFsB572YBbI9rHJvhFYf8ikico/1QCK6L4xZbU2PekV4joQ4Lf3tls
	 nq9GyxVXdKsLoATbQ4RfSnJDnkaW3nc+CieCJlZQ=
Message-ID: <da4540c7-bbbd-416e-baea-9b4cf1dcb348@arm.com>
Date: Thu, 12 Nov 2026 21:06:28 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: CPPC: Drop two compliance checks involving
 nominal performance
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13049690.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
 <91039d3d-4438-486f-926b-8befd5a530b5@arm.com>
 <CAJZ5v0iudeZCOJEm_zepr8iZiShVHNiexOYrmNSCV-msXRW6jw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iudeZCOJEm_zepr8iZiShVHNiexOYrmNSCV-msXRW6jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/26 21:02, Rafael J. Wysocki (Intel) wrote:
> On Thu, Nov 12, 2026 at 9:55 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/12/26 17:42, Rafael J. Wysocki (Intel) wrote:
>>> On Thu, Nov 12, 2026 at 6:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>>
>>>> On a number of Intel platforms in the field, the nominal performance
>>>> value in ACPI _CPC (which is an integer) is larger than the guaranteed
>>>
>>> I said "larger", but should have said "less".  Sorry about this.
>>>
>>> Will fix this when applying the patch unless there are other comments.
>>>
>>>> performance value and it may even be larger than the highest performance
>>>> value (that come from register reads).
>>>>
>>>> The new specification compliance checks involving those values added
>>>> by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
>>>> semantics") cause the CPPC library to refuse to work for some CPUs
>>>> on the affected systems which in turn causes the intel_pstate driver
>>>> to overestimate the maximum performance levels for those CPUs.  One
>>>> of the affected systems is Dell Pro 5 14 P514260.
>>>>
>>>> In this particular case, the fact that the specification is not
>>>> exactly followed has no implications and the checks enforcing
>>>> compliance are not useful, so drop them from the CPPC library.
>>>>
>>>> If really necessary, they will need to be done elsewhere.
>>
>> They would've made things a littler clearer but I don't see why
>> we strictly need them right now.
>>
>>>>
>>>> Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semantics")
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
> Thank you!
> 
> I will need to update the patch because the nom vs min_nonlinear check
> is also affected.
> 
> I'll send a v2 tomorrow with your R-by if that's OK.

All good!

> [snip]
