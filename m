From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: arm_big_little: add SCPI interface driver
Date: Fri, 01 May 2015 14:19:38 +0100
Message-ID: <1430486378.3045.56.camel@linaro.org>
References: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>
	 <1430134846-24320-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430134846-24320-5-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-04-27 at 12:40 +0100, Sudeep Holla wrote:
> On some ARM based systems, a separate Cortex-M based System Control
> Processor(SCP) provides the overall power, clock, reset and system
> control including CPU DVFS. SCPI Message Protocol is used to
> communicate with the SCPI.
> 
> This patch adds a interface driver for adding OPPs and registering
> the arm_big_little cpufreq driver for such systems.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/Kconfig.arm    |   9 ++++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/scpi-cpufreq.c | 103 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/cpufreq/scpi-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4f3dbc8cf729..9e678bf1687c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -24,6 +24,15 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>            This add the CPUfreq driver support for Versatile Express
>  	  big.LITTLE platforms using SPC for power management.
>  
> +config ARM_SCPI_CPUFREQ
> +        tristate "SCPI based CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL

And ARM_BIG_LITTLE_CPUFREQ depends on CONFIG_ARM, so we can't build this
for arm64, which is the only platform (Juno) we have to run these
patches on. Unless you're prepared for a horrid hack...
https://github.com/ARM-software/linux/commit/b9ceaa0cbd7c57d57ee7e69146cc627697570f6e
or a pair of less horrid ones...
http://git.linaro.org/kernel/linux-linaro-tracking.git/commit/4b5dd8ff98613b7e90c8f3214522a00ab6900fe9
http://git.linaro.org/kernel/linux-linaro-tracking.git/commit/8641dbfe253f6a9061742ca11f769fc1d82c2aaa

Any reason why the above two aren't suitable for mainline Linux? The
second was actually committed then reverted because it broke arm64
builds, but the other patch fixes that.

-- 
Tixy
