From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date: Tue, 28 Aug 2018 19:18:50 -0500
Message-ID: <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>, linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-08-20 at 12:17 +0530, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3a1812f..fc6e308 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -60,7 +60,7 @@ struct clockgen_muxinfo {
>  };
>  
>  #define NUM_HWACCEL	5
> -#define NUM_CMUX	8
> +#define NUM_CMUX	16
>  
>  struct clockgen;
>  
> @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
>  		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
>  	},
>  	{
> +		.compat = "fsl,lx2160a-clockgen",
> +		.cmux_groups = {
> +			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> +		},
> +		.cmux_to_group = {
> +			0, 0, 0, 0, 1, 1, 1, 1, -1
> +		},
> +		.pll_mask = 0x37,
> +		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> +	},

Why are you increasing NUM_CMUX beyond 8 for a chip that only has 8 entries in
cmux_to_group?

-Scott
