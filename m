From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 4/6] clk: qoriq: Add clockgen support for lx2160a
Date: Fri, 5 Oct 2018 09:23:32 +0530
Message-ID: <20181005035332.4ogmxyxiwisok7xs@vireshk-i7>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, mturquette@baylibre.com, will.deacon@arm.com, yamada.masahiro@socionext.com, linux-clk@vger.kernel.org, pankaj.bansal@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, oss@buserror.net, robh+dt@kernel.org, V.Sethi@nxp.com, linux-arm-kernel@lists.infradead.org, Tang Yuantian <andy.tang@nxp.com>, sboyd@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, sudeep.holla@arm.com, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-10-18, 06:33, Vabhav Sharma wrote:
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3d773f6..83921b7 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },
>  	{ .compatible = "fsl,ls2080a-clockgen", },
> +	{ .compatible = "fsl,lx2160a-clockgen", },
>  	{ .compatible = "fsl,p4080-clockgen", },
>  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
>  	{ .compatible = "fsl,qoriq-clockgen-2.0", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
