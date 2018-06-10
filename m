From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio:dac:ad5686: Add AD5311R support
Date: Sun, 10 Jun 2018 14:30:34 +0100
Message-ID: <20180610143034.37279fe0@archlinux>
References: <1528122127-1911-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528122127-1911-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Popa <stefan.popa@analog.com>
Cc: Michael.Hennerich@analog.com, lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 4 Jun 2018 17:22:07 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> AD5311R is a single channel DAC with 10-bit precision and i2c interface.
> The device includes a 2.5V internal reference which is enabled by default.
> 
> This device is similar to AD5691R/AD5692R/AD5693/AD5693R, the only
> difference is that it has 10-bit precision.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310R_5311R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c     | 7 +++++++
>  drivers/iio/dac/ad5686.h     | 1 +
>  drivers/iio/dac/ad5696-i2c.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e136f0f..2ddbfc3 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -221,6 +221,7 @@ static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(7, 7, bits, _shift),		\
>  }
>  
> +DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
>  DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
>  DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
>  DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
> @@ -231,6 +232,12 @@ DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
>  DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
> +	[ID_AD5311R] = {
> +		.channels = ad5311r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
> +	},
>  	[ID_AD5671R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index d05cda9..57b3c61 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -45,6 +45,7 @@
>   * ad5686_supported_device_ids:
>   */
>  enum ad5686_supported_device_ids {
> +	ID_AD5311R,
>  	ID_AD5671R,
>  	ID_AD5672R,
>  	ID_AD5675R,
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d18735d..7350d98 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -71,6 +71,7 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct i2c_device_id ad5686_i2c_id[] = {
> +	{"ad5311r", ID_AD5311R},
>  	{"ad5671r", ID_AD5671R},
>  	{"ad5675r", ID_AD5675R},
>  	{"ad5691r", ID_AD5691R},
