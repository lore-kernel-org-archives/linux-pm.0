From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v10 05/10] i2c: mux: pca954x: Call request irq after
 adding mux segments
Date: Mon, 31 Jul 2017 10:09:49 +0200
Message-ID: <612a8d32-77e8-a1d3-94e8-700a9e6a2184@axentia.se>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
 <1500954024-6860-6-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr40114.outbound.protection.outlook.com ([40.107.4.114]:22688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbdGaIKC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Jul 2017 04:10:02 -0400
In-Reply-To: <1500954024-6860-6-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Hi Phil,

Nice to get rid of the mask/unmask! One small nit though, the
'fail_del_adapters' label no longer describes what's going on.
Please change it to 'fail_cleanup' or something like that.

With that,
Acked-by: Peter Rosin <peda@axentia.se>

And also, for the future, please use subjects according to
submitting-patches, i.e., in this case

i2c: mux: pca954x: call request irq after adding mux segments

(lower-case 'c' in call)

Cheers,
Peter

On 2017-07-25 05:40, Phil Reid wrote:
> The pca954x device do not have the ability to mask interrupts. For
> i2c slave devices that also don't have masking ability (eg ltc1760
> smbalert output) delay registering the irq until after the mux
> segments have been configured. During the mux add_adaptor call the
> core i2c system can register an smbalert handler which would then
> be called immediately when the irq is registered. This smbalert
> handler will then clear the pending irq.
> 
> This removes the need for the irq_mask / irq_unmask calls that were
> original used to do this.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 85 +++++++++++--------------------------
>  1 file changed, 25 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index f1751c2..ac0f083 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -246,36 +246,6 @@ static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> -static void pca954x_irq_mask(struct irq_data *idata)
> -{
> -	struct pca954x *data = irq_data_get_irq_chip_data(idata);
> -	unsigned int pos = idata->hwirq;
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&data->lock, flags);
> -
> -	data->irq_mask &= ~BIT(pos);
> -	if (!data->irq_mask)
> -		disable_irq(data->client->irq);
> -
> -	raw_spin_unlock_irqrestore(&data->lock, flags);
> -}
> -
> -static void pca954x_irq_unmask(struct irq_data *idata)
> -{
> -	struct pca954x *data = irq_data_get_irq_chip_data(idata);
> -	unsigned int pos = idata->hwirq;
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&data->lock, flags);
> -
> -	if (!data->irq_mask)
> -		enable_irq(data->client->irq);
> -	data->irq_mask |= BIT(pos);
> -
> -	raw_spin_unlock_irqrestore(&data->lock, flags);
> -}
> -
>  static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
>  {
>  	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_LOW)
> @@ -285,8 +255,6 @@ static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
>  
>  static struct irq_chip pca954x_irq_chip = {
>  	.name = "i2c-mux-pca954x",
> -	.irq_mask = pca954x_irq_mask,
> -	.irq_unmask = pca954x_irq_unmask,
>  	.irq_set_type = pca954x_irq_set_type,
>  };
>  
> @@ -294,7 +262,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  {
>  	struct pca954x *data = i2c_mux_priv(muxc);
>  	struct i2c_client *client = data->client;
> -	int c, err, irq;
> +	int c, irq;
>  
>  	if (!data->chip->has_irq || client->irq <= 0)
>  		return 0;
> @@ -314,24 +282,22 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  			handle_simple_irq);
>  	}
>  
> -	err = devm_request_threaded_irq(&client->dev, data->client->irq, NULL,
> -					pca954x_irq_handler,
> -					IRQF_ONESHOT | IRQF_SHARED,
> -					"pca954x", data);
> -	if (err)
> -		goto err_req_irq;
> +	return 0;
> +}
>  
> -	disable_irq(data->client->irq);
> +static void pca954x_cleanup(struct i2c_mux_core *muxc)
> +{
> +	struct pca954x *data = i2c_mux_priv(muxc);
> +	int c, irq;
>  
> -	return 0;
> -err_req_irq:
> -	for (c = 0; c < data->chip->nchans; c++) {
> -		irq = irq_find_mapping(data->irq, c);
> -		irq_dispose_mapping(irq);
> +	if (data->irq) {
> +		for (c = 0; c < data->chip->nchans; c++) {
> +			irq = irq_find_mapping(data->irq, c);
> +			irq_dispose_mapping(irq);
> +		}
> +		irq_domain_remove(data->irq);
>  	}
> -	irq_domain_remove(data->irq);
> -
> -	return err;
> +	i2c_mux_del_adapters(muxc);
>  }
>  
>  /*
> @@ -417,6 +383,15 @@ static int pca954x_probe(struct i2c_client *client,
>  			goto fail_del_adapters;
>  	}
>  
> +	if (data->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, data->client->irq,
> +						NULL, pca954x_irq_handler,
> +						IRQF_ONESHOT | IRQF_SHARED,
> +						"pca954x", data);
> +		if (ret)
> +			goto fail_del_adapters;
> +	}
> +
>  	dev_info(&client->dev,
>  		 "registered %d multiplexed busses for I2C %s %s\n",
>  		 num, data->chip->muxtype == pca954x_ismux
> @@ -425,25 +400,15 @@ static int pca954x_probe(struct i2c_client *client,
>  	return 0;
>  
>  fail_del_adapters:
> -	i2c_mux_del_adapters(muxc);
> +	pca954x_cleanup(muxc);
>  	return ret;
>  }
>  
>  static int pca954x_remove(struct i2c_client *client)
>  {
>  	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> -	struct pca954x *data = i2c_mux_priv(muxc);
> -	int c, irq;
>  
> -	if (data->irq) {
> -		for (c = 0; c < data->chip->nchans; c++) {
> -			irq = irq_find_mapping(data->irq, c);
> -			irq_dispose_mapping(irq);
> -		}
> -		irq_domain_remove(data->irq);
> -	}
> -
> -	i2c_mux_del_adapters(muxc);
> +	pca954x_cleanup(muxc);
>  	return 0;
>  }
>  
> 
