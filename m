From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 4/5] ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
Date: Tue, 04 Apr 2017 11:52:21 +0200
Message-ID: <1491299541.2367.17.camel@pengutronix.de>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <48ebd72d94b5be37318f57e47c8ba5c6ab606470.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <48ebd72d94b5be37318f57e47c8ba5c6ab606470.1490987945.git.leonard.crestez@nxp.com>
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
> Setting the supply is optional but beneficial, it will cause PMIC
> voltages to be dynamically changed with cpu frequency.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 63bf95e..58055ce 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -548,6 +548,18 @@
>  	status = "okay";
>  };
>  
> +&reg_arm {
> +       vin-supply = <&sw1a_reg>;
> +};
> +
> +&reg_pu {
> +       vin-supply = <&sw1c_reg>;
> +};
> +
> +&reg_soc {
> +       vin-supply = <&sw1c_reg>;
> +};
> +
>  &snvs_poweroff {
>  	status = "okay";
>  };
