Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0A363089
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781340; cv=none; b=SOt7qk1urxpMqBi+96y4FBwoRbrbohWqWsUmDCP7FYAmg0MzDKSp7hlkJWoUuyCGmKnIW+GnAi0zoe7egw7g1DtPmxkR+zenfoTVy+F+3wms70OH4Y8jSqxs95tUGyGuBbDROArWgoGWMV4A3cqzeKXyAK0RAbzFl+4ufePl80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781340; c=relaxed/simple;
	bh=icgIa+b0Q647C+2i94mePsYWxDhXkXTf4tIYk39LWVw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dwBK7YOTc7dvgtclbav0vZ9q3s/PIqgHAIHBZ9vBeyE1KoksK9Q5AcIYkO727gbmhvOxSuXdwaAbvFPPhFJ18c2NcBcb7ZQtfHEWH8+qgttsUaXjr5Y40JP2OXxw3R7fMo37J/22+ZEl07bsCjqupJNzrU+SeqgSeM9C2oQlzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dTc6fopJ; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dTc6fopJ"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57682ed;
	Sat, 19 Sep 2026 08:13:12 +0800 (GMT+08:00)
Message-ID: <27e3944f-81c6-48e4-8033-e30ae70f8e26@rock-chips.com>
Date: Sat, 19 Sep 2026 08:13:08 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aq1yU47vQT5OnxLo@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b7028bb103a4kunma3f32aa81a68a3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0pPVkpOHhlNTx9JHk0dTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dTc6fopJKXCuy8hHdVrdLPGJ7r3GVFBCWDlvW0U0wX632KlVKNTvB8kaFA4Lpaa55dW5YX/q8DdcFtrbp/Eg7FKsheUlTn8IC5kwPXITQvssYW3WTOaBqXoTMQy9qwX2V1v4D/226vd3qrHmS684qog1vYY91swGVKAnBiytR4g=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1pcrBPUiN1+2nlY2bqlloJAqwKSPEzkpGfZe5dtPHH4=;
	h=date:mime-version:subject:message-id:from;

Hi Sebastian

在 2026/09/19 星期六 1:21, Sebastian Reichel 写道:
> Hi,
> 
> On Fri, Sep 18, 2026 at 08:07:36PM +0800, Shawn Lin wrote:
>> When of_clk_get() failed in the middle of the loop, the references of
>> the clocks acquired so far were leaked instead of being released by
>> the error path.
>>
>> Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
> 
> Right, but this should switch
> 
> pd->clks = devm_kcalloc(...);
> 
> to
> 
> pd->clks = devm_kzalloc(...);
> 
> at the same time to ensure that clk_bulk_put() does not run over
> non-initialized data. Otherwise

Good catch, will improve it in v2.

Thanks.

> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Greetings,
> 
> -- Sebastian
> 
>>
>>   drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
>> index 068dd4b3..b6b099b 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>>   			dev_err(pmu->dev,
>>   				"%pOFn: failed to get clk at index %d: %d\n",
>>   				node, i, error);
>> -			return error;
>> +			goto err_put_clocks;
>>   		}
>>   	}
>>   
>> -- 
>> 2.7.4
>>
>>

