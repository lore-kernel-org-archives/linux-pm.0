From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs for
 AXP22X
Date: Thu, 5 Jan 2017 12:12:21 +0800
Message-ID: <CAGb2v65Bwbi8JtOUydMoP4NFcDD_5VXUMzcWCP+S5UyKTA5H1g@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
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
> The AXP22X PMICs have multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
>
> This adds the different ADC data registers to the volatile registers of
> the AXP22X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 619a83e..a33db5e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -100,6 +100,7 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
>  static const struct regmap_range axp22x_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>         regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +       regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),

You added this macro in the next patch. Please move that hunk to this patch.

ChenYu

>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>         regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> --
> 2.9.3
>
