Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E1422E3F;
	Mon, 14 Sep 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378192; cv=none; b=ke1udu8+LajvyXiR29pLJeBtKjbfJo0ecK6biFGMysDvEBw++uv/1GWHp7Mf1f5E5AuqUr3czIlys1LFtIx0PhH0DlJjSCMd5ruZbqSx0eZTpi3Bed5X7tUtf294LfnSSJmNYzioJ4eb8/fBXEDTY9SFCZNXStRyNuKRyCFRk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378192; c=relaxed/simple;
	bh=WgFDTRyIzj72ID3M8rCFA6KeJAl2VOfUbS2RSxda34M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozntfvyPWTljxwjOQPb4WVW5eWKvNjypWjSji9TKdsPgVLBQtvLy32v9tK/DWC+uI5auruwFLQd17h7AFUtJYukRv3GWHpaJJa/PrsCqKDu1NqHLikkeQaS1LyeDgrUlIFj5Ebl6w0bvhu+Ulx0VpDoRe6fqRUJ1SrcuCh9rnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CqIni/X+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CqIni/X+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9532F152B;
	Mon, 14 Sep 2026 02:29:42 -0700 (PDT)
Received: from [10.0.129.72] (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82BDA3F59E;
	Mon, 14 Sep 2026 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789378186; bh=WgFDTRyIzj72ID3M8rCFA6KeJAl2VOfUbS2RSxda34M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CqIni/X+msMkTBJ38OtxnAmKm3vT4WfopjM7VTolXtMzfVTqCtuuwBWm8px50pxfY
	 VKOgsxPcXTjc8cUIu0A0TnCmZjb+xok+KPMktvxetNwT+RUocshLNspgSFn3BWh7ja
	 n4j2+vDS9RoW++2VD6TWPcOcL1vDP6Oot8PCnDWw=
Message-ID: <92b9c67b-677c-4cfe-8055-13f8e3e9c2cf@arm.com>
Date: Mon, 14 Sep 2026 10:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/15] ACPI: CPPC: Validate _CPC entry and control
 semantics
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com,
 Sashiko <sashiko-bot@kernel.org>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-3-christian.loehle@arm.com>
 <e363804d-78d7-4f09-8d49-f70a4dfc6f71@arm.com>
 <CAJZ5v0j=n4uf=GFVDumb2v1sqcS_f293BG2iCD-Vmp2vpLC=xg@mail.gmail.com>
 <CAJZ5v0igEL-WvvCSadRkGDdZaXRJM0kPAH8i918T+FaDg9oZ5A@mail.gmail.com>
 <7985c629-8d36-4562-a789-074d35e9f260@arm.com>
 <CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com>
 <CAJZ5v0ieZt_FSM4e=F_UjvN_oZbbiU_aHQgfFk2jifqW2Un5rw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0ieZt_FSM4e=F_UjvN_oZbbiU_aHQgfFk2jifqW2Un5rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/26 18:13, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 4, 2026 at 6:57 PM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
>>
>> On Thu, Sep 3, 2026 at 10:02 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 9/3/26 20:44, Rafael J. Wysocki (Intel) wrote:
>>>> On Thu, Sep 3, 2026 at 9:27 PM Rafael J. Wysocki (Intel)
>>>> <rafael@kernel.org> wrote:
>>>>>
>>>>> On Sun, Aug 30, 2026 at 3:32 PM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 8/30/26 12:56, Christian Loehle wrote:
>>>>>>> Writable _CPC controls are Register descriptors encoded as Buffer objects.
>>>>>>> Integer entries represent fixed values or unsupported optional registers;
>>>>>>> Autonomous Selection Integer 1 is the special immutable form which enables
>>>>>>> operation without Desired Performance.
>>>>>>>
>>>>>>> The parser accepts arbitrary object types and cpc_write() assumes that its
>>>>>>> argument contains a GAS. Malformed firmware can therefore make it interpret
>>>>>>> an Integer union member as a register.
>>>>>>>
>>>>>>> Validate the portion of each encoding consumed by the driver: bound Integer
>>>>>>> DWORD forms to 32 bits, and require Buffer entries to start with a complete
>>>>>>> Generic Register descriptor with the expected header. Continue tolerating
>>>>>>> Integer 0 for an absent optional register and retain type checks in
>>>>>>> cpc_write() as defense in depth. Reject an attempt to disable immutable
>>>>>>> Autonomous Selection instead of silently applying only the EPP part of the
>>>>>>> request.
>>>>>>>
>>>>>>> Capability registers are read into u64 temporaries but exposed through u32
>>>>>>> fields. Reject values above U32_MAX instead of allowing them to be
>>>>>>> truncated. In particular, a truncated Highest Performance value can become
>>>>>>> a zero divisor in the performance-to-frequency conversion. Enforce the
>>>>>>> required ordering from Highest through Nominal, Lowest Nonlinear, and
>>>>>>> Lowest Performance, and constrain a present Guaranteed Performance to the
>>>>>>> inclusive Lowest-to-Nominal range. Also reject reversed frequency anchors
>>>>>>> and unequal frequency anchors with identical performance anchors. Those
>>>>>>> invalid tuples otherwise make affine-conversion differences wrap or divide
>>>>>>> by zero.
>>>>>>>
>>>>>>> Check mandatory object presence separately from the Integer-zero convention
>>>>>>> for absent optional fields. ACPI does not reserve zero in the abstract
>>>>>>> Lowest Performance scale, so accept a present Lowest Performance DWORD of
>>>>>>> zero when distinct frequency anchors provide a usable nonzero physical
>>>>>>> minimum. Retain the old rejection when that mapping is unavailable and the
>>>>>>> fallback conversion would expose a 0 kHz cpufreq endpoint.
>>>>>>>
>>>>>>> Minimum Performance also defines zero as a real no-limit value, but the
>>>>>>> exported cppc_set_perf() interface historically used zero to omit a bound.
>>>>>>> Add explicit validity flags so callers can request zero without changing
>>>>>>> that legacy convention. Populate the flags when reading the controls and
>>>>>>> mark the bounds supplied by amd-pstate explicitly.
>>>>>>>
>>>>>>> Performance Limited is listed as a required Buffer, but the interface does
>>>>>>> not depend on it to control performance and the specification permits a
>>>>>>> platform with no limiting indication to always report zero. Preserve
>>>>>>> the compatibility with firmware that represents that case using a NULL
>>>>>>> register descriptor instead of disabling CPPC entirely.
>>>>>>>
>>>>>>> Emit an error when a present _CPC package fails parsing or initialization
>>>>>>> so such firmware and resource failures no longer silently suppress cpufreq.
>>>>>>> Initialize malformed-package failures to -EINVAL and preserve specific
>>>>>>> allocation, mapping, and unsupported-access errors in that diagnostic.
>>>>>>>
>>>>>>> Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
>>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>>> Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>>>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>>>>> ---
>>>>>>>  drivers/acpi/cppc_acpi.c     | 172 ++++++++++++++++++++++++++++++-----
>>>>>>>  drivers/cpufreq/amd-pstate.c |  12 ++-
>>>>>>>  include/acpi/cppc_acpi.h     |   2 +
>>>>>>>  3 files changed, 159 insertions(+), 27 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>>> index 3b8cdf88e31d..6f3ffa4a1845 100644
>>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>>> @@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>>>>>>                               !!(cpc)->cpc_entry.int_value :          \
>>>>>>>                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
>>>>>>>
>>>>>>> +static bool cpc_is_writable(const struct cpc_register_resource *cpc)
>>>>>>> +{
>>>>>>> +     return cpc->type == ACPI_TYPE_BUFFER &&
>>>>>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static bool cpc_entry_present(const struct cpc_register_resource *cpc)
>>>>>>> +{
>>>>>>> +     if (cpc->type == ACPI_TYPE_INTEGER)
>>>>>>> +             return true;
>>>>>>> +
>>>>>>> +     return cpc->type == ACPI_TYPE_BUFFER &&
>>>>>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
>>>>>>> +}
>>>>>>> +
>>>>>>>  /*
>>>>>>>   * Each bit indicates the optionality of the register in per-cpu
>>>>>>>   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>>>>>>> @@ -142,6 +157,29 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>>>>>>   */
>>>>>>>  #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
>>>>>>>
>>>>>>> +static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value)
>>>>>>> +{
>>>>>>> +     switch (reg_idx) {
>>>>>>> +     case HIGHEST_PERF:
>>>>>>> +     case NOMINAL_PERF:
>>>>>>> +     case LOW_NON_LINEAR_PERF:
>>>>>>> +     case LOWEST_PERF:
>>>>>>> +     case CTR_WRAP_TIME:
>>>>>>> +     case REFERENCE_PERF:
>>>>>>> +     case LOWEST_FREQ:
>>>>>>> +     case NOMINAL_FREQ:
>>>>>>> +             return value <= U32_MAX;
>>>>>>
>>>>>>
>>>>>> Sashiko:
>>>>>> "Does this incorrectly restrict the counter wraparound time to 32 bits?
>>>>>> The ACPI specification allows firmware to provide a 64-bit QWord integer
>>>>>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure already
>>>>>> models this as a 64-bit value internally
>>>>>> If firmware provides a valid 64-bit integer exceeding U32_MAX for this
>>>>>> register, cpc_integer_entry_valid() will return false and completely abort
>>>>>> CPPC initialization for the CPU. Can we remove this restriction for
>>>>>> CTR_WRAP_TIME?"
>>>>>
>>>>>> This is true. ACPI spec 6.6 and 6.5 (Table 8.23) describe it as
>>>>>> Integer (DWORD) or Buffer
>>>>>> The 64-bit internal representation is only for the case of firmware
>>>>>> providing it as Buffer.
>>>>
>>>> Sashiko is right, the table in the spec is wrong.  If it is Integer,
>>>> it is 64-bit.
>>>>
>>>> The size of an Integer in ASL cannot be restricted.
>>>
>>> Duh, thanks!
>>>
>>>>
>>>>>>
>>>>>>> +     case AUTO_SEL_ENABLE:
>>>>>>> +             return value <= 1;
>>>>>>> +     case DESIRED_PERF:
>>>>>>> +             /* Validated against Autonomous Selection after parsing. */
>>>>>>> +             return value == 0;
>>>>>>> +     default:
>>>>>>> +             /* Tolerate the customary Integer 0 for an absent option. */
>>>>>>> +             return value == 0 && IS_OPTIONAL_CPC_REG(reg_idx);
>>>>>>> +     }
>>>>>>> +}
>>>>>>> +
>>>>>> Sashiko:
>>>>>> "Does this incorrectly restrict the counter wraparound time to 32 bits?
>>>>>> The ACPI specification allows firmware to provide a 64-bit QWord integer
>>>>>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure already
>>>>>> models this as a 64-bit value internally.
>>>>>> If firmware provides a valid 64-bit integer exceeding U32_MAX for this
>>>>>> register, cpc_integer_entry_valid() will return false and completely abort
>>>>>> CPPC initialization for the CPU. Can we remove this restriction for
>>>>>> CTR_WRAP_TIME?"
>>>>>
>>>>> It looks like you pasted the same comment twice.  Or did Sashiko hallucinate?
>>>>
>>>> Well, its other comment is actually different from the first one.  Let
>>>> me paste it:
>>>
>>> Apparently I hallucinated :)
>>>
>>>>
>>>> Will this strict rejection break CPPC initialization on compliant firmware
>>>> that provides non-zero integers for other optional capabilities?
>>>> For capability registers not explicitly listed in the switch statement
>>>> above, such as GUARANTEED_PERF or TIME_WINDOW, the ACPI 6.5 specification
>>>> explicitly allows platforms to provide fixed non-zero values encoded as
>>>> Integer objects.
>>>>
>>>> When firmware provides a valid non-zero integer for these optional
>>>> registers, this default case enforces that the value must be zero. Since
>>>> acpi_cppc_processor_probe() fails and returns -EINVAL when this returns
>>>> false, it will completely disable cpufreq and CPPC support for the CPU.
>>>> Should we allow non-zero integer values for these other optional registers?
>>>>
>>>>>> GUARANTEED_PERF and TIME_WINDOW: both are Buffer-only Register descriptors.
>>>>>> Nonzero Integer encodings are invalid and Integer 0 is tolerated because
>>>>>> the previous parser allowed it too. I don't know of any platform describing
>>>>>> this myself.
>>>>
>>>> Strictly speaking Integer 0 is not allowed, see
>>>>
>>>> https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.html#cpc-continuous-performance-control
>>>
>>> I'm happy to reject it too, I was just being careful here because I only have
>>> a tiny subset of ACPI platforms to test this on with and it's for -fixes
>>
>> Instead of rejecting it entirely, you may log an FW_BUG message when
>> it is used, to avoid breaking legacy platforms that possibly used it.
> 
> Still waiting for an update here and reviews from folks.
> 
> If this is the only patch that needs to be updated, please just send
> an update of it alone.

I know, unfortunately I had to update some of the later patches, too.
I'll send the entire series shortly.
Thanks!
