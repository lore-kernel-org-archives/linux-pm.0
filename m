Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505F3F44FC;
	Tue, 25 Aug 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652593; cv=none; b=NHWbCPt/bOfJKpHG5c68T1/D9Jyxuaityso/EFGeQCjEDJb9R95qOaroSL5u07yCLKyvEaH00EK30koLszcTivWP/RVkkFHs58mc1wINQYF1fr1iJWzQSoFIEaTlGGhL6nKnw6pJKVtIDEMKIQ0XvCVfdpgHr9Fq53c0uvgRAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652593; c=relaxed/simple;
	bh=rSOE8NaKXtWy2vdGyxkOkbebVrGF1A2KUNS/AQx3sAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzjnr2hjzh2m1O9I0WNFBuTkb8RKUKOe4hDNy4Rc2oSViUn59K2b4YMv4LP67kC3+HEYUA5IBgo/hebGCUFj3E+uX9R5D0+EixlJcAln+jcByh8Rz1GWCgmAvPgr2BK9zGJy196j4mSQn4X/Xl+QKGvzBaDlPKrD6N6E1VppZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HkuOtuuC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HkuOtuuC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD7315A1;
	Tue, 25 Aug 2026 03:09:46 -0700 (PDT)
Received: from [10.57.6.192] (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6A43F7D8;
	Tue, 25 Aug 2026 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787652590; bh=rSOE8NaKXtWy2vdGyxkOkbebVrGF1A2KUNS/AQx3sAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HkuOtuuCBeudaU1ekS48336VYwbx350hF4nuIct7WAUocM8q3OkAEOUngTQacG1gN
	 Rg+is7Azz6HX4A/o6Ot6DziWHVIRRi170Tr33GNq7DFskmiKild1QAHrqtJqkJk+Bs
	 nYMLZ5VpMbV03PIjQ4DUU16iOPovdiFCbZeHRves=
Message-ID: <30f52840-81d8-4c18-8c96-676029d17ac4@arm.com>
Date: Tue, 25 Aug 2026 11:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <20260809062549.1415955-16-christian.loehle@arm.com>
 <cfc940e7-653e-4902-ac49-99bc7623c1bd@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <cfc940e7-653e-4902-ac49-99bc7623c1bd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/26 10:15, Sumit Gupta wrote:
> 
> On 09/08/26 11:55, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The Performance Limited status bits are sticky and write-zero-to-clear.
>> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
>> accesses.
>>
>> cppc_set_perf_limited() currently reads the register, computes a new value,
>> and writes it in a separate transaction. If the platform reports another
>> excursion between those transactions, the stale write can clear that new
>> event.
>>
>> Write zero to the requested bits and one to the other defined status bits
>> directly. Keep reserved bits zero as required for hardware status registers
>> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
>>
>> Reject SystemMemory descriptions which require read-modify-write to
>> preserve the containing access unit, because the per-descriptor spinlock
>> cannot interlock that RMW with platform updates. Also reject 64-bit
>> SystemMemory descriptions on 32-bit kernels, where generic readq()/writeq()
>> may be split into two 32-bit operations and cannot provide the required
>> portable interlocked access. A naturally aligned full-width QWord remains
>> supported on 64-bit kernels, where the architecture provides a native
>> 64-bit MMIO accessor.
>>
>> Performance Limited status is not required for CPPC control. If firmware
>> describes it using an access that Linux cannot interlock safely, disable
>> that status register instead of rejecting the processor's otherwise usable
>> _CPC package.
>>
>> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 33 ++++++++++++++++++++++-----------
>>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> On my test platform Performance Limited is a 2-bit field at offset 0 with
> Access Size 3 (DWord), so bit_width (2) != access_width (32). This is a
> valid GAS description. The mismatch only means that the generic writer
> would use RMW.
> 
> I agree with removing the stale read. However, even if writes are rejected
> for this partial width layout, reads do not require RMW. Could the register
> remain readable instead of being disabled completely?

Ack, I can turn this into read-only if not writable by the kernel.

> 
> If the register must be disabled, the current fallback is reported
> incorrectly. Performance Limited is mandatory in _CPC. cpc_disable_reg()
> replaces it with an Integer 0, but cppc_get_reg_val() only recognizes
> that as unsupported for registers in REG_OPTIONAL, which does not
> include PERF_LIMITED. Reads therefore succeed with zero while writes
> return -EOPNOTSUPP, so userspace sees "never limited" instead of
> "<unsupported>". This hides real events on a platform that can signal
> them.

Ack, I've fixed the getter.

> 
> Also, pr_err followed by pr_warn emits two messages per CPU for this
> nonfatal fallback. Could these messages be consolidated?

Ack

> 
> Thanks,
> Sumit
> ....
> 
> 

