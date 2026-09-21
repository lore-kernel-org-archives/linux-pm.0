Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E43769E1
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974723; cv=none; b=aHnrtXlcqpVAMw+aD0ZASm8MGvfCGkJWf4QW1B9ehl+DoL+ozSXJHbs2ul+DlCrjzsRSm/a51bskpN66wJeb8iSujXygkmdcn7jeEEuxeOT33SsVLcvj+Mj9QlL438w4BkMbBndXqVmuDPFgtN5YoVc7FV/gm99U1K3RNYCUiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974723; c=relaxed/simple;
	bh=vJ29WxqIr40mU3U8A0Gbg1gPcIQEvlq1kSaM45aHeCo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXz8spYLNcWj2lZvedpZSdP0CxBpTi2rAbUd3dY4Rba80io1Jxyrt6GgF3NTSIVOFyfj+0eX65qscFwbABPYXj0x62Tbn40CpItqqEm9Gxgy9m09FVb+rk5BuT42FttAMfJUc0xi9BBTJZibYZeReroHAv08gJ9JNAZbj0Za160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kMQEIk5w; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kMQEIk5w"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e87e853c;
	Mon, 21 Sep 2026 14:36:26 +0800 (GMT+08:00)
Message-ID: <ee8bf4cf-b2bd-4cbd-ba8c-2e7a871203e1@rock-chips.com>
Date: Mon, 21 Sep 2026 14:36:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Caesar Wang <wxt@rock-chips.com>,
 Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in
 rockchip_pm_add_one_domain()
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Ulf Hansson <ulfh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c2ae1f1d03a4kunm8c2b5e35309363
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhhJVksdTE1CHxlISk9CGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kMQEIk5wm+g8UmyBDt3/0JnReaXCZVItYbM0nLAQDOdsl62qdaAqKGEa9njMr3zell849z8plW8LVvvLMDQK3kvxBFs+652EswyGO8aFqRiabnIN5D6z0jKvhXzwjbhkJJ+T9Ml3JCJMH/1VArRIWJMeOR2AnWpZRHzw0brBHAo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bLpwACqn9YN+hnHNFYXY6u+qLT2vyykvPNkreQhWJbE=;
	h=date:mime-version:subject:message-id:from;

Hi Sergey,

在 2026/09/21 星期一 1:59, Sergey Shtylyov 写道:
> In rockchip_pm_add_one_domain(), there's the check (most probably for
> the case where the "reg" prop has an unexpected value?) which doesn't

Agreed that check indeed makes little sense. But "most probably for the
case where the reg prop has an unexpected value" does not hold: an 
out-of-range reg value is already rejected by the "id >= pmu->info-
 >num_domains" check above, and num_domains equals
ARRAY_SIZE(domain_info) for every SoC, so there are no holes in the
table that the new check could catch with the current data. AFAICT, this 
patch does not change any runtime behaviour; it only turns dead code
into a defensive check on the match-data tables.


> make much sense as the variable pd_info will be NULL iff pmu->info->
> domain_info is NULL and the variable id is 0.  What does make sense
> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
> seems to follow from the code) can't both be 0 for a valid domain...
> 

That means there is no bug being fixed here, should we drop the fixes tag?

> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> ---
> This patch is against the fixes branch of Ulf Hansson's linux-pm.git repo.
> 
>   drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index ba66ae719428..69792e2b215b 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -809,7 +809,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>   		return 0;
>   
>   	pd_info = &pmu->info->domain_info[id];
> -	if (!pd_info) {
> +	if (!pd_info->pwr_mask && !pd_info->req_mask) {
>   		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
>   			node, id);
>   		return -EINVAL;

