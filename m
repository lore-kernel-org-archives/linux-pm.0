From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: inkern: API for reading available iio
 channel attribute values
Date: Sun, 24 Mar 2019 15:27:25 +0000
Message-ID: <20190324152725.35fed317@archlinux>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323172809.14407-1-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Mar 2019 18:28:06 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Extend the inkern API with a function for reading available
> attribute values of iio channels.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
If this goes through a route other than IIO (otherwise
I'll just add a signed-off-by...)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Changes:
> 
> v2: no change
> 
>  drivers/iio/inkern.c         | 20 ++++++++++++++++++++
>  include/linux/iio/consumer.h | 14 ++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 06ca3f7fcc44..f19dbde3c945 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -733,6 +733,26 @@ static int iio_channel_read_avail(struct iio_channel *chan,
>  						 vals, type, length, info);
>  }
>  
> +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> +				     const int **vals, int *type, int *length,
> +				     enum iio_chan_info_enum attribute)
> +{
> +	int ret;
> +
> +	mutex_lock(&chan->indio_dev->info_exist_lock);
> +	if (!chan->indio_dev->info) {
> +		ret = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	ret = iio_channel_read_avail(chan, vals, type, length, attribute);
> +err_unlock:
> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
> +
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>  			       const int **vals, int *length)
>  {
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 9887f4f8e2a8..b2d34831ed7c 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -290,6 +290,20 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>  			       const int **vals, int *length);
>  
> +/**
> + * iio_read_avail_channel_attribute() - read available channel attribute values
> + * @chan:		The channel being queried.
> + * @vals:		Available values read back.
> + * @type:		Type of values read back.
> + * @length:		Number of entries in vals.
> + * @attribute:		info attribute to be read back.
> + *
> + * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
> + */
> +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> +				     const int **vals, int *type, int *length,
> +				     enum iio_chan_info_enum attribute);
> +
>  /**
>   * iio_get_channel_type() - get the type of a channel
>   * @channel:		The channel being queried.
