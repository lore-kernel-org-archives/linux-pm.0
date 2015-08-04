From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Tue, 04 Aug 2015 15:50:51 +0100
Message-ID: <55C0D14B.60503@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>	<09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>	<55AD03BE.4070209@arm.com> <CAJ5Y-eauLrG7sM1zKFpAWmrvjfyC1KPV0y1OrNn6rZa=445mag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eauLrG7sM1zKFpAWmrvjfyC1KPV0y1OrNn6rZa=445mag@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 03/08/15 18:29, Ashwin Chaugule wrote:
> On 20 July 2015 at 10:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>>
>>> The ACPI processor driver is currently tied too closely
>>> to the ACPI P-states (PSS) and other related constructs
>>> for controlling CPU performance.
>>>
>>> The newer ACPI specification (v5.1 onwards) introduces
>>> alternative methods to PSS. These new mechanisms are
>>> described within each ACPI Processor object and so they
>>> need to be scanned whenever a new Processor object is detected.
>>> This patch introduces a new Kconfig symbol to allow for
>>> finer configurability among the two options for controlling
>>> performance states. There is no change in functionality and
>>> the option is auto-selected by the architecture Kconfig files.
>>>
>>> The following patchwork introduces CPPC: A newer method of
>>> controlling CPU performance. The OS is not expected to support
>>> CPPC and PSS at runtime. So the kconfig option lets us make
>>> these two mutually exclusive at compile time.
>>>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>> ---
>>>    arch/x86/Kconfig                |  1 +
>>>    drivers/acpi/Kconfig            | 19 ++++++---
>>>    drivers/acpi/Makefile           |  6 +--
>>>    drivers/acpi/processor_driver.c | 86
>>> +++++++++++++++++++++++++------------
>>>    drivers/cpufreq/Kconfig         |  2 +-
>>>    drivers/cpufreq/Kconfig.x86     |  2 +
>>>    include/acpi/processor.h        | 94
>>> +++++++++++++++++++++++++++--------------
>>>    7 files changed, 142 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 226d569..93d150d 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -143,6 +143,7 @@ config X86
>>>           select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>>>           select X86_FEATURE_NAMES if PROC_FS
>>>           select SRCU
>>> +       select ACPI_CPU_FREQ_PSS if ACPI
>>>
>>>    config INSTRUCTION_DECODER
>>>           def_bool y
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index ab2cbb5..00748dc 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -166,17 +166,26 @@ config ACPI_DOCK
>>>             This driver supports ACPI-controlled docking stations and
>>> removable
>>>             drive bays such as the IBM Ultrabay and the Dell Module Bay.
>>>
>>> +config ACPI_CPU_FREQ_PSS
>>> +       bool
>>> +       depends on ACPI_PROCESSOR && CPU_FREQ
>>> +       select THERMAL
>>> +       help
>>> +         This driver implements ACPI methods for controlling CPU
>>> performance
>>> +         using PSS methods as described in the ACPI spec. It also enables
>>> support
>>> +         for ACPI based performance throttling (TSS) and ACPI based
>>> thermal
>>> +         monitoring. It is required by several flavors of cpufreq
>>> +         performance-state drivers.
>>> +
>>
>>
>> Though I agree CPUFreq and the thermal control are related, having _PSS
>> in config name shouldn't match well IMO. You can have more generic name.
>
> Do you have any suggestions?
>

No, so I am fine with ACPI_CPU_FREQ_PSS for now, we can change later if
required as along as it's not user-selectable I suppose.

>>
>> You are selecting one config while depending on the other, any
>> particular reason ?
>>
>
> What is the problem? Sorry, I didn't follow.
>

Just follow what Rafael said, he explained it better than me, I was bit
vague here but implied same thing.

Regards,
Sudeep
