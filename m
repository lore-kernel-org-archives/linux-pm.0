Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45327368D5A;
	Tue, 14 Jul 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025533; cv=none; b=hUGc31bH/6itYWLWlyKOK0+UTIWPLR5clLXfjlbOeiG7Gr4O4CxDq5NyNvwXK9beDO9T8zkMJq16A30eOqHayWab7L5X5cQQX3Srkt0uHRTgXV9TwyxJpIwF/vO6y3H6Y3RgdjGFQ2xVZS16gH7++UMca/KZq8xmr/G+QjM119o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025533; c=relaxed/simple;
	bh=xuD11yrUglz0N8H6Pl75Akrvejs06KweiRy7uhZ/e/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=UruEMcAFdyWEA3HxX+bZMZ4SCweWVIrPcHjj3HCpT0ga5btgLktmK/StHPomeBJ42UjVDdspBVvIyJmU+ukoQfGp/ilsGC66Ws4G83LFR6YQx3Cc6AhLBvqYth0Zy5mLfhdi8mp2nY8SZxRePjtDR6G564ses3Pavt5rDNs3o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GVjizdYY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wx9EybNJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GVjizdYY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wx9EybNJ"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gzwlF1FH2zKn6W;
	Tue, 14 Jul 2026 12:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784025529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQRClI1WHGqvIeiewR59N1xWQ5Dskfhayb2qkUVyZyk=;
	b=GVjizdYYnDvtzhcGVhi53BMPE6ECY25CIiUjvHtRW2n8R0Ay4OUB3BZA5mBaQNX+WcC0ls
	yEVYBAapDQmKYalE5Q50VppsXKSjwtV3+Jt33btsFhUwY94Hd5jSRTaSeXyLjxB8H8IaW3
	nTxxBaXnbKx4FG0TbgE3jIZtBkAE9Ib6J5l8Tq/AbsTLNjnMKUDzCnp8wP30oXRrQaIMc0
	sjwtQ/t27k+GKA/xN7X0FpyuVUoblCw7c+A95Er5K99PxuF7XVmEYj3+o7vdH4dUa+XHlD
	BIjj0ARlthj23hcWRJxdRww8g2zodEqY2NoXUwnB6xbVTHbvnhFshVJ+3HPwzw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wx9EybNJ;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784025527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQRClI1WHGqvIeiewR59N1xWQ5Dskfhayb2qkUVyZyk=;
	b=wx9EybNJh/mNTtcPVrb+Oo3WjXlCx+IH5OVOTsN+UA06FT7OEVBhuHgUfdtDMjoI0oH5nJ
	tF3aw2KbR2S4ARSDCYCg45o103pJpM0TIjqb6QBLFFpqXl1LFCBKfkE/US2lmko+ibaHtj
	O5rcUpSo5ECyvMUf3Wr03b8nCpQrEJNryB3q7qFTzwI8uVC1mumnru+sy+Jrjx3+0ZmFhO
	FO7yiVFt5wNsb2YH3OhL4L7+f2KDXcTttDaaCQfPwMCinuBeUqEjaj7osaIt7hIkEdyrnZ
	2tuMhVDr9F9C40vsf6fXmM9RfS7cegPOLZFvpgY101/FNZSJv7Lc7/wY2fa3Pg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 18:38:35 +0800
Message-Id: <DJY89JCAP6HK.2RUO09KG9FSWA@mailbox.org>
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver
 remove
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, <dlan@kernel.org>, <rafael@kernel.org>,
 <shuwei.wu@mailbox.org>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn> <DJXB4PDMYX0G.1TC9VBR96MHMA@linux.spacemit.com> <b7803ac7-c9e1-4905-9256-4b67e41ad1ac@kylinos.cn>
In-Reply-To: <b7803ac7-c9e1-4905-9256-4b67e41ad1ac@kylinos.cn>
X-MBO-RS-META: g1pnnbscjrnt9rtbja9g3w6t59ioi4yr
X-MBO-RS-ID: 45e1db2ad9b25c0df3c
X-Rspamd-Queue-Id: 4gzwlF1FH2zKn6W

Hi Pei,

On Mon Jul 13, 2026 at 4:55 PM CST, Pei Xiao wrote:
>
>
> =E5=9C=A8 2026/7/13 16:40, Troy Mitchell =E5=86=99=E9=81=93:
>> On Mon Jul 13, 2026 at 1:32 AM PDT, Pei Xiao wrote:
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
>> Why is only the ENABLE bit cleared here?
>> At init time the driver also sets:
>>     val |=3D K1_TSENSOR_PCTRL_RAW_SEL |
>>     K1_TSENSOR_PCTRL_TEMP_MODE |
>>     K1_TSENSOR_PCTRL_HW_AUTO_MODE |
>>     K1_TSENSOR_PCTRL_ENABLE;
>>
>> Should the other bits be cleared in shutdown as well, or is clearing ENA=
BLE
>> alone?
> Hi Troy,
> =C2=A0Maybe Wu(author) have someting to say about these regs.
> =C2=A0Thanks.
>
> Pei.

Thanks for pointing this out.

I agree that the shutdown path should clear all control bits
set by k1_tsensor_init().

The managed cleanup will assert the reset, but the reset operation may fail
and its return value is ignored. Therefore, it is safer to disable these
settings explicitly before releasing the resources.

>
>
>>                             - Troy

--=20
Best regards,
Shuwei Wu
