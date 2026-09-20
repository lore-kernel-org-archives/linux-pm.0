Received: from mail-m49203.qiye.163.com (mail-m49203.qiye.163.com [45.254.49.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CE1643B
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867886; cv=none; b=sHMN1wHrQV+LIjutX0qXB4vNgkonlQ4Lakp7rtXgRJgzopObRhvDzSM23qKCnSkv7cKx6IsBhh1wp3U2iMF8/ZhoYOzbyA52VKY6lPa8nGwm2VhX03LLK9MxIrvAUhDXz/nfUF4eHHaS1yLc1hsZEkmC1IQ7xTedoQdSQvHoYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867886; c=relaxed/simple;
	bh=1at9Ltdotc5tXpI2tdF3Lgs3zGnNUocJDhc7VN5UY2E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CzaZirU+dRlhqX2IdyTfzplEZYaKjjAddF6QTzFTCflpJF+6YUiaoJZ38Jb4EgNsYpQDH/aWwxD93h+iajZRgZBcTNZQJirhFS9yjmxrzOnVJoekKs8r1FWx09KXgHbVlWWwc5KVXaMH7l0Mw2yCosulHyckNqhGofHcs7w05uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=irK9E5Sn; arc=none smtp.client-ip=45.254.49.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="irK9E5Sn"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e65c9cbf;
	Sun, 20 Sep 2026 09:15:56 +0800 (GMT+08:00)
Message-ID: <3fa0fcbc-b6ff-4934-bb7d-b763d6f5f818@rock-chips.com>
Date: Sun, 20 Sep 2026 09:15:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulfh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe
 failure
To: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
 <1789733258-10133-3-git-send-email-shawn.lin@rock-chips.com>
 <aq1yU47vQT5OnxLo@venus>
 <27e3944f-81c6-48e4-8033-e30ae70f8e26@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <27e3944f-81c6-48e4-8033-e30ae70f8e26@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0bc6255e003a4kunmd3d2597e236429
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQklIVksaQx0fT0lDH0tPGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=irK9E5Sn8gjx26N6v03fi92SxtUUQkf878PQkcEHbHH/C1VWK42Th86sM3fTjzd8Gtummu2GG0JsbdMOAUK6OxfoS9A0YI+JdD6j4Yhcf9kQrKCOOKv5svqr481yOCtYfdenEgw5M4xE2CK/z0aDIrfmtJ/FzD8V+4Ct1cq9mzI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VtX02XvGRhQ2FxudCuxh58xlxXnkNt9W6SpJeJT1xZI=;
	h=date:mime-version:subject:message-id:from;

Hi Sebastian

在 2026/09/19 星期六 8:13, Shawn Lin 写道:
> Hi Sebastian
> 
> 在 2026/09/19 星期六 1:21, Sebastian Reichel 写道:
>> Hi,
>>
>> On Fri, Sep 18, 2026 at 08:07:36PM +0800, Shawn Lin wrote:
>>> When of_clk_get() failed in the middle of the loop, the references of
>>> the clocks acquired so far were leaked instead of being released by
>>> the error path.
>>>
>>> Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>
>> Right, but this should switch
>>
>> pd->clks = devm_kcalloc(...);
>>
>> to
>>
>> pd->clks = devm_kzalloc(...);
>>
>> at the same time to ensure that clk_bulk_put() does not run over
>> non-initialized data. Otherwise
> 
> Good catch, will improve it in v2.
> 

I was too quick to response, but didn't looked into devm_kcalloc, just
guess it didn't zero the data from the name. However it does zero the
data by passing in __GFP_ZERO. So I need to respin v3 and drop
devm_kzalloc change.


> Thanks.
> 
>>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>
>> Greetings,
>>
>> -- Sebastian
>>
>>>
>>>   drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/ 
>>> pmdomain/rockchip/pm-domains.c
>>> index 068dd4b3..b6b099b 100644
>>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>>> @@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct 
>>> rockchip_pmu *pmu,
>>>               dev_err(pmu->dev,
>>>                   "%pOFn: failed to get clk at index %d: %d\n",
>>>                   node, i, error);
>>> -            return error;
>>> +            goto err_put_clocks;
>>>           }
>>>       }
>>> -- 
>>> 2.7.4
>>>
>>>
> 
> 

