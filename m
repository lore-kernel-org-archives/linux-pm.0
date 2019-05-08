From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Date: Wed, 8 May 2019 09:24:02 +0530
Message-ID: <20190508035402.7pbikzpkzxxesmlw@vireshk-i7>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
 <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 07-05-19, 13:52, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> Add a small driver which checks speed grading from nvmem cells before
> registering cpufreq-dt.
> 
> This driver allows unlocking all frequencies for imx8mm and imx8mq and
> could be applied to other chips like imx7d
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  drivers/cpufreq/Kconfig.arm          | 10 +++
>  drivers/cpufreq/Makefile             |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |  3 +
>  drivers/cpufreq/imx-cpufreq-dt.c     | 96 ++++++++++++++++++++++++++++
>  drivers/soc/imx/soc-imx8.c           |  3 +
>  5 files changed, 113 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..78ed9ef49e68 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -90,10 +90,20 @@ config ARM_IMX6Q_CPUFREQ
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
>  
>  	  If in doubt, say N.
>  
> +config ARM_IMX_CPUFREQ_DT
> +	tristate "Freescale i.MX8M cpufreq support"
> +	depends on ARCH_MXC && CPUFREQ_DT
> +	default m if ARCH_MXC && CPUFREQ_DT

As I said in the previous version, the if block above is redundant and
not required.

> +	help
> +	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
> +	  based on cpufreq-dt.
> +
> +	  If in doubt, say N.

-- 
viresh
