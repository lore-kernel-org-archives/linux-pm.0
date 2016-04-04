From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
Date: Mon, 4 Apr 2016 10:32:37 +0200
Message-ID: <570226A5.4000304@semihalf.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
 <CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu-BHhf=aQ6ZP3J=q8T9FRtq-hfzTNvdJ3=HgMt=hVP8nQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Richard Ruigrok <rruigrok@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 30.03.2016 09:05, Ard Biesheuvel wrote:
> On 29 March 2016 at 09:44,  <fu.wei@linaro.org> wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This commit provides APEI arch-specific bits for aarch64
>>
>> Meanwhile,
>> (1)add a new subfunction "hest_ia32_init" for
>> "acpi_disable_cmcff" which is used by IA-32 Architecture
>> Corrected Machine Check (CMC).
>> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>> a generic place.
>> (3)select EFI when ACPI_APEI is set on ARM64,
>> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> I think selecting 'EFI' is not the right approach here, especially
> since EFI is implied by ACPI on that architecture. But selecting a
> user configurable option like this is typically not recommended. Why
> doesn't ACPI_APEI depend on ACPI?

It does, ACPI_APEI is subsection of the main ACPI menu option, but I 
don't see that ACPI implies EFI in Kconfig.

Also, I agree with Ard, EFI should not be selected conditionally for 
ARM64 for ACPI_APEI.

We need EFI only for ARM64 so how about:
+       select HAVE_ACPI_APEI if (ACPI && EFI)
in arch/arm64/Kconfig and leave ACPI_APEI as is?

Regards,
Tomasz


