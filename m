From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 3/8] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Mon, 20 Jul 2015 15:21:43 +0100
Message-ID: <55AD03F7.60108@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55954 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbbGTOVq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 10:21:46 -0400
In-Reply-To: <da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>



On 09/07/15 19:04, Ashwin Chaugule wrote:
> This patch introduces a new Kconfig symbol, ACPI_PROCESSOR_IDLE,
> which is auto selected by architectures which support the ACPI
> based C states for CPU Idle management.
>
> The processor_idle driver in its present form contains declarations
> specific to X86 and IA64. Since there are no reasonable defaults
> for other architectures e.g. ARM64, the driver is selected only by
> the arch/x86/Kconfig.
>
> This helps in decoupling the ACPI processor_driver from the ACPI
> processor_idle driver which is useful for the upcoming alternative
> patchwork for controlling CPU Performance (CPPC) and CPU Idle (LPI).
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>   drivers/acpi/Kconfig     |  6 +++++-
>   drivers/acpi/Makefile    |  3 ++-
>   include/acpi/processor.h | 26 ++++++++++++++++++++++++--
>   3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00748dc..8a60b6e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -177,9 +177,13 @@ config ACPI_CPU_FREQ_PSS
>   	  monitoring. It is required by several flavors of cpufreq
>   	  performance-state drivers.
>
> +config ACPI_PROCESSOR_IDLE
> +	def_bool y
> +	depends on X86 || IA64
> +

In general, you need to split this series so that initially few patches
deal with all the existing Kconfig fix-ups and then introduce
PCC/PSS/CPPC related stuffs. That would help me rebase and test _LPI
support.

Regards,
Sudeep
