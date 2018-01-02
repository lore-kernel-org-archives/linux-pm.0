From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
Date: Tue, 2 Jan 2018 13:03:03 -0200
Message-ID: <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dong Aisheng <aisheng.dong@nxp.com>, Ping Bai <ping.bai@nxp.com>, viresh kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, Russell King - ARM Linux <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Anson,

On Tue, Jan 2, 2018 at 3:07 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Add 696MHz operating point according to datasheet
> (Rev. 0, 12/2015).

There is a newer version from 05/2017:
https://www.nxp.com/docs/en/data-sheet/IMX6ULAEC.pdf

>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index e0b4a46..86b3251 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -68,12 +68,14 @@
>                         clock-latency = <61036>; /* two CLK32 periods */
>                         operating-points = <
>                                 /* kHz  uV */
> +                               696000  1275000
>                                 528000  1175000
>                                 396000  1025000
>                                 198000  950000
>                         >;
>                         fsl,soc-operating-points = <
>                                 /* KHz  uV */
> +                               696000  1275000

Why 1.275V?

According to the datasheet, the minimum value for VDD_SOC_CAP is 1.15V
for all frequencies.

Adding 25mV of margin leads to 1.175V.
