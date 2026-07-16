Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAD382F1F;
	Thu, 16 Jul 2026 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176804; cv=none; b=Dub4lxompXldPZl5eVUNUHOwaBKj2JSJU6A6Mjnc2z7+dlvkaop5IdkEO+sm5yX46qBhScs8GUfUWt5wNb5OQ2Nwgg3YuHkS+YlbpwDKCHwMjmtxLNn9SOnhO1hiINdGNS3yIjtMbzbh8cxZKmJouszZWM9PeECZMvLea8oX54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176804; c=relaxed/simple;
	bh=c3RN7BRpX8QKB3ff0Sn+PujzwmiYcJUf1hhXXZ5BExI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=EF8kQwDiT4G/cWnsLfhCL2J62OaF/aaag2H/CuUNnAmTYfL9682EnFgOVcK6ifLAPEjXQl0/Avpcaq2gBerUBHo+1bY7idYe5ShLK08jdv9dhEqBI0kBJ3VuEQfBOL1RXdF04o6arXkJiWDWItA6vRLfDWV1/cmG2QGhkMYnw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kObxUABI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RPBrLGvj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kObxUABI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RPBrLGvj"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h10hC1dx1zKsGZ;
	Thu, 16 Jul 2026 06:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784176795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcpkV9siobUpO+f7IdelxmPLDPFX/aFAfSsv5BsO2uo=;
	b=kObxUABIKDkKw1LnU/pAk1nBEJo1kIXNiOx3DMGefy5Jd+NpXcSKuTl89RxJhR09FmDTqf
	cXyYUNsy+MqcQYG8/MjoKqnzkk46UOI8x9x0LSr4vY8QmJz8IEIG/lBvWAyl2sLqgvlArL
	IEqHCXAkW75S+jSpJX3naAOfwklnmWwYASn4MeyyxaPe/NLvcfakLE/p14oVSsqv7MiWRb
	C3Ydf6AkVm42eU2056hAXGo4I7HuNF68srLr2tdzMECPon2SClj+ZPWq/f6ytb7k8yya2u
	RiND1A9m5HiUNMmbN7EdJF9g7Ou10D3ayE0+fkCOJhg3G2bbxI+Q97xmEpNC8Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RPBrLGvj;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784176794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcpkV9siobUpO+f7IdelxmPLDPFX/aFAfSsv5BsO2uo=;
	b=RPBrLGvjcV/+Lfmvn4bVyUypkYIW58wSNxEe8hKBD4BaPZCUFLNRGclbguxtwPHxuZ/JHS
	uUVl5qgoNHTh0uu/AruB1EhUS1dYxN57JUxROMfvSKV0rSSrQR5VONGPyU6G07BR7PtQD7
	p8y0QG9GLngtry0pwfpuRrEpmUzKQ5kt4q0UbHf5283711EMxhgJV9o7oEEdSn4feBV+0t
	+Df22U9+gjPvAuQW9vWgdcEUMEtlB8Bs1fsGv5YbKQqWiq9JgA1N8oOP50QtphAXGNYrDD
	NUQW4Gu4W0eZ0liZBSM3eIg5VB5SypU1C/Evx8wmZjlNzfoWRntmLAa/ZvjgdA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 12:39:41 +0800
Message-Id: <DJZPVU5G5M3L.QJOUYNYKKDCJ@mailbox.org>
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver
 remove
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, "Shuwei Wu" <shuwei.wu@mailbox.org>,
 <dlan@kernel.org>, <rafael@kernel.org>, <troy.mitchell@linux.spacemit.com>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn> <DJY88BBD7RCM.20K3BATZ6JIM7@mailbox.org> <c054b269-9507-4da1-8e20-cbc85cdafe23@kylinos.cn>
In-Reply-To: <c054b269-9507-4da1-8e20-cbc85cdafe23@kylinos.cn>
X-MBO-RS-ID: f29254968fa440c7861
X-MBO-RS-META: qwk9mydffxwmycptreb4fndyc16ocqj7
X-Rspamd-Queue-Id: 4h10hC1dx1zKsGZ

Hi Pei,

On Wed Jul 15, 2026 at 11:11 AM CST, Pei Xiao wrote:
>
>
> =E5=9C=A8 2026/7/14 18:36, Shuwei Wu =E5=86=99=E9=81=93:
>> Hi Pei,
>>
>> On Mon Jul 13, 2026 at 4:32 PM CST, Pei Xiao wrote:
>>> The driver uses devm_request_threaded_irq() but never disables the
>>> hardware interrupt enable, sensor enable, or sensor power bits when
>>> the driver is unbound.
>>>
>>> Add a devm action that clears K1_TSENSOR_INT_EN_REG,
>>> K1_TSENSOR_EN_ALL, and K1_TSENSOR_PCTRL_ENABLE on remove, mirroring
>>> what k1_tsensor_init() sets up.
>>>
>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>>> ---
>>>  drivers/thermal/spacemit/k1_tsensor.c | 27 +++++++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/sp=
acemit/k1_tsensor.c
>>> index 79222d233129..cf79dc7d403f 100644
>>> --- a/drivers/thermal/spacemit/k1_tsensor.c
>>> +++ b/drivers/thermal/spacemit/k1_tsensor.c
>>> @@ -199,6 +199,29 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, =
void *data)
>>>  	return IRQ_HANDLED;
>>>  }
>>> =20
>>> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
>>> +{
>>> +	u32 val;
>>> +
>>> +	/* Disable all interrupts */
>>> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
>>> +
>>> +	/* Disable all sensor */
>>> +	val =3D readl(ts->base + K1_TSENSOR_EN_REG);
>>> +	val &=3D ~K1_TSENSOR_EN_ALL;
>>> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
>>> +
>>> +	/* Power down the sensor module */
>>> +	val =3D readl(ts->base + K1_TSENSOR_PCTRL_REG);
>>> +	val &=3D ~K1_TSENSOR_PCTRL_ENABLE;
>>> +	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
>>> +}
>>> +
>>> +static void devm_k1_tsensor_shutdown(void *data)
>>> +{
>>> +	k1_tsensor_shutdown(data);
>>> +}
>>> +
>>>  static int k1_tsensor_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev =3D &pdev->dev;
>>> @@ -229,6 +252,10 @@ static int k1_tsensor_probe(struct platform_device=
 *pdev)
>>> =20
>>>  	k1_tsensor_init(ts);
>>> =20
>>> +	ret =3D devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>  	irq =3D platform_get_irq(pdev, 0);
>>>  	if (irq < 0)
>>>  		return irq;
>> Sorry, I missed the hardware cleanup in the original driver.
>> Thanks for fixing it.
>>
>> I also found that registering the shutdown action immediately after
>> k1_tsensor_init() would cause the thermal zones to be released before
>> the IRQ during devres cleanup. The IRQ thread may then access an
>> unregistered thermal zone.
>>
>> I changed the order so that the thermal zones are registered first,
>> followed by the IRQ and the shutdown action.
>> On removal, the hardware interrupt is disabled first, then the IRQ
>> is released, and finally the thermal zones are released.
> I notice that the changes you've made are significantly more extensive
> than my original patch.
> =C2=A0Could you please let me know whether you plan to submit this patch
> yourself,=C2=A0
> or whether you would like me to send it? If you would prefer me to
> submit it,=C2=A0
> I would be delighted to contribute to the community.

Thank you for your reply. Since the original cleanup issue was
identified by you, I would be happy for you to submit the update patch.

>
> Thanks=EF=BC=81
> Pei.
>
>> -> % git --no-pager diff drivers/thermal/spacemit/k1_tsensor.c
>> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spa=
cemit/k1_tsensor.c
>> index 79222d233129..57dbc652a405 100644
>> --- a/drivers/thermal/spacemit/k1_tsensor.c
>> +++ b/drivers/thermal/spacemit/k1_tsensor.c
>> @@ -199,6 +199,32 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, v=
oid *data)
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
>> +	/* Disable all sensors */
>> +	val =3D readl(ts->base + K1_TSENSOR_EN_REG);
>> +	val &=3D ~K1_TSENSOR_EN_ALL;
>> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
>> +
>> +	/* Clear the sampling configuration set by k1_tsensor_init(). */
>> +	val =3D readl(ts->base + K1_TSENSOR_TIME_REG);
>> +	val &=3D ~(K1_TSENSOR_TIME_FILTER_PERIOD |
>> +		 K1_TSENSOR_TIME_ADC_CNT_RST |
>> +		 K1_TSENSOR_TIME_WAIT_REF_CNT);
>> +	writel(val, ts->base + K1_TSENSOR_TIME_REG);
>> +
>> +	/* Clear the control bits configured by k1_tsensor_init(). */
>> +	val =3D readl(ts->base + K1_TSENSOR_PCTRL_REG);
>> +	val &=3D ~(K1_TSENSOR_PCTRL_RAW_SEL |
>> +		 K1_TSENSOR_PCTRL_TEMP_MODE |
>> +		 K1_TSENSOR_PCTRL_HW_AUTO_MODE |
>> +		 K1_TSENSOR_PCTRL_ENABLE);
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
>>  	struct device *dev =3D &pdev->dev;
>> @@ -229,34 +255,48 @@ static int k1_tsensor_probe(struct platform_device=
 *pdev)
>>
>>  	k1_tsensor_init(ts);
>>
>> -	irq =3D platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return irq;
>> -
>> -	ret =3D devm_request_threaded_irq(dev, irq, NULL,
>> -					k1_tsensor_irq_thread,
>> -					IRQF_ONESHOT, "k1_tsensor", ts);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>  	for (i =3D 0; i < MAX_SENSOR_NUMBER; ++i) {
>>  		ts->ch[i].id =3D i;
>>  		ts->ch[i].ts =3D ts;
>>  		ts->ch[i].tzd =3D devm_thermal_of_zone_register(dev, i, ts->ch + i, &=
k1_tsensor_ops);
>> -		if (IS_ERR(ts->ch[i].tzd))
>> -			return PTR_ERR(ts->ch[i].tzd);
>> +		if (IS_ERR(ts->ch[i].tzd)) {
>> +			ret =3D PTR_ERR(ts->ch[i].tzd);
>> +			goto err_shutdown;
>> +		}
>>
>>  		/* Attach sysfs hwmon attributes for userspace monitoring */
>>  		ret =3D devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
>>  		if (ret)
>>  			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
>> +	}
>>
>> -		k1_tsensor_enable_irq(ts->ch + i);
>> +	ret =3D platform_get_irq(pdev, 0);
>> +	if (ret < 0) {
>> +		goto err_shutdown;
>>  	}
> irq =3D platform_get_irq(pdev, 0); if (irq < 0) { ret =3D irq; goto
> err_shutdown; }=C2=A0 =C2=A0=C2=A0

agreed.

>
>>
>> +	ret =3D devm_request_threaded_irq(dev, irq, NULL,
>> +					k1_tsensor_irq_thread,
>> +					IRQF_ONESHOT, "k1_tsensor", ts);
>> +	if (ret < 0)
>> +		goto err_shutdown;
>> +
>> +	ret =3D devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
> *Do we need to rename=C2=A0|devm_k1_tsensor_shutdown|=C2=A0to a function =
name=C2=A0
> without the=C2=A0|devm|=C2=A0prefix? I feel the=C2=A0|devm|=C2=A0prefix i=
s a bit redundant.

yes, k1_tsensor_shutdown_action() would be a clearer name.

>
> *
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable interrupts only after all zones and the handler are ready. *=
/
>> +	for (i =3D 0; i < MAX_SENSOR_NUMBER; ++i)
>> +		k1_tsensor_enable_irq(ts->ch + i);
>> +
>>  	platform_set_drvdata(pdev, ts);
>>
>>  	return 0;
>> +
>> +err_shutdown:
>> +	k1_tsensor_shutdown(ts);
>> +	return ret;
>>  }
>>
>>  static const struct of_device_id k1_tsensor_dt_ids[] =3D {
>>

--=20
Best regards,
Shuwei Wu
