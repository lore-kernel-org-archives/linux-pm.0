From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Sat, 18 Jul 2015 02:03:47 +0200
Message-ID: <2977324.30XrlQvi3H@vostro.rjw.lan>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org> <3655608.oFpclyKJ6p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3655608.oFpclyKJ6p@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

On Saturday, July 18, 2015 02:01:40 AM Rafael J. Wysocki wrote:
> On Thursday, July 09, 2015 02:04:18 PM Ashwin Chaugule wrote:
> > The ACPI processor driver is currently tied too closely
> > to the ACPI P-states (PSS) and other related constructs
> > for controlling CPU performance.
> > 
> > The newer ACPI specification (v5.1 onwards) introduces
> > alternative methods to PSS. These new mechanisms are
> > described within each ACPI Processor object and so they
> > need to be scanned whenever a new Processor object is detected.
> > This patch introduces a new Kconfig symbol to allow for
> > finer configurability among the two options for controlling
> > performance states. There is no change in functionality and
> > the option is auto-selected by the architecture Kconfig files.
> > 
> > The following patchwork introduces CPPC: A newer method of
> > controlling CPU performance. The OS is not expected to support
> > CPPC and PSS at runtime. So the kconfig option lets us make
> > these two mutually exclusive at compile time.
> > 
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > ---
> >  arch/x86/Kconfig                |  1 +
> >  drivers/acpi/Kconfig            | 19 ++++++---
> >  drivers/acpi/Makefile           |  6 +--
> >  drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++------------
> >  drivers/cpufreq/Kconfig         |  2 +-
> >  drivers/cpufreq/Kconfig.x86     |  2 +
> >  include/acpi/processor.h        | 94 +++++++++++++++++++++++++++--------------
> >  7 files changed, 142 insertions(+), 68 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 226d569..93d150d 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -143,6 +143,7 @@ config X86
> >  	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
> >  	select X86_FEATURE_NAMES if PROC_FS
> >  	select SRCU
> > +	select ACPI_CPU_FREQ_PSS if ACPI

Also, does ia64 not use _PSS-based cpufreq?

Thanks,
Rafael

