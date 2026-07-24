Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458252459CF;
	Fri, 24 Jul 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876090; cv=none; b=o8KNozuH57jxAlawI5GLvQvjQUEyu5Zx/JfJ8Y3GzCdMx1V34sTlWK0zeAG0fmiTC4U1+uJ3GZTvaQmupJyNa0JeobHLRxOM9u/fJ0AK4a3Cewo3yTfgNQxx+87jvqvPDz9XUliyaMP3xmlYcbAQV6OR4zqnRuXv4VVa1Z9W6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876090; c=relaxed/simple;
	bh=UcYsclmSnXDuRJxtXEqaOrEFSqfjn1nfujfydkAukX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PL59LnZ2ZSd3VLQ5KGJ67sk2MI6/TDD5exU/13WUqVsx3D0tPE5UE4Rn+fBm8QTzaDFD84+Itg3s6oEJS+qZUrtB9fUT8sRWRhX2CSQo/MBMONBkp4Dx0zzZkhMOu600Vg1/OYNZ/2bWiJ+LTIJsEE/0qV/L6fFQOSPZdLn0R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RL3cb0dI; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RL3cb0dI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZZ9wD0bHu7C6FIU0gbjSx9ENwrDAhD2GONzun/GEI6E=;
	b=RL3cb0dIVM2NH26gCgWpNRXxZK5ew9qpMyXKHy/GXxIHcgVBpBR43cQEbeMiUm/8SBCWVypNr
	NQWN/Vl8KT5cFmoz0kdiyKh+C1IQXGBkRzVra2gtpnYYdrPjzu7ygVzeLge4qyE/6SuhONPm2EN
	s4RhlKI+BPCdQxVClRu5DeE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h5z533lFczmVWf;
	Fri, 24 Jul 2026 14:45:11 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 852BA40586;
	Fri, 24 Jul 2026 14:54:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 24 Jul
 2026 14:54:34 +0800
Message-ID: <300d0c34-4d40-4d9b-86e6-c47ca776fc6e@huawei.com>
Date: Fri, 24 Jul 2026 14:54:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ACPI: CPPC: Prepare cpc_register_resource for
 Package-type entries
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>, <lenb@kernel.org>,
	<zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>, <sumitg@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260717024502.3520445-1-zhenglifeng1@huawei.com>
 <20260717024502.3520445-2-zhenglifeng1@huawei.com>
 <CAJZ5v0ggjYqUe+J97=iSBQ5UzqLixQaXKXf=tNre2unPZOvUyQ@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0ggjYqUe+J97=iSBQ5UzqLixQaXKXf=tNre2unPZOvUyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 7/22/2026 3:04 AM, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 17, 2026 at 4:46 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) introduces the Resource
>> Priority entry, which is a Package of sub-packages rather than a
>> plain Integer or Buffer register.  The existing cpc_register_resource
>> union only accommodates Integer and Buffer (register descriptor)
>> fields.
>>
>> Add a Package variant to the cpc_entry union so that nested
>> structures such as RESOURCE_PRIORITY can store their element count
>> and a dynamically allocated array of child cpc_register_resource
>> descriptors.
>>
>> Update the CPC_SUPPORTED() macro to recognise Package-type entries
>> with a non-zero element count, and switch the unsupported-Package
>> fallback from a zero Integer to an empty Package (count = 0,
>> elements = NULL) so that CPC_SUPPORTED() correctly reports such
>> entries as unsupported.
>>
>> No functional change intended; the new Package fields are not yet
>> consumed by any caller.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 19 +++++++++++++------
>>  include/acpi/cppc_acpi.h |  8 ++++++++
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 9f572f481241..d7e654f2a66c 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -124,10 +124,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>                                 (reg)->bit_offset == 0 &&               \
>>                                 (reg)->access_width == 0)
>>
>> -/* Evaluates to True if an optional cpc field is supported */
>> -#define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?         \
>> -                               !!(cpc)->cpc_entry.int_value :          \
>> -                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
>> +/*
>> + * Evaluates to True if an optional cpc field is supported.
>> + * Integer: non-zero value; Buffer: non-NULL register; Package: non-empty.
>> + */
>> +#define CPC_SUPPORTED(cpc) (((cpc)->type == ACPI_TYPE_INTEGER &&       \
>> +                            !!(cpc)->cpc_entry.int_value) ||           \
>> +                           ((cpc)->type == ACPI_TYPE_BUFFER &&         \
>> +                            !IS_NULL_REG(&(cpc)->cpc_entry.reg)) ||    \
>> +                           ((cpc)->type == ACPI_TYPE_PACKAGE &&        \
>> +                            (cpc)->cpc_entry.package.count != 0))
> 
> My immediate concern regarding this change in particular is that it
> potentially causes invalid data structures to be used as "supported".
> 
> Suppose that some defective platform firmware supplies a package in a
> field that by the spec can only be a buffer and the length of that
> package is greater than zero.  The macro will produce 'true' then
> which is invalid.
> 
> It looks like there should be three different macros like the above
> for the three different types of _CPC fields: the buffer/integer ones,
> the buffer-only ones and the single package field.
> 
> And I'm not sure how much of a value there is in complicating the
> overall parsing of all fields just in order to be able to handle the
> last special one in a "generic" fashion.
> 
> As this stands now, it is a "no" from me, sorry.

See your point. Currently, this macro is used solely to check for support
before reading or writing cpc_reg. Therefore, it doesn't need to cover the
package type and can remain unchanged. I will remove this modification in
the next version.

The remaining patches do not depend on this modification and can continue
to be reviewed. Requesting further feedback on the remaining patches.

Thanks.

> 
>>
>>  /*
>>   * Each bit indicates the optionality of the register in per-cpu
>> @@ -859,8 +865,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>                          * Mark the register as unsupported for now.
>>                          */
>>                         pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
>> -                       cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
>> -                       cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
>> +                       cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
>> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = 0;
>> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = NULL;
>>                 } else {
>>                         pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>>                                  i, pr->id);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 8693890a7275..1839582b80be 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -71,6 +71,14 @@ struct cpc_register_resource {
>>         union {
>>                 struct cpc_reg reg;
>>                 u64 int_value;
>> +               /*
>> +                * CPPC v4: nested Package (e.g. RESOURCE_PRIORITY),
>> +                * elements dynamically allocated
>> +                */
>> +               struct {
>> +                       u32 count;
>> +                       struct cpc_register_resource *elements;
>> +               } package;
>>         } cpc_entry;
>>  };
>>
>> --
>> 2.33.0
>>

