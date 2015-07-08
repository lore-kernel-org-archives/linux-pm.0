From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 08 Jul 2015 15:20:04 +0100
Message-ID: <559D3194.2000502@arm.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>	<2138469.Io9yItSdst@vostro.rjw.lan>	<CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>	<559D28EB.8000909@arm.com> <CAJ5Y-eYmjmSbSx6WojYGXv9iskJ5ty6f2eFu0iyKD4if5GPMhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eYmjmSbSx6WojYGXv9iskJ5ty6f2eFu0iyKD4if5GPMhg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 08/07/15 14:56, Ashwin Chaugule wrote:
> Hi Sudeep,
>
> On 8 July 2015 at 09:43, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 08/07/15 02:27, Ashwin Chaugule wrote:
>>>
>>> On 7 July 2015 at 21:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> On Monday, June 15, 2015 04:09:06 PM Ashwin Chaugule wrote:
>>>>>
>>>>> The ACPI processor driver is currently tied too closely
>>>>> to the ACPI C-states (CST), P-states (PSS) and other related
>>>>> constructs for controlling CPU idle and CPU performance.
>>>>>
>>>>> The newer ACPI specification (v5.1 onwards) introduces
>>>>> alternative methods to CST and PSS. These new mechanisms
>>>>> are described within each ACPI Processor object and so they
>>>>> need to be scanned whenever a new Processor object is detected.
>>>>> This patch introduces two new Kconfig symbols to allow for
>>>>> finer configurability among the various options for controlling
>>>>> CPU idle and performance states. There is no change in functionality
>>>>> and these options are defaulted to enabled to maintain previous
>>>>> behaviour.
>>>>>
>>>>> The following patchwork introduces CPPC: A newer method of
>>>>> controlling CPU performance. The OS is not expected to support CPPC
>>>>> and PSS at runtime. So the kconfig option lets us make these two
>>>>> mutually exclusive at compile time.
>>>>>
>>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>> Reviewed-by: Al Stone <al.stone@linaro.org>
>>>>> ---
>>>>>    drivers/acpi/Kconfig            |  31 +++++++++--
>>>>>    drivers/acpi/Makefile           |   7 ++-
>>>>>    drivers/acpi/processor_driver.c |  86 ++++++++++++++++++----------
>>>>>    drivers/cpufreq/Kconfig         |   2 +-
>>>>>    drivers/cpufreq/Kconfig.x86     |   2 +
>>>>>    include/acpi/processor.h        | 120
>>>>> ++++++++++++++++++++++++++++------------
>>>>>    6 files changed, 176 insertions(+), 72 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>>> index ab2cbb5..5942754 100644
>>>>> --- a/drivers/acpi/Kconfig
>>>>> +++ b/drivers/acpi/Kconfig
>>>>> @@ -166,18 +166,39 @@ config ACPI_DOCK
>>>>>           This driver supports ACPI-controlled docking stations and
>>>>> removable
>>>>>           drive bays such as the IBM Ultrabay and the Dell Module Bay.
>>>>>
>>>>> -config ACPI_PROCESSOR
>>>>> -     tristate "Processor"
>>>>> -     select THERMAL
>>>>> -     select CPU_IDLE
>>>>> +config ACPI_CST
>>>>> +     bool "ACPI C states (CST) driver"
>>>>> +     depends on ACPI_PROCESSOR
>>>>>         depends on X86 || IA64
>>>>> +     select CPU_IDLE
>>>>>         default y
>>>>>         help
>>>>>           This driver installs ACPI as the idle handler for Linux and
>>>>> uses
>>>>>           ACPI C2 and C3 processor states to save power on systems that
>>>>> -       support it.  It is required by several flavors of cpufreq
>>>>> +       support it.
>>>>> +
>>>>> +config ACPI_PSS
>>>>> +     bool "ACPI P States (PSS) driver"
>>>>> +     depends on ACPI_PROCESSOR
>>>>> +     depends on X86 || IA64
>>>>> +     select THERMAL
>>>>> +     default y
>>>>> +     help
>>>>> +       This driver implements ACPI methods for controlling CPU
>>>>> performance
>>>>> +       using PSS methods as described in the ACPI spec. It also enables
>>>>> support
>>>>> +       for ACPI based performance throttling (TSS) and ACPI based
>>>>> thermal
>>>>> +       monitoring. It is required by several flavors of cpufreq
>>>>>           performance-state drivers.
>>>>
>>>>
>>>> For starters, I don't like these new Kconfig options.
>>>>
>>>> Isn't there a way to implement what you need without adding them?
>>>
>>>
>>> We need to use the ACPI Processor driver for CPPC without including
>>> all its current dependencies. (i.e. PSS, TSS, CSS etc.). The upcoming
>>> LPI work from Sudeep will also face the same issue.
>>
>>
>> Ashwin, I am trying to keep Kconfig options minimum, iff necessary and
>> selected by ARCH code(i.e. not user selectable). Also I am not entirely
>> sure if we need to make PSS and CPPC mutually exclusive.
>
> Agree. Moving this to ARCH does seem like a better option. I need to
> explore that some more. Per the ACPI spec, the OS is not expected to
> support PSS and CPPC at runtime. I want to avoid getting into
> whitelist/blacklist issues which would be inevitable if we keep both
> available at runtime. Some of the X86 drivers run into this already.
>

OK, but as you say, both still be enabled statically while only one of
then should be active at run-time.

>>
>> I had seen patches to support PSS on ARM and if we have to support
>> single Image to handle both they can't be exclusive.
>
> Theres been one attempt about 1.5 years ago and AFAIK those folks have
> completely backed out of the ARM64 Server space . ;) We can revisit
> when someone proposes a more recent solution for PSS on ARM64. It
> shouldn't be too hard to change the Kconfig dependencies accordingly.
>

While I too can only guess that they have backed off, since CPPC
requires firmware, and if the hardware has PSS like interface, I can
imagine vendors pushing for that for convenience, so I would not rule
that out completely. But I agree as along as it can be changed easily,
we can defer that until there's a real hardware.

Regards,
Sudeep
