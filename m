From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 5/5] ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply
Date: Tue, 04 Apr 2017 11:53:08 +0200
Message-ID: <1491299588.2367.18.camel@pengutronix.de>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <6711393cb78e8f975014e26e4008481828459463.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6711393cb78e8f975014e26e4008481828459463.1490987945.git.leonard.crestez@nxp.com>
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
Cc: Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
> the other imx6qdl-sabresd boards.
> 
> Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
> slipped out of the vendor tree where this is are used for LDO bypass.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qp-sabresd.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
> index b234580..a8a5004 100644
> --- a/arch/arm/boot/dts/imx6qp-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> @@ -50,8 +50,8 @@
>  	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
>  };
>  
> -&cpu0 {
> -	arm-supply = <&sw2_reg>;
> +&reg_arm {
> +	vin-supply = <&sw2_reg>;
>  };
>  
>  &iomuxc {
