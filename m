From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] cpufreq: ARM: sort the Kconfig menu
Date: Tue, 12 Dec 2017 09:45:54 -0800
Message-ID: <97091943-dcb8-47ab-0e55-831d35b1f73e@infradead.org>
References: <20171212165419.752-1-gregory.clement@free-electrons.com>
 <20171212165419.752-2-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171212165419.752-2-gregory.clement@free-electrons.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Andre Heider <a.heider@gmail.com>, Evan Wang <xswang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>, Neta Zur Hershkovits <neta@marvell.com>, =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>, Hua Jing <jinghua@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12/12/2017 08:54 AM, Gregory CLEMENT wrote:
> Group all the related big LITTLE configuration together and sort the
> other entries in alphabetic order.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 82 ++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index bdce4488ded1..0baf43837b51 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -2,6 +2,23 @@
>  # ARM CPU Frequency scaling drivers
>  #
>  
> +config ACPI_CPPC_CPUFREQ
> +	tristate "CPUFreq driver based on the ACPI CPPC spec"
> +	depends on ACPI_PROCESSOR
> +	select ACPI_CPPC_LIB
> +	default n

Drop "default n" since that is the default default.

> +	help
> +	  This adds a CPUFreq driver which uses CPPC methods
> +	  as described in the ACPIv5.1 spec. CPPC stands for
> +	  Collaborative Processor Performance Controls. It
> +	  is based on an abstract continuous scale of CPU
> +	  performance values which allows the remote power
> +	  processor to flexibly optimize for power and
> +	  performance. CPPC relies on power management firmware
> +	  support for its operation.
> +
> +	  If in doubt, say N.
> +
>  # big LITTLE core layer and glue drivers
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
> @@ -12,6 +29,30 @@ config ARM_BIG_LITTLE_CPUFREQ
>  	help
>  	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>  
> +config ARM_DT_BL_CPUFREQ
> +	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && OF
> +	help
> +	  This enables probing via DT for Generic CPUfreq driver for ARM
> +	  big.LITTLE platform. This gets frequency tables from DT.
> +
> +config ARM_SCPI_CPUFREQ
> +        tristate "SCPI based CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> +        help

Fix the help and tristate lines -- use tab instead of spaces.

> +	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
> +	  using SCPI protocol for CPU power management.
> +
> +	  This driver uses SCPI Message Protocol driver to interact with the
> +	  firmware providing the CPU DVFS functionality.
> +
> +config ARM_VEXPRESS_SPC_CPUFREQ
> +        tristate "Versatile Express SPC based CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
> +        help

Use tab instead of spaces above. Oh, and one line below.

> +          This add the CPUfreq driver support for Versatile Express
> +	  big.LITTLE platforms using SPC for power management.
> +
>  config ARM_BRCMSTB_AVS_CPUFREQ
>  	tristate "Broadcom STB AVS CPUfreq driver"
>  	depends on ARCH_BRCMSTB || COMPILE_TEST


-- 
~Randy
