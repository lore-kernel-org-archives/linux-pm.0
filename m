Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09F503BD6
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678382; cv=none; b=rDlFdGNlsi7Bh5bhwBNZPpGGyGqDX35z0OsDbg5cWLpnIyLrXaMmTKAOl0xsNzICP6NKMRQtBdVOIT/5FM6I5IYy2u/SJ/ZnYAlNu6sfz8DE7P1bghSPVf7BnX7FxKpwDcC2F/1xGbk7fFgNlXPp6Zu9pc7CFBElKCsnb7ln1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678382; c=relaxed/simple;
	bh=Tx2eneziBlRsOioQABFzsl3/17KPc9PBgbL3eWDryv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAmnmCuJS2JwbHQG5zPdPWkUiTPvmFVZ5HDGgesc3tMUM+9kfeg0YlfHqpRSlIaJVh1cFJ3FJeqQVM5p4uHJaHFekm9ER/zi/bFnRi0xdpr1kMmT7+bGm2BHYlCFq0p/sk3Vs8/m4+jQadgNjPsWSoXV1CavVEByECu8AQSQjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ikTYAN5N; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ikTYAN5N"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so565385366b.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1790678371; x=1791283171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGSUCO2UQgWCXkEUCNYzi3LamPNV9IRan0Jxir3/waY=;
        b=ikTYAN5N9jrl6D5EjPKZIDkeOftxlzPRp87nKO4bTDOAFtSZCaIScspliNvDii1Ys4
         lHcboVWpcDfYUbBqGKqP6uARrkd5sKiovAWW+4xCF7xdgRiVEK0MkHrdJt3ANS2DyxTT
         MlbUxKLScoodXOJUBxuc2rZIaWGlkyfZd9m0TlhlzkDko1taU25WpUXBS17j+75JUmie
         yOh3P8ooin1SwULLeyYzccVAPLxu9/wN4rO+EdSEzEbESQGAbBfDO46O7sMDGpeQHzDI
         FuShlPAJ0tGG9ijXuqO6r6Kp1tZFSCGjPW17hAavBW42SxzLCSW6ZhgR6OaQYEOS2WQZ
         m8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790678371; x=1791283171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGSUCO2UQgWCXkEUCNYzi3LamPNV9IRan0Jxir3/waY=;
        b=xQgmAGWIEHbQs/cftg831P8cAmCSMhZ6hjwp5CMa5OiSXkl3j5eK1AFDwSPiIalr+3
         04lCKdbWDn2oyBcO8n0USD9CQrfeAYKu6NfNCLh6R7kl5NaVPaMhlgDAJMfvn5y8MLrp
         mcCS/80vnQCNAinIEVcrlLhJhHspdTok7W4ZAL8xk2Phy1S1AFYoMc8ItG1XLWf+GFmb
         B+SQfp/jiV886rWgE7Rw9zcPmmsm6xfsfOzLu/mgkOgdiYaSMc0DU5KL4giOdyaCw6pY
         L4KNiwhTDA4YJuSDIV4o6B5bCLl1G/9ioby2UjCYaZ6QaEhTbsG8UfmYqIoBhZ8ZySEg
         OZEw==
X-Forwarded-Encrypted: i=1; AKwUvBxaYiWmsIkNTBoDloHWtGKpaqexC2uM6iGAGqsHr/lZ31kQvr8996Jdfmq9W4KPGqqwrC5Lvu7C7Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lNddXbOt1jswCc/kW7VG5rUa20c7q8NPfIWoPe3nHK/XnAG3jr
	vWzT921ckP0fATz0CmW6Pugp8HpBiVtfaOhBmVxj2s8w2Ki4IzMcim0P8y9U5/eBUhA=
X-Gm-Gg: AYBFou088h1vDmwe/ZS+R5dtTmoFT2O3IevGPsUnwA/km5mWqVgmFa3igPbLQ91lkwg
	0lOs/wCpDUrwtcQDc0CHqzaG/PkEMBj4SqmK09zE9YcXnlljZ/atRjzjMNIOQwg+ZdR9Qkpiju4
	uOxAh5FVkAxEatZkDh0Jjabb6pi3yaPtq32P9cDMH1tT0XuCpDpZHxXkzzIh8tD4fAJZeeoOTb7
	+VTNSdrwbfs78LLF++NnhBjLmiafOydAtmDW8onAIGKaB25KWLGasHTOx1NHE6M0pmd4qLP9ial
	w5urcGxDf5DoqDNyImoCwvtovz+pL0UEd8XFC6otqACPPEX3fNqKMx73aa5DJuvB6LCtnjiKMA5
	iNxoVZY6SlhZ3YArazCHizYDHa+L88QIkkxJDuYBSwfiHVJ5VvL0nMfbPi/H6T72rPPW4+FcreO
	B0OUs3raqtUwe01Stz7HwUNH+p06aHQIYbdn+n7c8Sktf9qug+BT8Xbiqh+lXEle8dy/JqhllR0
	zUPxQ==
X-Received: by 2002:a17:907:94cc:b0:c2a:f518:1890 with SMTP id a640c23a62f3a-c2af51835cbmr962042366b.41.1790678370068;
        Tue, 29 Sep 2026 03:39:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae780d2ecsm622387966b.56.2026.09.29.03.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 03:39:28 -0700 (PDT)
Message-ID: <279864b5-9910-4dcb-894e-298d7ebb0fab@tuxon.dev>
Date: Tue, 29 Sep 2026 13:39:27 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal: rzg3e: Propagate reset assertion failure
 from suspend
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
 <e2c60ddc-b28f-4e49-9d52-590f14f374b5@oss.qualcomm.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e2c60ddc-b28f-4e49-9d52-590f14f374b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/28/26 19:36, Daniel Lezcano wrote:
> On 8/28/26 11:21, Pengpeng Hou wrote:
>> rzg3e_thermal_suspend() powers off an active sensor and then ignores
>> failure to assert its reset.  System sleep can therefore continue
>> without the clean reset state expected by resume.
>>
>> Return the reset error and, when the sensor had been active, try to
>> restore power before failing suspend.  This remains an RFC because a
>> reset assertion failure can represent partial hardware state and the
>> preferred recovery policy needs platform confirmation.
>>
>> The issue was identified via static analysis and manually reviewed.
>>
>> Assisted-by: LLM
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>   drivers/thermal/renesas/rzg3e_thermal.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/ 
>> renesas/rzg3e_thermal.c
>> index c44f5b8858d0..7686a45341b3 100644
>> --- a/drivers/thermal/renesas/rzg3e_thermal.c
>> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
>> @@ -499,15 +499,19 @@ static int rzg3e_thermal_runtime_resume(struct device *dev)
>>   static int rzg3e_thermal_suspend(struct device *dev)
>>   {
>>       struct rzg3e_thermal_priv *priv = dev_get_drvdata(dev);
>> +    bool active = pm_runtime_active(dev);
>> +    int ret;
>>       /* If device is active, power it off */
>> -    if (pm_runtime_active(dev))
>> +    if (active)
>>           rzg3e_thermal_power_off(priv);
>>       /* Assert reset to ensure clean state after resume */
>> -    reset_control_assert(priv->rstc);
>> +    ret = reset_control_assert(priv->rstc);
>> +    if (ret && active)
>> +        rzg3e_thermal_power_on(priv);
>> -    return 0;
>> +    return ret;
>>   }
>>   static int rzg3e_thermal_resume(struct device *dev)
> 
> Sounds reasonable
> 
> John ?

John is not with Renesas anymore. I'll reply myself to this.

The patch looks OK, I consider it is the best we can do to recover from that state.

The reset driver implementation try to do its best as well to recover the reset 
line in case the assert fails [1]. However, there is no guarantee the reset 
recover will succeed. Still, this looks like the best we can do to recover from 
the reset assert failure state.

You can add:
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu

[1] 
https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/clk/renesas/rzv2h-cpg.c#L1347
