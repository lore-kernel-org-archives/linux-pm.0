From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 3/9] ACPI: Enable PPTT support on ARM64
Date: Fri, 5 Jan 2018 23:07:27 +0100
Message-ID: <CAJZ5v0gP3ty=TBVXfUUSjXO2s0C9Mmp1z2cjuVbH4Hc+oaG1qQ@mail.gmail.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com> <20171201222330.18863-4-jeremy.linton@arm.com>
 <20171213172647.GA3316@red-moon> <f0f8c79a-2ff2-abe9-4a16-79485f0a1e2c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f0f8c79a-2ff2-abe9-4a16-79485f0a1e2c@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Al Stone <ahs3@redhat.com>, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 5, 2018 at 10:58 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
>
> On 12/13/2017 11:26 AM, Lorenzo Pieralisi wrote:
>>
>> On Fri, Dec 01, 2017 at 04:23:24PM -0600, Jeremy Linton wrote:
>>>
>>> Now that we have a PPTT parser, in preparation for its use
>>> on arm64, lets build it.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/Kconfig    | 1 +
>>>   drivers/acpi/Kconfig  | 3 +++
>>>   drivers/acpi/Makefile | 1 +
>>>   3 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index a93339f5178f..e62fd1e08c1f 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -7,6 +7,7 @@ config ARM64
>>>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>>         select ACPI_MCFG if ACPI
>>>         select ACPI_SPCR_TABLE if ACPI
>>> +       select ACPI_PPTT if ACPI
>>>         select ARCH_CLOCKSOURCE_DATA
>>>         select ARCH_HAS_DEBUG_VIRTUAL
>>>         select ARCH_HAS_DEVMEM_IS_ALLOWED
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 46505396869e..df7aebf0af0e 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -545,6 +545,9 @@ config ACPI_CONFIGFS
>>>     if ARM64
>>>   source "drivers/acpi/arm64/Kconfig"
>>> +
>>> +config ACPI_PPTT
>>> +       bool
>>
>>
>> We need to make a choice here. Either PPTT is considered ARM64 only and
>> we move code and config to drivers/acpi/arm64/Kconfig or we leave it in
>> drivers/acpi/pptt.c and we add a Kconfig entry in drivers/acpi/Kconfig
>> (and we make pptt.c compile on !ARM64 - which is what it should be given
>> that there is nothing ARM64 specific in it).
>
>
> No one else has expressed and opinion about this here..
>
> So i'm not sure what to think.
>
> OTOH a lot of people didn't like it when I had it in the arm64 directory,
> which was my original opinion. It seems other people thought that at some
> point in the future other ACPI platforms would want to use it so putting it
> in the arm64 directory was a mistake.

In my view it may go directly into drivers/acpi/ for the time being.

That said, going forward it may be useful to add a special
subdirectory under drivers/acpi/ for these "table drivers" as we seem
to be acquiring them at alarming rate.

> So, I'm leaning towards leaving it like it is, under the assumption that
> when someone puts in the effort to verify it on another ACPI platform they
> can move the config option up 6 lines. In the meantime I don't think it
> should be enabled on platforms where it hasn't been tested or is basically
> blocked (cpu_cacheinfo->cpu_map_populated) from executing or there isn't
> currently any benefit.

Agreed.

Thanks,
Rafael
