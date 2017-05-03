From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v6 5/8] i2c: mux: pca954x: Call request irq after adding
 mux segments
Date: Wed, 3 May 2017 16:36:37 +0800
Message-ID: <8587aabe-ca4a-8424-d24f-cd228e01957f@electromag.com.au>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-6-git-send-email-preid@electromag.com.au>
 <28f3ce1d-ad4b-3082-7499-b30245a256c1@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:43726 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752203AbdECIgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 04:36:44 -0400
In-Reply-To: <28f3ce1d-ad4b-3082-7499-b30245a256c1@axentia.se>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com

On 2/05/2017 17:57, Peter Rosin wrote:
> On 2017-05-02 11:12, Phil Reid wrote:
>> The pca954x device do not have the ability to mask interrupts. For
>> i2c slave devices that also don't have masking ability (eg ltc1760
>> smbalert output) delay registering the irq until after the mux
>> segments have been configured. During the mux add_adaptor call the
>> core i2c system can register an smbalert handler which would then
>> be called immediately when the irq is registered. This smbalert
>> handler will then clear the pending irq.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>   drivers/i2c/muxes/i2c-mux-pca954x.c | 52 +++++++++++++++++--------------------
>>   1 file changed, 24 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index ad31d21..4299738 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -294,7 +294,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>>   {
>>   	struct pca954x *data = i2c_mux_priv(muxc);
>>   	struct i2c_client *client = data->client;
>> -	int c, err, irq;
>> +	int c, irq;
>>   
>>   	if (!data->chip->has_irq || client->irq <= 0)
>>   		return 0;
>> @@ -314,24 +314,22 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>>   			handle_simple_irq);
>>   	}
>>   
>> -	err = devm_request_threaded_irq(&client->dev, data->client->irq, NULL,
>> -					pca954x_irq_handler,
>> -					IRQF_ONESHOT | IRQF_SHARED,
>> -					"pca954x", data);
>> -	if (err)
>> -		goto err_req_irq;
>> +	return 0;
>> +}
>>   
>> -	disable_irq(data->client->irq);
>> +static void pca954x_cleanup(struct i2c_mux_core *muxc)
>> +{
>> +	struct pca954x *data = i2c_mux_priv(muxc);
>> +	int c, irq;
>>   
>> -	return 0;
>> -err_req_irq:
>> -	for (c = 0; c < data->chip->nchans; c++) {
>> -		irq = irq_find_mapping(data->irq, c);
>> -		irq_dispose_mapping(irq);
>> +	if (data->irq) {
>> +		for (c = 0; c < data->chip->nchans; c++) {
>> +			irq = irq_find_mapping(data->irq, c);
>> +			irq_dispose_mapping(irq);
>> +		}
>> +		irq_domain_remove(data->irq);
>>   	}
>> -	irq_domain_remove(data->irq);
>> -
>> -	return err;
>> +	i2c_mux_del_adapters(muxc);
>>   }
>>   
>>   /*
>> @@ -422,6 +420,14 @@ static int pca954x_probe(struct i2c_client *client,
>>   		}
>>   	}
>>   
>> +	if (data->chip->has_irq || client->irq > 0) {
> 
> This should be && instead of ||. However, I think it's better to not
> try to replicate the inverse of the test in pca954x_irq_setup and
> instead just check if the irq domain is there with "if (data->irq)".
> Assuming that is the intent...
Yeah, that's better.

> 
>> +		ret = devm_request_threaded_irq(&client->dev, data->client->irq,
>> +		NULL, pca954x_irq_handler, IRQF_ONESHOT | IRQF_SHARED,
>> +		"pca954x", data);
> 
> The indentation is horrific. Please fix.
oops

> 
> Acked with those two fixed.
> 
> I also noticed that there is no check for failure of the call to
> irq_create_mapping in pca954x_irq_setup. For bonus points, can you
> fix that error path too, please? Or should failure to create those
> irq mappings not be fatal for some reason?
Seems reasonable to fail. I'll fix that as well.

> 
> Cheers,
> peda
> 
>> +		if (ret)
>> +			goto fail_del_adapters;
>> +	}
>> +
>>   	dev_info(&client->dev,
>>   		 "registered %d multiplexed busses for I2C %s %s\n",
>>   		 num, data->chip->muxtype == pca954x_ismux
>> @@ -430,25 +436,15 @@ static int pca954x_probe(struct i2c_client *client,
>>   	return 0;
>>   
>>   fail_del_adapters:
>> -	i2c_mux_del_adapters(muxc);
>> +	pca954x_cleanup(muxc);
>>   	return ret;
>>   }
>>   
>>   static int pca954x_remove(struct i2c_client *client)
>>   {
>>   	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>> -	struct pca954x *data = i2c_mux_priv(muxc);
>> -	int c, irq;
>>   
>> -	if (data->irq) {
>> -		for (c = 0; c < data->chip->nchans; c++) {
>> -			irq = irq_find_mapping(data->irq, c);
>> -			irq_dispose_mapping(irq);
>> -		}
>> -		irq_domain_remove(data->irq);
>> -	}
>> -
>> -	i2c_mux_del_adapters(muxc);
>> +	pca954x_cleanup(muxc);
>>   	return 0;
>>   }
>>   
>>
> 
> 
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
