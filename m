From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Mon, 3 Aug 2015 13:49:46 -0400
Message-ID: <CAJ5Y-eaJBFyyzoByd4EGT3pbMcyJJUvVOigAvK5CEAmBDi+B8w@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>
	<55AD03BE.4070209@arm.com>
	<3246914.4VE12D1ENi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3246914.4VE12D1ENi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 20 July 2015 at 17:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, July 20, 2015 03:20:46 PM Sudeep Holla wrote:
>>
>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>> > The ACPI processor driver is currently tied too closely
>> > to the ACPI P-states (PSS) and other related constructs
>> > for controlling CPU performance.
>> >
>> > The newer ACPI specification (v5.1 onwards) introduces
>> > alternative methods to PSS. These new mechanisms are
>> > described within each ACPI Processor object and so they
>> > need to be scanned whenever a new Processor object is detected.
>> > This patch introduces a new Kconfig symbol to allow for
>> > finer configurability among the two options for controlling
>> > performance states. There is no change in functionality and
>> > the option is auto-selected by the architecture Kconfig files.
>> >
>> > The following patchwork introduces CPPC: A newer method of
>> > controlling CPU performance. The OS is not expected to support
>> > CPPC and PSS at runtime. So the kconfig option lets us make
>> > these two mutually exclusive at compile time.
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > ---
>> >   arch/x86/Kconfig                |  1 +
>> >   drivers/acpi/Kconfig            | 19 ++++++---
>> >   drivers/acpi/Makefile           |  6 +--
>> >   drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++------------
>> >   drivers/cpufreq/Kconfig         |  2 +-
>> >   drivers/cpufreq/Kconfig.x86     |  2 +
>> >   include/acpi/processor.h        | 94 +++++++++++++++++++++++++++--------------
>> >   7 files changed, 142 insertions(+), 68 deletions(-)
>> >
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 226d569..93d150d 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -143,6 +143,7 @@ config X86
>> >          select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>> >          select X86_FEATURE_NAMES if PROC_FS
>> >          select SRCU
>> > +       select ACPI_CPU_FREQ_PSS if ACPI
>> >
>> >   config INSTRUCTION_DECODER
>> >          def_bool y
>> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> > index ab2cbb5..00748dc 100644
>> > --- a/drivers/acpi/Kconfig
>> > +++ b/drivers/acpi/Kconfig
>> > @@ -166,17 +166,26 @@ config ACPI_DOCK
>> >            This driver supports ACPI-controlled docking stations and removable
>> >            drive bays such as the IBM Ultrabay and the Dell Module Bay.
>> >
>> > +config ACPI_CPU_FREQ_PSS
>> > +       bool
>> > +       depends on ACPI_PROCESSOR && CPU_FREQ
>> > +       select THERMAL
>> > +       help
>> > +         This driver implements ACPI methods for controlling CPU performance
>> > +         using PSS methods as described in the ACPI spec. It also enables support
>> > +         for ACPI based performance throttling (TSS) and ACPI based thermal
>> > +         monitoring. It is required by several flavors of cpufreq
>> > +         performance-state drivers.
>> > +
>>
>> Though I agree CPUFreq and the thermal control are related, having _PSS
>> in config name shouldn't match well IMO. You can have more generic name.
>>
>> You are selecting one config while depending on the other, any
>> particular reason ?
>>
>> I don't like adding these, but I leave it to Rafael.
>
> My opinion is analogous. :-)

I dont like bloating Kconfigs either, but its slim pickings in this case.

>
> I *guess* the idea was to avoid selecting ACPI_CPU_FREQ_PSS withouth
> ACPI_PROCESSOR so we don't build unnecessary code.  That's a good point,
> but I would also like to keep they way ACPI_PROCESSOR works on x86 and
> ia64 without adding new user-selectable Kconfig options.
>
> So, what about this:
>
>  config ACPI_PROCESSOR
>         tristate "Processor"
>         select THERMAL
>         select CPU_IDLE
> -       depends on X86 || IA64
> +       select ACPI_CPU_FREQ_PSS if X86 || IA64
>         default y
>         help
>           This driver installs ACPI as the idle handler for Linux and uses
>
> and define ACPI_CPU_FREQ_PSS in analogy with ACPI_CCA_REQUIRED for example?

Seems better. I'll respin this series with the feedback so far.


Thanks,
Ashwin.
