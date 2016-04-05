From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
Date: Tue, 5 Apr 2016 21:49:52 +0800
Message-ID: <CADyBb7ssjznmnX7smtDxf0K9xQyxg8MaUsXmp9EpvR5MhH2F3Q@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
	<CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
	<570226A5.4000304@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36693 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759072AbcDENtx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 09:49:53 -0400
Received: by mail-oi0-f41.google.com with SMTP id y204so17840284oie.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2016 06:49:53 -0700 (PDT)
In-Reply-To: <570226A5.4000304@semihalf.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Richard Ruigrok <rruigrok@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>

Hi Tomasz,

On 4 April 2016 at 16:32, Tomasz Nowicki <tn@semihalf.com> wrote:
> On 30.03.2016 09:05, Ard Biesheuvel wrote:
>>
>> On 29 March 2016 at 09:44,  <fu.wei@linaro.org> wrote:
>>>
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>
>>> This commit provides APEI arch-specific bits for aarch64
>>>
>>> Meanwhile,
>>> (1)add a new subfunction "hest_ia32_init" for
>>> "acpi_disable_cmcff" which is used by IA-32 Architecture
>>> Corrected Machine Check (CMC).
>>> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>>> a generic place.
>>> (3)select EFI when ACPI_APEI is set on ARM64,
>>> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>>
>>
>> I think selecting 'EFI' is not the right approach here, especially
>> since EFI is implied by ACPI on that architecture. But selecting a
>> user configurable option like this is typically not recommended. Why
>> doesn't ACPI_APEI depend on ACPI?
>
>
> It does, ACPI_APEI is subsection of the main ACPI menu option, but I don't
> see that ACPI implies EFI in Kconfig.
>
> Also, I agree with Ard, EFI should not be selected conditionally for ARM64
> for ACPI_APEI.
>
> We need EFI only for ARM64 so how about:
> +       select HAVE_ACPI_APEI if (ACPI && EFI)
> in arch/arm64/Kconfig and leave ACPI_APEI as is?

I also agree with Ard, and I like "select HAVE_ACPI_APEI if (ACPI && EFI)"

Thanks for your suggestion !! :-)

>
> Regards,
> Tomasz
>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
