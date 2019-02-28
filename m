From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/7] drivers: firmware: psci: Move psci to separate
 directory
Date: Thu, 28 Feb 2019 15:34:21 +0100
Message-ID: <3e5d2953-3a14-fdea-d02b-6ed7bc4e7882@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228135919.3747-2-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> Some following changes extends the PSCI driver with some additional new
> files.  Let's avoid to continue cluttering the toplevel firmware directory
> and first move the PSCI files into a PSCI sub-directory.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/firmware/Kconfig                   | 15 +--------------
>  drivers/firmware/Makefile                  |  3 +--
>  drivers/firmware/psci/Kconfig              | 13 +++++++++++++
>  drivers/firmware/psci/Makefile             |  4 ++++
>  drivers/firmware/{ => psci}/psci.c         |  0
>  drivers/firmware/{ => psci}/psci_checker.c |  0
>  6 files changed, 19 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/firmware/psci/Kconfig
>  create mode 100644 drivers/firmware/psci/Makefile
>  rename drivers/firmware/{ => psci}/psci.c (100%)
>  rename drivers/firmware/{ => psci}/psci_checker.c (100%)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index f754578414f0..e1385f47d4ac 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -5,20 +5,6 @@
>  
>  menu "Firmware Drivers"
>  
> -config ARM_PSCI_FW
> -	bool
> -
> -config ARM_PSCI_CHECKER
> -	bool "ARM PSCI checker"
> -	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> -	help
> -	  Run the PSCI checker during startup. This checks that hotplug and
> -	  suspend operations work correctly when using PSCI.
> -
> -	  The torture tests may interfere with the PSCI checker by turning CPUs
> -	  on and off through hotplug, so for now torture tests and PSCI checker
> -	  are mutually exclusive.
> -
>  config ARM_SCMI_PROTOCOL
>  	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
>  	depends on ARM || ARM64 || COMPILE_TEST
> @@ -270,6 +256,7 @@ config TI_SCI_PROTOCOL
>  config HAVE_ARM_SMCCC
>  	bool
>  
> +source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 80feb635120f..9a3909a22682 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -2,8 +2,6 @@
>  #
>  # Makefile for the linux kernel.
>  #
> -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> -obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
>  obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
> @@ -25,6 +23,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
> +obj-y				+= psci/
>  obj-y				+= broadcom/
>  obj-y				+= meson/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> new file mode 100644
> index 000000000000..26a3b32bf7ab
> --- /dev/null
> +++ b/drivers/firmware/psci/Kconfig
> @@ -0,0 +1,13 @@
> +config ARM_PSCI_FW
> +	bool
> +
> +config ARM_PSCI_CHECKER
> +	bool "ARM PSCI checker"
> +	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> +	help
> +	  Run the PSCI checker during startup. This checks that hotplug and
> +	  suspend operations work correctly when using PSCI.
> +
> +	  The torture tests may interfere with the PSCI checker by turning CPUs
> +	  on and off through hotplug, so for now torture tests and PSCI checker
> +	  are mutually exclusive.
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> new file mode 100644
> index 000000000000..1956b882470f
> --- /dev/null
> +++ b/drivers/firmware/psci/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
> similarity index 100%
> rename from drivers/firmware/psci.c
> rename to drivers/firmware/psci/psci.c
> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> similarity index 100%
> rename from drivers/firmware/psci_checker.c
> rename to drivers/firmware/psci/psci_checker.c
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
