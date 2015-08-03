From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Mon, 3 Aug 2015 13:24:20 -0400
Message-ID: <CAJ5Y-easSpFEpyOVT0YxDAZujXHEnWC1v34gKLMMo5Qz9f+cLA@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>
	<3655608.oFpclyKJ6p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36446 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbHCRYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 13:24:22 -0400
Received: by labgo9 with SMTP id go9so32644158lab.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 10:24:21 -0700 (PDT)
In-Reply-To: <3655608.oFpclyKJ6p@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 17 July 2015 at 20:01, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, July 09, 2015 02:04:18 PM Ashwin Chaugule wrote:
>> The ACPI processor driver is currently tied too closely
>> to the ACPI P-states (PSS) and other related constructs
>> for controlling CPU performance.
>>
>> The newer ACPI specification (v5.1 onwards) introduces
>> alternative methods to PSS. These new mechanisms are
>> described within each ACPI Processor object and so they
>> need to be scanned whenever a new Processor object is detected.
>> This patch introduces a new Kconfig symbol to allow for
>> finer configurability among the two options for controlling
>> performance states. There is no change in functionality and
>> the option is auto-selected by the architecture Kconfig files.
>>
>> The following patchwork introduces CPPC: A newer method of
>> controlling CPU performance. The OS is not expected to support
>> CPPC and PSS at runtime. So the kconfig option lets us make
>> these two mutually exclusive at compile time.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  arch/x86/Kconfig                |  1 +
>>  drivers/acpi/Kconfig            | 19 ++++++---
>>  drivers/acpi/Makefile           |  6 +--
>>  drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++------------
>>  drivers/cpufreq/Kconfig         |  2 +-
>>  drivers/cpufreq/Kconfig.x86     |  2 +
>>  include/acpi/processor.h        | 94 +++++++++++++++++++++++++++--------------
>>  7 files changed, 142 insertions(+), 68 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 226d569..93d150d 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -143,6 +143,7 @@ config X86
>>       select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>>       select X86_FEATURE_NAMES if PROC_FS
>>       select SRCU
>> +     select ACPI_CPU_FREQ_PSS if ACPI
>>
>>  config INSTRUCTION_DECODER
>>       def_bool y
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ab2cbb5..00748dc 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -166,17 +166,26 @@ config ACPI_DOCK
>>         This driver supports ACPI-controlled docking stations and removable
>>         drive bays such as the IBM Ultrabay and the Dell Module Bay.
>>
>> +config ACPI_CPU_FREQ_PSS
>> +     bool
>> +     depends on ACPI_PROCESSOR && CPU_FREQ
>> +     select THERMAL
>> +     help
>> +       This driver implements ACPI methods for controlling CPU performance
>> +       using PSS methods as described in the ACPI spec. It also enables support
>> +       for ACPI based performance throttling (TSS) and ACPI based thermal
>> +       monitoring. It is required by several flavors of cpufreq
>> +       performance-state drivers.
>
> So are you not agreeing with what I've said for a few times already or are you
> just not listening?
>
> This option should *not* be user-selectable.  So please drop the help part
> and make it look like ACPI_SLEEP, for example.

Fine. I followed some other examples in the kernel. As long as there
is no text after the 'bool', it doesn't show up as a user configurable
option in the menuconfig. Having some help text even in such cases
seemed helpful to me.

Thanks,
Ashwin.
