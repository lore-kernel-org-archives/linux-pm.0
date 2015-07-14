From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Tue, 14 Jul 2015 22:24:10 +0800
Message-ID: <55A51B8A.4050702@linaro.org>
References: <55A3D7A3.90609@linaro.org> <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/14/2015 04:06 PM, Lukasz Anaczkowski wrote:
> On 07/13/2015 23:22 PM, Hanjun Guo wrote:
>>> In case when BIOS is populating MADT wiht both x2apic and local apic
>>> entries (as per ACPI spec), kernel builds it's processor table
>>> in the following order: BSP, X2APIC, local APIC, resulting in
>>> processors on the same core are not separated by core count.
>>
>> I'm confused here, I can't figure out where is the problem, could you
>> explain it in detail?
>>
>> For me, logical CPU IDs allocated by OS will have mappings to physical
>> CPU IDs, what you are saying seems CPU topology problem to me.
>
> Sorry for confusion, I'll send another patch with updated commit message
> where I'll try to put some more details and explanation. Hope that one will
> be less confusing.
>
>>>    arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
>>>    drivers/acpi/numa.c         | 28 ++++++++++++-----
>>>    drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
>>>    drivers/irqchip/irq-gic.c   | 15 ++++++---
>>
>> Anyway, You also miss the SMP boot for ARM64 in ACPI way, which will
>> cause compile error on ARM64.
>
> The only symbol that's changed is acpi_parse_entries and I don't see
> any calls to it in ARM64. I also tried compilation of arm64/defconfig
> and it compiles fine. Could yoy point me to place where it might failing?

Sorry, I misread your patch that you modified acpi_table_parse_madt()
also, but it turns out that you keep it as before, sorry for the noise.

Thanks
Hanjun

