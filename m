From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 08 Jul 2015 14:43:07 +0100
Message-ID: <559D28EB.8000909@arm.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>	<2138469.Io9yItSdst@vostro.rjw.lan> <CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41181 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbbGHNnM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jul 2015 09:43:12 -0400
In-Reply-To: <CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>



On 08/07/15 02:27, Ashwin Chaugule wrote:
> On 7 July 2015 at 21:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, June 15, 2015 04:09:06 PM Ashwin Chaugule wrote:
>>> The ACPI processor driver is currently tied too closely
>>> to the ACPI C-states (CST), P-states (PSS) and other related
>>> constructs for controlling CPU idle and CPU performance.
>>>
>>> The newer ACPI specification (v5.1 onwards) introduces
>>> alternative methods to CST and PSS. These new mechanisms
>>> are described within each ACPI Processor object and so they
>>> need to be scanned whenever a new Processor object is detected.
>>> This patch introduces two new Kconfig symbols to allow for
>>> finer configurability among the various options for controlling
>>> CPU idle and performance states. There is no change in functionality
>>> and these options are defaulted to enabled to maintain previous
>>> behaviour.
>>>
>>> The following patchwork introduces CPPC: A newer method of
>>> controlling CPU performance. The OS is not expected to support CPPC
>>> and PSS at runtime. So the kconfig option lets us make these two
>>> mutually exclusive at compile time.
>>>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>> Reviewed-by: Al Stone <al.stone@linaro.org>
>>> ---
>>>   drivers/acpi/Kconfig            |  31 +++++++++--
>>>   drivers/acpi/Makefile           |   7 ++-
>>>   drivers/acpi/processor_driver.c |  86 ++++++++++++++++++----------
>>>   drivers/cpufreq/Kconfig         |   2 +-
>>>   drivers/cpufreq/Kconfig.x86     |   2 +
>>>   include/acpi/processor.h        | 120 ++++++++++++++++++++++++++++------------
>>>   6 files changed, 176 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index ab2cbb5..5942754 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -166,18 +166,39 @@ config ACPI_DOCK
>>>          This driver supports ACPI-controlled docking stations and removable
>>>          drive bays such as the IBM Ultrabay and the Dell Module Bay.
>>>
>>> -config ACPI_PROCESSOR
>>> -     tristate "Processor"
>>> -     select THERMAL
>>> -     select CPU_IDLE
>>> +config ACPI_CST
>>> +     bool "ACPI C states (CST) driver"
>>> +     depends on ACPI_PROCESSOR
>>>        depends on X86 || IA64
>>> +     select CPU_IDLE
>>>        default y
>>>        help
>>>          This driver installs ACPI as the idle handler for Linux and uses
>>>          ACPI C2 and C3 processor states to save power on systems that
>>> -       support it.  It is required by several flavors of cpufreq
>>> +       support it.
>>> +
>>> +config ACPI_PSS
>>> +     bool "ACPI P States (PSS) driver"
>>> +     depends on ACPI_PROCESSOR
>>> +     depends on X86 || IA64
>>> +     select THERMAL
>>> +     default y
>>> +     help
>>> +       This driver implements ACPI methods for controlling CPU performance
>>> +       using PSS methods as described in the ACPI spec. It also enables support
>>> +       for ACPI based performance throttling (TSS) and ACPI based thermal
>>> +       monitoring. It is required by several flavors of cpufreq
>>>          performance-state drivers.
>>
>> For starters, I don't like these new Kconfig options.
>>
>> Isn't there a way to implement what you need without adding them?
>
> We need to use the ACPI Processor driver for CPPC without including
> all its current dependencies. (i.e. PSS, TSS, CSS etc.). The upcoming
> LPI work from Sudeep will also face the same issue.

Ashwin, I am trying to keep Kconfig options minimum, iff necessary and
selected by ARCH code(i.e. not user selectable). Also I am not entirely
sure if we need to make PSS and CPPC mutually exclusive.

I had seen patches to support PSS on ARM and if we have to support
single Image to handle both they can't be exclusive.

Regards,
Sudeep
