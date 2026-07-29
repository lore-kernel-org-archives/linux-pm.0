Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9633537CC;
	Wed, 29 Jul 2026 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296633; cv=none; b=dGU25ZxzWTGys/QIvz8sHhxsihgNjcqjbOkJxO/l/ewjay6ohyrw1OH5ZUNQwlJj9r7qRfqYLY6SraCRQOPp32NzrxvABW2gG5u2tvR+LwOYv/lu01l3XD0WehOVlLqdxgWCjXTjMLuS1vbL7oiOUU+WsAwc39Gb36Ed2Uad4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296633; c=relaxed/simple;
	bh=lbDk2IH96tZDuOif+h60tQW7ZH4KoqpFUuTAkUBi6r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUFlZt2DpBGWcFinzzGcGx62JzMWYT+3j7Dvl1+AdY6z63iA39uezrYRFCyLtnn1N0vqciAI3u2UtXovKlu4sf9dE+yjoml/MgUAJLqKd/kAD16Qj71/OAQkhlqE+iyFrG0f9MHPgbe1In2zKvVNCxhZVczjTBvV3O7gLko1Wg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xQp0tPeM; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xQp0tPeM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785296622; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H6lI+Bvei+UM3BeaBZ7kk27wu1vhWLoKV8BRTuUGyU0=;
	b=xQp0tPeM8JuASxtxFBPMWt+UTLoWxLOPAUJ+tMk42dkVuaJTtuKOD5Lt1xZplq5J/XPx7DVNzdrABWV9fFzv+sDpk2XwIlTtJ34Fj8UQvypNaOGGFMQuv9hTfoBd+hQ6ePCHpF23PrP15bg9pu/3x9MsY7fAQB89ESvTHrhOTlg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X80kwPh_1785296621;
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X80kwPh_1785296621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 11:43:41 +0800
Message-ID: <ca1e30c2-ab03-407d-8a38-b7818c85ff8f@linux.alibaba.com>
Date: Wed, 29 Jul 2026 11:43:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: sc2731_charger: cancel work on remove
To: Hongyan Xu <getshell@seu.edu.cn>, sre@kernel.org, orsonzhai@gmail.com,
 zhang.lyra@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20260728123423.781-6-getshell@seu.edu.cn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260728123423.781-6-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/26 8:33 PM, Hongyan Xu wrote:
> The USB notifier and initial charger detection can schedule info->work.
> The remove path unregisters the notifier, but does not cancel queued or
> running work before the devm-allocated driver data is released.
> 
> Set the platform drvdata used by remove, then cancel the work after
> unregistering the notifier.
> 
> This issue was found by a static analysis tool.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---

Good catch. Please also add a Fixes tag, with that:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   drivers/power/supply/sc2731_charger.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
> index 58b86fd78..2b25e44da 100644
> --- a/drivers/power/supply/sc2731_charger.c
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -466,6 +466,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
>   	mutex_init(&info->lock);
>   	info->dev = &pdev->dev;
>   	INIT_WORK(&info->work, sc2731_charger_work);
> +	platform_set_drvdata(pdev, info);
>   
>   	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>   	if (!info->regmap) {
> @@ -516,6 +517,7 @@ static void sc2731_charger_remove(struct platform_device *pdev)
>   	struct sc2731_charger_info *info = platform_get_drvdata(pdev);
>   
>   	usb_unregister_notifier(info->usb_phy, &info->usb_notify);
> +	cancel_work_sync(&info->work);
>   }
>   
>   static const struct of_device_id sc2731_charger_of_match[] = {

