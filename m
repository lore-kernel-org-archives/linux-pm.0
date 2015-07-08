From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 8 Jul 2015 16:28:32 -0400
Message-ID: <CAJ5Y-eaGmF6pRKuapzQo8ruMt0FX4kVrdyu-os6maVaS7WO-Pw@mail.gmail.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>
	<2138469.Io9yItSdst@vostro.rjw.lan>
	<CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>
	<CAJZ5v0gKW7bR66trxvuhd_Gb=ZMBbec++u+V+T4mroCZMtO+vg@mail.gmail.com>
	<CAJ5Y-ebW3aCSSs4UQFLpLFSfo7d9zPVfigoROjN80uXzG1sZLw@mail.gmail.com>
	<CAJZ5v0h24-YAeqW79Se8kRr+_+RknwNfLwS_74-sN+W0_wBaZg@mail.gmail.com>
	<CAJ5Y-eYwnaDzyL78CyJDmo35CFTNoQrYfEcO3VYnpaZkSVPdcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eYwnaDzyL78CyJDmo35CFTNoQrYfEcO3VYnpaZkSVPdcw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 8 July 2015 at 16:05, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 8 July 2015 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi Ashwin,
>>
>> On Wed, Jul 8, 2015 at 9:16 PM, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>>> Hi Rafael,
>>>
>>> On 8 July 2015 at 09:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> Hi Ashwin,
>>>>
>>>> On Wed, Jul 8, 2015 at 3:27 AM, Ashwin Chaugule
>>>> <ashwin.chaugule@linaro.org> wrote:
>>>>> On 7 July 2015 at 21:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>> On Monday, June 15, 2015 04:09:06 PM Ashwin Chaugule wrote:
>>>>>>> The ACPI processor driver is currently tied too closely
>>>>>>> to the ACPI C-states (CST), P-states (PSS) and other related
>>>>>>> constructs for controlling CPU idle and CPU performance.
>>>>>>>
>>>>>>> The newer ACPI specification (v5.1 onwards) introduces
>>>>>>> alternative methods to CST and PSS. These new mechanisms
>>>>>>> are described within each ACPI Processor object and so they
>>>>>>> need to be scanned whenever a new Processor object is detected.
>>>>>>> This patch introduces two new Kconfig symbols to allow for
>>>>>>> finer configurability among the various options for controlling
>>>>>>> CPU idle and performance states. There is no change in functionality
>>>>>>> and these options are defaulted to enabled to maintain previous
>>>>>>> behaviour.
>>>>>>>
>>>>>>> The following patchwork introduces CPPC: A newer method of
>>>>>>> controlling CPU performance. The OS is not expected to support CPPC
>>>>>>> and PSS at runtime. So the kconfig option lets us make these two
>>>>>>> mutually exclusive at compile time.
>>>>>>>
>>>>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>>>> Reviewed-by: Al Stone <al.stone@linaro.org>
>>>>>>> ---
>>>>>>>  drivers/acpi/Kconfig            |  31 +++++++++--
>>>>>>>  drivers/acpi/Makefile           |   7 ++-
>>>>>>>  drivers/acpi/processor_driver.c |  86 ++++++++++++++++++----------
>>>>>>>  drivers/cpufreq/Kconfig         |   2 +-
>>>>>>>  drivers/cpufreq/Kconfig.x86     |   2 +
>>>>>>>  include/acpi/processor.h        | 120 ++++++++++++++++++++++++++++------------
>>>>>>>  6 files changed, 176 insertions(+), 72 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>>>>> index ab2cbb5..5942754 100644
>>>>>>> --- a/drivers/acpi/Kconfig
>>>>>>> +++ b/drivers/acpi/Kconfig
>>>>>>> @@ -166,18 +166,39 @@ config ACPI_DOCK
>>>>>>>         This driver supports ACPI-controlled docking stations and removable
>>>>>>>         drive bays such as the IBM Ultrabay and the Dell Module Bay.
>>>>>>>
>>>>>>> -config ACPI_PROCESSOR
>>>>>>> -     tristate "Processor"
>>>>>>> -     select THERMAL
>>>>>>> -     select CPU_IDLE
>>>>>>> +config ACPI_CST
>>>>>>> +     bool "ACPI C states (CST) driver"
>>>>>>> +     depends on ACPI_PROCESSOR
>>>>>>>       depends on X86 || IA64
>>>>>>> +     select CPU_IDLE
>>>>>>>       default y
>>>>>>>       help
>>>>>>>         This driver installs ACPI as the idle handler for Linux and uses
>>>>>>>         ACPI C2 and C3 processor states to save power on systems that
>>>>>>> -       support it.  It is required by several flavors of cpufreq
>>>>>>> +       support it.
>>>>>>> +
>>>>>>> +config ACPI_PSS
>>>>>>> +     bool "ACPI P States (PSS) driver"
>>>>>>> +     depends on ACPI_PROCESSOR
>>>>>>> +     depends on X86 || IA64
>>>>>>> +     select THERMAL
>>>>>>> +     default y
>>>>>>> +     help
>>>>>>> +       This driver implements ACPI methods for controlling CPU performance
>>>>>>> +       using PSS methods as described in the ACPI spec. It also enables support
>>>>>>> +       for ACPI based performance throttling (TSS) and ACPI based thermal
>>>>>>> +       monitoring. It is required by several flavors of cpufreq
>>>>>>>         performance-state drivers.
>>>>>>
>>>>>> For starters, I don't like these new Kconfig options.
>>>>>>
>>>>>> Isn't there a way to implement what you need without adding them?
>>>>>
>>>>> We need to use the ACPI Processor driver for CPPC without including
>>>>> all its current dependencies. (i.e. PSS, TSS, CSS etc.). The upcoming
>>>>> LPI work from Sudeep will also face the same issue. I considered the
>>>>> alternative of adding a probe routine which matches
>>>>> ACPI_PROCESSOR_OBJECT/DEVICE_HID to each driver, but this seemed like
>>>>> a better option. Do you have any other ideas?
>>>>
>>>> First of all, I don't see what _CST has to do with CPPC.
>>>>
>>>> Second, it looks like the problem is that x86 probably won't use CPPC,
>>>> while arm64 probably won't use _PSS.
>>>>
>>>> That can be addressed by adding Kconfig options, but those options
>>>> should not be user-selectable (because quite honestly users don't have
>>>> to know what those things are and they don't care *and* things break
>>>> if they make a wrong choice).  Instead, I'd make architecture Kconfigs
>>>> select those options automatically.
>>>>
>>>
>>> I've made changes locally. Basically s/ACPI_PSS/HAVE_ACPI_PSS/ and in
>>> arch/x86/Kconfig; select HAVE_ACPI_PSS if ACPI. Similarly for CST.
>>> Just wanted to check if there were any other comments before sending
>>> out v7.
>>
>> Can you please just send the new version of the $subject patch alone for now?
>
> Attached below. (hope that worked.)
>
>>
>> Also I'm still unsure what the connection between _CST and CPPC is.
>>
>
> There isnt. But I'm missing where I've implied the dependency?

Perhaps the confusion is coming from the introduction of ACPI_CST in
this file. I could leave it as it is and just separate out the
ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
since we know the LPI stuff is coming up soon as a CST alternative
anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
address that as part of his LPI patchset?

Thanks,
Ashwin.
