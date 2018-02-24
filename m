From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 13/13] iio: adc: axp20x_adc: remove !! in favor of
 ternary condition
Date: Sat, 24 Feb 2018 12:20:29 +0000
Message-ID: <20180224122029.1520fe89@archlinux>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
 <9ec180ff4358ac6e163115aa7832a0674b6a640e.1519044068.git-series.quentin.schulz@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9ec180ff4358ac6e163115aa7832a0674b6a640e.1519044068.git-series.quentin.schulz@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, thomas.petazzoni@bootlin.com, linux-pm@vger.kernel.org, maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, sre@kernel.org, linux@armlinux.org.uk, linux-iio@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 19 Feb 2018 13:47:36 +0100
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> !!'s behaviour isn't that obvious and sparse complained about it, so
> let's replace it with a ternary condition.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index a30a972..7a745cf 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -365,7 +365,7 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>  		return -EINVAL;
>  	}
>  
> -	*val = !!(*val) * 700000;
> +	*val = *val ? 700000 : 0;
>  
>  	return IIO_VAL_INT;
>  }
> @@ -442,15 +442,17 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>  	if (val != 0 && val != 700000)
>  		return -EINVAL;
>  
> +	val = val ? 1 : 0;
> +
>  	switch (chan->channel) {
>  	case AXP20X_GPIO0_V:
>  		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(!!val);
> +		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
>  		break;
>  
>  	case AXP20X_GPIO1_V:
>  		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(!!val);
> +		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
>  		break;
>  
>  	default:
