From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/5] iio: light: us5182d: Add property for choosing
 default power mode
Date: Sun, 29 Nov 2015 14:35:09 +0000
Message-ID: <565B0D1D.1070006@kernel.org>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
 <1448362792-5181-2-git-send-email-adriana.reus@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448362792-5181-2-git-send-email-adriana.reus@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adriana Reus <adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net, lars@metafoo.de
List-Id: linux-pm@vger.kernel.org

On 24/11/15 10:59, Adriana Reus wrote:
> This chip supports two power modes.
> 1. "one-shot" mode - the chip activates and executes one complete
> conversion loop and then shuts itself down. This is the default mode
> chosen for raw reads.
> 2. "continuous" mode - the chip takes continuous measurements.
> 
> Continuous mode is more expensive power-wise but may be more reliable.
> Add a property so that if preferred, the default power mode for raw
> reads can be set to continuous.
> Separate one-shot enabling in a separate function that will be used
> depending on the chosen power mode. Also create a function for
> powering the chip on and off.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
A couple of nitpicks inline...  I've fixed them up when applying to the
togreg branch of iio.git - initially pushed out as testing for the autobuilders
to play with them.

Thanks,

Jonathan
> ---
>  drivers/iio/light/us5182d.c | 90 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 49dab3c..7993014 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -99,6 +99,11 @@ enum mode {
>  	US5182D_PX_ONLY
>  };
>  
> +enum pmode {
> +	US5182D_CONTINUOUS,
> +	US5182D_ONESHOT
> +};
> +
>  struct us5182d_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> @@ -112,6 +117,9 @@ struct us5182d_data {
>  	u16 *us5182d_dark_ths;
>  
>  	u8 opmode;
> +	u8 power_mode;
> +
> +	bool default_continuous;
>  };
>  
>  static IIO_CONST_ATTR(in_illuminance_scale_available,
> @@ -130,13 +138,11 @@ static const struct {
>  	u8 reg;
>  	u8 val;
>  } us5182d_regvals[] = {
> -	{US5182D_REG_CFG0, (US5182D_CFG0_SHUTDOWN_EN |
> -			    US5182D_CFG0_WORD_ENABLE)},
> +	{US5182D_REG_CFG0, US5182D_CFG0_WORD_ENABLE},
>  	{US5182D_REG_CFG1, US5182D_CFG1_ALS_RES16},
>  	{US5182D_REG_CFG2, (US5182D_CFG2_PX_RES16 |
>  			    US5182D_CFG2_PXGAIN_DEFAULT)},
>  	{US5182D_REG_CFG3, US5182D_CFG3_LED_CURRENT100},
> -	{US5182D_REG_MODE_STORE, US5182D_STORE_MODE},
>  	{US5182D_REG_CFG4, 0x00},
>  };
>  
> @@ -169,7 +175,7 @@ static int us5182d_get_als(struct us5182d_data *data)
>  	return result;
>  }
>  
> -static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
> +static int us5182d_oneshot_en(struct us5182d_data *data)
>  {
>  	int ret;
>  
> @@ -182,6 +188,20 @@ static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
>  	 * required measurement.
>  	 */
>  	ret = ret | US5182D_CFG0_ONESHOT_EN;
> +	return i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
Unwanted extra blank line here...
> +
> +}
> +
> +static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
> +{
> +	int ret;
> +
> +	if (mode == data->opmode)
> +		return 0;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CFG0);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* update mode */
>  	ret = ret & ~US5182D_OPMODE_MASK;
> @@ -196,9 +216,6 @@ static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (mode == data->opmode)
> -		return 0;
> -
>  	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_MODE_STORE,
>  					US5182D_STORE_MODE);
>  	if (ret < 0)
> @@ -210,6 +227,23 @@ static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
>  	return 0;
>  }
>  
> +static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
Stray space above.. Checkpatch would have highlighted this for you, please
do run it as a sanity check before you send a series out.

> +{
> +	int ret;
> +
> +	if (data->power_mode == US5182D_ONESHOT)
> +		return 0;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CFG0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ret & ~US5182D_CFG0_SHUTDOWN_EN;
> +	ret = ret | state;
> +
> +	return i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
> +}
> +
>  static int us5182d_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
> @@ -222,6 +256,11 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			mutex_lock(&data->lock);
> +			if (data->power_mode == US5182D_ONESHOT) {
> +				ret = us5182d_oneshot_en(data);
> +				if (ret < 0)
> +					goto out_err;
> +			}
>  			ret = us5182d_set_opmode(data, US5182D_OPMODE_ALS);
>  			if (ret < 0)
>  				goto out_err;
> @@ -234,6 +273,11 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT;
>  		case IIO_PROXIMITY:
>  			mutex_lock(&data->lock);
> +			if (data->power_mode == US5182D_ONESHOT) {
> +				ret = us5182d_oneshot_en(data);
> +				if (ret < 0)
> +					goto out_err;
> +			}
>  			ret = us5182d_set_opmode(data, US5182D_OPMODE_PX);
>  			if (ret < 0)
>  				goto out_err;
> @@ -368,6 +412,7 @@ static int us5182d_init(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	data->opmode = 0;
> +	data->power_mode = US5182D_CONTINUOUS;
>  	for (i = 0; i < ARRAY_SIZE(us5182d_regvals); i++) {
>  		ret = i2c_smbus_write_byte_data(data->client,
>  						us5182d_regvals[i].reg,
> @@ -376,7 +421,15 @@ static int us5182d_init(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> -	return 0;
> +	if (!data->default_continuous) {
> +		ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
> +		if (ret < 0)
> +			return ret;
> +		data->power_mode = US5182D_ONESHOT;
> +	}
> +
> +
> +	return ret;
>  }
>  
>  static void us5182d_get_platform_data(struct iio_dev *indio_dev)
> @@ -399,6 +452,8 @@ static void us5182d_get_platform_data(struct iio_dev *indio_dev)
>  				    "upisemi,lower-dark-gain",
>  				    &data->lower_dark_gain))
>  		data->lower_dark_gain = US5182D_REG_AUTO_LDARK_GAIN_DEFAULT;
> +	data->default_continuous = device_property_read_bool(&data->client->dev,
> +							     "upisemi,continuous");
>  }
>  
>  static int  us5182d_dark_gain_config(struct iio_dev *indio_dev)
> @@ -464,16 +519,27 @@ static int us5182d_probe(struct i2c_client *client,
>  
>  	ret = us5182d_dark_gain_config(indio_dev);
>  	if (ret < 0)
> -		return ret;
> +		goto out_err;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	return 0;
> +
> +out_err:
> +	us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
> +	return ret;
>  
> -	return iio_device_register(indio_dev);
>  }
>  
>  static int us5182d_remove(struct i2c_client *client)
>  {
> +	struct us5182d_data *data = iio_priv(i2c_get_clientdata(client));
> +
>  	iio_device_unregister(i2c_get_clientdata(client));
> -	return i2c_smbus_write_byte_data(client, US5182D_REG_CFG0,
> -					 US5182D_CFG0_SHUTDOWN_EN);
> +
> +	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
>  }
>  
>  static const struct acpi_device_id us5182d_acpi_match[] = {
> 
