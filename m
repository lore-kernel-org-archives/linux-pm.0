From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 06/22] ARM: dtsi: axp22x: add AXP22X ADC subnode
Date: Thu, 5 Jan 2017 13:52:32 +0800
Message-ID: <CAGb2v64UsEie__ZosMh=qJu_BFiHidRQDO=rsKJfHTm0FioArQ@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-7-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-7-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> X-Powers AXP22X PMIC has multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
>
> This adds the ADC subnode for AXP22X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp22x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
> index 458b668..a2c4401 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -52,6 +52,11 @@
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
> +       axp221_adc: axp221_adc {

Same as the last patch. Please change to "adc".

ChenYu

> +               compatible = "x-powers,axp221-adc";
> +               #io-channel-cells = <1>;
> +       };
> +
>         regulators {
>                 /* Default work frequency for buck regulators */
>                 x-powers,dcdc-freq = <3000>;
> --
> 2.9.3
>
