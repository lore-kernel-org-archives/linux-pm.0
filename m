Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF635E1AE;
	Wed, 15 Jul 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085123; cv=none; b=UWhdNtRXUdG3pJldRI0BR7L+nTv7u08O6TqihC3us4+qPXa8aQ9HAZD2QUXU+0Og2VP2Q+Na9IUz2cEo7wTqO+ovCRiy5R4D7tl7twhpPbJArHUBEMzsbH5w5HvpGVIUfj3be4zNkV7RTezPkK9QT1QkyJ6TMjO7qlXLYcBa4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085123; c=relaxed/simple;
	bh=JMcD7eo1SOghe3JIE+3IDaxEj9YWatJsHiBhGj1yLdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JMBYiWppkbGSsEpFVR1vZfdmctylUs7ErutTeNnRKMCt+MH5DNEtB0TV7dJI8x6C8dXzPRBQIYc+w7mrpCukcgu1J33HboAop9WvFTivnDKnTdKAS9y1fDF+gl9jKscbYnuPf2lvLlY4bq5/JuhBWEQf1bpRssd4w1meVWMgj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: efc56e0a7ffa11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3368d2fd-56d6-4af5-be44-d4c95898b092,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0756902377dd117f04275f2b497f96c4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efc56e0a7ffa11f1aa26b74ffac11d73-20260715
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 921327230; Wed, 15 Jul 2026 11:11:56 +0800
Message-ID: <c054b269-9507-4da1-8e20-cbc85cdafe23@kylinos.cn>
Date: Wed, 15 Jul 2026 11:11:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver remove
To: Shuwei Wu <shuwei.wu@mailbox.org>, dlan@kernel.org, rafael@kernel.org,
 troy.mitchell@linux.spacemit.com, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
 <DJY88BBD7RCM.20K3BATZ6JIM7@mailbox.org>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <DJY88BBD7RCM.20K3BATZ6JIM7@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/14 18:36, Shuwei Wu 写道:
> Hi Pei,
>
> On Mon Jul 13, 2026 at 4:32 PM CST, Pei Xiao wrote:
>> The driver uses devm_request_threaded_irq() but never disables the
>> hardware interrupt enable, sensor enable, or sensor power bits when
>> the driver is unbound.
>>
>> Add a devm action that clears K1_TSENSOR_INT_EN_REG,
>> K1_TSENSOR_EN_ALL, and K1_TSENSOR_PCTRL_ENABLE on remove, mirroring
>> what k1_tsensor_init() sets up.
>>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/thermal/spacemit/k1_tsensor.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
>> index 79222d233129..cf79dc7d403f 100644
>> --- a/drivers/thermal/spacemit/k1_tsensor.c
>> +++ b/drivers/thermal/spacemit/k1_tsensor.c
>> @@ -199,6 +199,29 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
>> +{
>> +	u32 val;
>> +
>> +	/* Disable all interrupts */
>> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
>> +
>> +	/* Disable all sensor */
>> +	val = readl(ts->base + K1_TSENSOR_EN_REG);
>> +	val &= ~K1_TSENSOR_EN_ALL;
>> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
>> +
>> +	/* Power down the sensor module */
>> +	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
>> +	val &= ~K1_TSENSOR_PCTRL_ENABLE;
>> +	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
>> +}
>> +
>> +static void devm_k1_tsensor_shutdown(void *data)
>> +{
>> +	k1_tsensor_shutdown(data);
>> +}
>> +
>>  static int k1_tsensor_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -229,6 +252,10 @@ static int k1_tsensor_probe(struct platform_device *pdev)
>>  
>>  	k1_tsensor_init(ts);
>>  
>> +	ret = devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
>> +	if (ret)
>> +		return ret;
>> +
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0)
>>  		return irq;
> Sorry, I missed the hardware cleanup in the original driver.
> Thanks for fixing it.
>
> I also found that registering the shutdown action immediately after
> k1_tsensor_init() would cause the thermal zones to be released before
> the IRQ during devres cleanup. The IRQ thread may then access an
> unregistered thermal zone.
>
> I changed the order so that the thermal zones are registered first,
> followed by the IRQ and the shutdown action.
> On removal, the hardware interrupt is disabled first, then the IRQ
> is released, and finally the thermal zones are released.
I notice that the changes you've made are significantly more extensive
than my original patch.
 Could you please let me know whether you plan to submit this patch
yourself, 
or whether you would like me to send it? If you would prefer me to
submit it, 
I would be delighted to contribute to the community.

Thanks！
Pei.

> -> % git --no-pager diff drivers/thermal/spacemit/k1_tsensor.c
> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
> index 79222d233129..57dbc652a405 100644
> --- a/drivers/thermal/spacemit/k1_tsensor.c
> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> @@ -199,6 +199,32 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>
> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
> +{
> +	u32 val;
> +
> +	/* Disable all interrupts */
> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Disable all sensors */
> +	val = readl(ts->base + K1_TSENSOR_EN_REG);
> +	val &= ~K1_TSENSOR_EN_ALL;
> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
> +
> +	/* Clear the sampling configuration set by k1_tsensor_init(). */
> +	val = readl(ts->base + K1_TSENSOR_TIME_REG);
> +	val &= ~(K1_TSENSOR_TIME_FILTER_PERIOD |
> +		 K1_TSENSOR_TIME_ADC_CNT_RST |
> +		 K1_TSENSOR_TIME_WAIT_REF_CNT);
> +	writel(val, ts->base + K1_TSENSOR_TIME_REG);
> +
> +	/* Clear the control bits configured by k1_tsensor_init(). */
> +	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
> +	val &= ~(K1_TSENSOR_PCTRL_RAW_SEL |
> +		 K1_TSENSOR_PCTRL_TEMP_MODE |
> +		 K1_TSENSOR_PCTRL_HW_AUTO_MODE |
> +		 K1_TSENSOR_PCTRL_ENABLE);
> +	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
> +}
> +
> +static void devm_k1_tsensor_shutdown(void *data)
> +{
> +	k1_tsensor_shutdown(data);
> +}
> +
>  static int k1_tsensor_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -229,34 +255,48 @@ static int k1_tsensor_probe(struct platform_device *pdev)
>
>  	k1_tsensor_init(ts);
>
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> -
> -	ret = devm_request_threaded_irq(dev, irq, NULL,
> -					k1_tsensor_irq_thread,
> -					IRQF_ONESHOT, "k1_tsensor", ts);
> -	if (ret < 0)
> -		return ret;
> -
>  	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
>  		ts->ch[i].id = i;
>  		ts->ch[i].ts = ts;
>  		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
> -		if (IS_ERR(ts->ch[i].tzd))
> -			return PTR_ERR(ts->ch[i].tzd);
> +		if (IS_ERR(ts->ch[i].tzd)) {
> +			ret = PTR_ERR(ts->ch[i].tzd);
> +			goto err_shutdown;
> +		}
>
>  		/* Attach sysfs hwmon attributes for userspace monitoring */
>  		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
>  		if (ret)
>  			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> +	}
>
> -		k1_tsensor_enable_irq(ts->ch + i);
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		goto err_shutdown;
>  	}
irq = platform_get_irq(pdev, 0); if (irq < 0) { ret = irq; goto
err_shutdown; }    

>
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					k1_tsensor_irq_thread,
> +					IRQF_ONESHOT, "k1_tsensor", ts);
> +	if (ret < 0)
> +		goto err_shutdown;
> +
> +	ret = devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
*Do we need to rename |devm_k1_tsensor_shutdown| to a function name 
without the |devm| prefix? I feel the |devm| prefix is a bit redundant.

*
> +	if (ret)
> +		return ret;
> +
> +	/* Enable interrupts only after all zones and the handler are ready. */
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i)
> +		k1_tsensor_enable_irq(ts->ch + i);
> +
>  	platform_set_drvdata(pdev, ts);
>
>  	return 0;
> +
> +err_shutdown:
> +	k1_tsensor_shutdown(ts);
> +	return ret;
>  }
>
>  static const struct of_device_id k1_tsensor_dt_ids[] = {
>

