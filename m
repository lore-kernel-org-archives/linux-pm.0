From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/5] iio: light: us5182d: Add functions for selectively
 enabling als and proximity
Date: Sun, 29 Nov 2015 16:13:15 +0000
Message-ID: <565B241B.3000100@kernel.org>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
 <1448362792-5181-4-git-send-email-adriana.reus@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448362792-5181-4-git-send-email-adriana.reus@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adriana Reus <adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net, lars@metafoo.de
List-Id: linux-pm@vger.kernel.org

On 24/11/15 10:59, Adriana Reus wrote:
> Keep track of the als and px enabled/disabled status in
> order to enable them selectively.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Couple more nitpicks, but again fixed up during apply.
> ---
>  drivers/iio/light/us5182d.c | 64 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 7993014..3d959f3 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -119,6 +119,9 @@ struct us5182d_data {
>  	u8 opmode;
>  	u8 power_mode;
>  
> +	bool als_enabled;
> +	bool px_enabled;
> +
>  	bool default_continuous;
>  };
>  
> @@ -227,6 +230,48 @@ static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
>  	return 0;
>  }
>  
> +static int us5182d_als_enable(struct us5182d_data *data)
> +{
> +	int ret;
> +	u8 mode;
> +
> +	if (data->power_mode == US5182D_ONESHOT)
> +		return us5182d_set_opmode(data, US5182D_ALS_ONLY);
> +
> +	if (data->als_enabled)
> +		return 0;
> +
> +	mode = data->px_enabled ? US5182D_ALS_PX : US5182D_ALS_ONLY;
> +
> +	ret = us5182d_set_opmode(data, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->als_enabled = true;
Blank line here ideally.
> +	return 0;
> +}
> +
> +static int us5182d_px_enable(struct us5182d_data *data)
> +{
> +	int ret;
> +	u8 mode;
> +
> +	if (data->power_mode == US5182D_ONESHOT)
> +		return us5182d_set_opmode(data, US5182D_PX_ONLY);
> +
> +	if (data->px_enabled)
> +		return 0;
> +
> +	mode = data->als_enabled ? US5182D_ALS_PX : US5182D_PX_ONLY;
> +
> +	ret = us5182d_set_opmode(data, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->px_enabled = true;
And here...
> +	return 0;
> +}
> +
>  static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
>  {
>  	int ret;
> @@ -241,7 +286,16 @@ static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
>  	ret = ret & ~US5182D_CFG0_SHUTDOWN_EN;
>  	ret = ret | state;
>  
> -	return i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
> +	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state & US5182D_CFG0_SHUTDOWN_EN) {
> +		data->als_enabled = false;
> +		data->px_enabled = false;
> +	}
> +
> +	return ret;
>  }
>  
>  static int us5182d_read_raw(struct iio_dev *indio_dev,
> @@ -261,7 +315,7 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  				if (ret < 0)
>  					goto out_err;
>  			}
> -			ret = us5182d_set_opmode(data, US5182D_OPMODE_ALS);
> +			ret = us5182d_als_enable(data);
>  			if (ret < 0)
>  				goto out_err;
>  
> @@ -278,7 +332,7 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  				if (ret < 0)
>  					goto out_err;
>  			}
> -			ret = us5182d_set_opmode(data, US5182D_OPMODE_PX);
> +			ret = us5182d_px_enable(data);
>  			if (ret < 0)
>  				goto out_err;
>  
> @@ -421,6 +475,9 @@ static int us5182d_init(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> +	data->als_enabled = true;
> +	data->px_enabled = true;
> +
>  	if (!data->default_continuous) {
>  		ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
>  		if (ret < 0)
> @@ -428,7 +485,6 @@ static int us5182d_init(struct iio_dev *indio_dev)
>  		data->power_mode = US5182D_ONESHOT;
>  	}
>  
> -
>  	return ret;
>  }
>  
> 
