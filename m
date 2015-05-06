From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH RFC 2/5] ACPI / processor: always compile perflib if CONFIG_ACPI_PROCESSOR
Date: Wed, 6 May 2015 14:36:38 -0400
Message-ID: <CAJ5Y-eYJ9ydv3Meoco3o9KHhSXSxrRmot1ZW2_ZJosG4h+eprg@mail.gmail.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
	<1430922690-6966-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34531 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbEFSgj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 14:36:39 -0400
Received: by oiko83 with SMTP id o83so14946819oik.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2015 11:36:38 -0700 (PDT)
In-Reply-To: <1430922690-6966-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hello,

On 6 May 2015 at 10:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Similar to the  idle, thermal and throttling libraries, always compile
> the perflib if CONFIG_ACPI_PROCESSOR is enabled. This not only makes
> perflib alligned with other libraries but also helps in some sanity
> testing of these ACPI methods even when a particular feature is not
> enabled in the kernel configuration.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/Makefile    |  2 +-
>  include/acpi/processor.h | 29 -----------------------------
>  include/linux/cpufreq.h  |  4 ++++
>  3 files changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 8a063e276530..33aef9d8b260 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -84,7 +84,7 @@ obj-$(CONFIG_ACPI_BGRT)               += bgrt.o
>  # processor has its own "processor." module_param namespace
>  processor-y                    := processor_driver.o processor_throttling.o
>  processor-y                    += processor_idle.o processor_thermal.o
> -processor-$(CONFIG_CPU_FREQ)   += processor_perflib.o
> +processor-y                    += processor_perflib.o

I'd prefer that we create a separate kconfig option for this. (perhaps
even default it to 'y'). This library is quite specific to a certain
type of CPU performance management methods (includes _PSS and friends)
which are superseded by CPPC. The OS is not expected to support both
at runtime, so by keeping this a config option, we can then disable it
at compile time when CPPC is enabled. We could couple
processor_throttling, thermal and perflib under this config option
(CONFIG_PSS ?) since they're all under the same CPU performance
management umbrella. Thoughts?

Regards,
Ashwin.
