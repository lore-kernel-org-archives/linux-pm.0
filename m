From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v2 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Tue, 04 Jul 2017 09:51:38 +0900
Message-ID: <20170704095138.62E8.4A936039@socionext.com>
References: <1498644719-25611-3-git-send-email-hayashi.kunihiko@socionext.com> <20170701031630.GA11743@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:40263 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdGDAvl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jul 2017 20:51:41 -0400
In-Reply-To: <20170701031630.GA11743@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org

Hi Eduardo,
Thank you for your comment.

On Fri, 30 Jun 2017 20:16:33 -0700 <edubezval@gmail.com> wrote:

> Hey,
> 
> On Wed, Jun 28, 2017 at 07:11:59PM +0900, Kunihiko Hayashi wrote:
> > Add a thermal driver for on-chip PVT (Process, Voltage and Temperature)
> > monitoring unit implemented on UniPhier SoCs. This driver supports
> > temperature monitoring and alert function.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/thermal/Kconfig            |   8 +
> >  drivers/thermal/Makefile           |   1 +
> >  drivers/thermal/uniphier_thermal.c | 391 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 400 insertions(+)
> >  create mode 100644 drivers/thermal/uniphier_thermal.c

(snip)

> > +static void uniphier_tm_enable_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +	struct regmap *map = tdev->regmap;
> > +	int i;
> > +	u32 bits = 0;
> > +
> > +	for (i = 0; i < ALERT_CH_NUM; i++)
> > +		if (tdev->alert_en[i])
> > +			bits |= PMALERTINTCTL_EN(i);
> > +
> > +	/* enable alert interrupt */
> > +	regmap_write_bits(map, tdev->data->map_base + PMALERTINTCTL,
> > +			  PMALERTINTCTL_MASK, bits);
> > +
> > +	/* start PVT */
> > +	regmap_write_bits(map, tdev->data->block_base + PVTCTLEN,
> > +			  PVTCTLEN_EN, PVTCTLEN_EN);
> 
> Do we need to wait some time after starting PVT and before reading the
> first temperature?

Thanks for your pointing out.

According to the spec sheet, we can read first temperature
with waiting 700us after starting PVT. And after disabling PVT,
we must wait 1ms until next access.

I'll add "nsleep" after accessing PVTCTLEN in
uniphier_tm_{enable,disable}_sensor().

> > +}
> > +
> > +static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +	struct regmap *map = tdev->regmap;
> > +
> > +	/* disable alert interrupt */
> > +	regmap_write_bits(map, tdev->data->map_base + PMALERTINTCTL,
> > +			  PMALERTINTCTL_MASK, 0);
> > +
> > +	/* stop PVT */
> > +	regmap_write_bits(map, tdev->data->block_base + PVTCTLEN,
> > +			  PVTCTLEN_EN, 0);
> > +}
> > +
> > +static int uniphier_tm_get_temp(void *data, int *out_temp)
> > +{
> > +	struct uniphier_tm_dev *tdev = data;
> > +	struct regmap *map = tdev->regmap;
> > +	int ret;
> > +	u32 temp;
> > +
> > +	ret = regmap_read(map, tdev->data->map_base + TMOD, &temp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Since MSB of TMOD_MASK in TMOD represents signed bit,
> > +	 * if the register value is bigger than or equal to
> > +	 * ((TMOD_MASK + 1) / 2), it represents a negative value
> > +	 * of temperature.
> > +	 */
> > +	temp &= TMOD_MASK;
> > +	if (temp >= ((TMOD_MASK + 1) / 2))
> > +		*out_temp = (temp - (TMOD_MASK + 1)) * 1000;
> 
> But, why do you mask negative values? Are you considering them invalid?
> should this be reported? Why simply silently transforming into positive?

My explanation comment is insufficient.
The whole TMOD register doesn't represent temperature value.

TMOD[31:9] has always 0 as reserved bits.
TMOD[8:0] has 2's complement value of temperature (Celsius)
represented by 9bits.
For example, when we read 0x1ff from the TMOD, it means -1.

Then according to linux/bitops.h,
it can be replaced with "*out_temp = sign_extend32(temp, 9)" simply.

Best Regards,
Kunihiko Hayashi
