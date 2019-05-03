From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Date: Fri, 3 May 2019 12:20:26 +0530
Message-ID: <20190503065026.qwroewhu5lxckqgl@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1556836868.git.leonard.crestez@nxp.com>
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 02-05-19, 22:44, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> Add a small driver which checks speed grading from nvmem cells before
> registering cpufreq-dt.
> 
> ---
> 
> By default kconfig builds it as a module even though it's very small.
> Couldn't find a way for MODULE_DEVICE_TABLE to match on root node compat
> string and there was no other appropriate node so register the
> imx-cpufreq-dt platfrom device directly from imx8 soc driver instead. I
> checked module is probed by default and rmmod/modprobe again works.

I have suggested something in 1/3 for this.

> It seems that cpufreq-dt insists on adding the opp and regulator itself
> so can't actually call dev_pm_opp_of_add_table and then
> dev_pm_opp_disable

Well we can surely implement it someway if that is what you want, like we can
pass postinit() callback in platform data to cpufreq-dt which can get called
after OPP table is added, etc.

But disabling OPPs after they are added isn't a great way of handling it as
well.

> so implementation was switched to opp-supported-hw.

I will say that this is far better than disabling the OPPs after adding them. So
this is a good way of doing it.

> Maybe I'm confused by API quirks?
> 
> The market segment logic was dropped because I couldn't find any good
> references in datasheets for why lower or intermediary OPPs should be
> disabled on certain market segments. Using opp-supported-hw means that
> adding this in the future would require changing flags inside DT instead
> of code, that seems undesirable for DT compat reasons.
> 
> This could also be extended to mach-imx7d speed grading.
> 
> I never noticed anything wrong with going above the fused speed grading
> however it's technically unsafe so the cpufreq parts should go in before
> DT changes.
> 
> Other changes since v1:
>  * Turn into a proper module
>  * Support imx8mq
> Link to v1 (RFC): https://patchwork.kernel.org/patch/10916769/
> 
> Leonard Crestez (3):
>   cpufreq: Add imx-cpufreq-dt driver
>   arm64: dts: imx8mm: Add cpu speed grading and all OPPs
>   arm64: dts: imx8mq: Add cpu speed grading and all OPPs
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 +++++-
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++-
>  drivers/cpufreq/Kconfig.arm               | 10 +++
>  drivers/cpufreq/Makefile                  |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c      |  3 +
>  drivers/cpufreq/imx-cpufreq-dt.c          | 99 +++++++++++++++++++++++
>  drivers/soc/imx/soc-imx8.c                |  3 +
>  7 files changed, 160 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> -- 
> 2.17.1
> 

-- 
viresh
