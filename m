Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516907;
	b=4PtIJOBTE9EayjK4SH2jb2cVQv1g37mXayHZiSuwphCRrBK0CGO4GPwZM+CGtTpySIXy
	 OONEDTq7eMIzyCofxvXJJ0Cdu6uSuEFOimUVLCCYlnd7xipVOxKibY9lVzhraOK/MBIxa
	 xoL0gABQm+H/XQ25VGlaC3WRw50Vrac3alpclaP+BnjjT/fRtrIo1/AA54Skrw2U6WBh9
	 AobYN0UNICV2CTJErUtLonUH1FzloL5s6VAC8QMJV6JI1WFlpfgOmlzEIfSsDpk6ZWoMZ
	 0RyHFFKkbi8zqmCjhCQPmjtBp3Obb6XIDVeQp+L2lGQ6nDdN4D3JViZ4p95IcC1UbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516907;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vgcmEkpcBTw81FwcCrKxFpeJPtJmW3ABgqcPe83QVz8=;
	b=muCMgh7nxK5AIuSq0+sSCV2YdXVwOHtEXby33eiR8yXIM+MibhQlVAKSla/7Vv9CSbAQ
	 GVSclSA5HyHKwrW2VIFAfRNwD3bk34/33FP4qulvjTkWDN9dOFi55YXq84OoggUDoe7gG
	 jYxMb7yduCsKufNNowv1I4As9R+LQXZrfsK0jbtdHB4yLJpcbHfNlZ2FTz545RpSZncqV
	 2l2CrxeO1aAXXdbCpz2ef00lI4h27n9mRMBeWhk9fT3kbD389b0VXdxEWKEy+XnvHu5L+
	 YenWXoKPGQGPcyaH9lq1ZLEdFIW1cRnpeqLq1RVGLPxlbIOzwY7FT5oz56SCUl3Pr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="hAv/yxtn";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2D606A31C;
	Thu, 12 Nov 2026 20:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hAv/yxtn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A245E165C;
	Thu, 12 Nov 2026 12:55:02 -0800 (PST)
Received: from [10.57.15.226] (unknown [10.57.15.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E623F85F;
	Thu, 12 Nov 2026 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794516905; bh=Nf4X4H4ufaXRuSDyuLfEbax0/Ifq6aCzeD+Zmc1E8+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hAv/yxtnixyt4KN3qAK3Wwdp/t3t647d1CgVXDAZNKvkZh8Gn3MKXxLwhdSgEsxip
	 mINyMyMoAZ+1BO4LWKcoVM6nXHLDS1RtcN0W6FhxaKDuC4lQApmjikfiUD+CUTYyBp
	 Gof+W6wZyneClY+AGseq7TymYhfszV1wnSX3tqLQ=
Message-ID: <91039d3d-4438-486f-926b-8befd5a530b5@arm.com>
Date: Thu, 12 Nov 2026 20:55:02 +0000
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
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13049690.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/26 17:42, Rafael J. Wysocki (Intel) wrote:
> On Thu, Nov 12, 2026 at 6:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>
>> On a number of Intel platforms in the field, the nominal performance
>> value in ACPI _CPC (which is an integer) is larger than the guaranteed
> 
> I said "larger", but should have said "less".  Sorry about this.
> 
> Will fix this when applying the patch unless there are other comments.
> 
>> performance value and it may even be larger than the highest performance
>> value (that come from register reads).
>>
>> The new specification compliance checks involving those values added
>> by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
>> semantics") cause the CPPC library to refuse to work for some CPUs
>> on the affected systems which in turn causes the intel_pstate driver
>> to overestimate the maximum performance levels for those CPUs.  One
>> of the affected systems is Dell Pro 5 14 P514260.
>>
>> In this particular case, the fact that the specification is not
>> exactly followed has no implications and the checks enforcing
>> compliance are not useful, so drop them from the CPPC library.
>>
>> If really necessary, they will need to be done elsewhere.

They would've made things a littler clearer but I don't see why
we strictly need them right now.

>>
>> Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semantics")
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

>> ---
>>  drivers/acpi/cppc_acpi.c |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -2940,9 +2940,8 @@ int cppc_get_perf_caps(int cpunum, struc
>>         if (!high || !low || !nom || !ref || !min_nonlinear ||
>>             high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
>>             nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
>> -           high < nom || nom < min_nonlinear || min_nonlinear < low ||
>> -           (CPC_SUPPORTED(guaranteed_reg) &&
>> -            (guaranteed < low || guaranteed > nom))) {
>> +           nom < min_nonlinear || min_nonlinear < low ||
>> +           (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
>>                 ret = -EFAULT;
>>                 goto out_err;
>>         }
>>
>>
>>
>>

