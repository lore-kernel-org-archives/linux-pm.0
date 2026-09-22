Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com [220.197.32.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672D3ACEF7
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046607; cv=none; b=N3XMGQPhV2GoUi3bqhgZwDfllk7I6CxsfoF1FWpKxYNHa2KdLfd4EwYQ/4R23SLlfkhA9aGN8WvjRRcROJu96DtioSFuVB7eUNCXmxPChTod0LYPcuiR1RghZgZykmto0Ah3lnPwMeJ3vF6+unKEDpKVMN+aC+nBQq1c0ilUN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046607; c=relaxed/simple;
	bh=4gMfm3RhFr6b84tjG0Tx/7hYlM2dygRjl5adQTwv8r4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQ8YHAQznsGPsW+Qjkkj5iU975ZunBdDxqmJaJIVtxyMFI+2fAW+SfKWv4QJs8ihdn8ggxs7tCerd9QjFsS6Stg4EM8p1cUPb71sUtKDx+FyKyqEAgZVpcF5t/KXjUONAd1UnmOdR96jFAOdRwESOFToFTgwHrWbGaqfcb3cx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XAkuUZhY; arc=none smtp.client-ip=220.197.32.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XAkuUZhY"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea2fa38f;
	Tue, 22 Sep 2026 08:47:32 +0800 (GMT+08:00)
Message-ID: <1d8950b4-315f-44a4-9fc8-fcb35ac33043@rock-chips.com>
Date: Tue, 22 Sep 2026 08:47:28 +0800
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
 <ee8bf4cf-b2bd-4cbd-ba8c-2e7a871203e1@rock-chips.com>
 <140e4538-d493-40a7-a682-00be091332f0@auroraos.dev>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <140e4538-d493-40a7-a682-00be091332f0@auroraos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c6950c8a03a4kunm3e415e16385fee
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZThhOVkIfH0lMSU0eQh5MS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=XAkuUZhYuUHOcfG+P85pveAV24xvDwuRb0lJU9e7eK/kScso69+2Lq8WQeGjE51x/7bQGcRZV5XUKSZhvQqRqjAxIVpPlT6qPlpRH4UrHKP0av1dYvr6KNibIhaFqZWfRuDeYuCq6kxOAicRpJGc08cUP8KbZW3wPY5JlufWAjU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ghe12W3xx27L6Gp05sVA/Am+5fUdjvtLgHXnKRFlSdc=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/22 星期二 0:13, Sergey Shtylyov 写道:
> On 9/21/26 9:36 AM, Shawn Lin wrote:
> 
> [...]
> 
>>> In rockchip_pm_add_one_domain(), there's the check (most probably for
>>> the case where the "reg" prop has an unexpected value?) which doesn't
>>
>> Agreed that check indeed makes little sense. But "most probably for the
>> case where the reg prop has an unexpected value" does not hold: an
> 
>     I tried to guess what the check in question was actually intended for
> (despite making a little sense as it is now)...
> 
>> out-of-range reg value is already rejected by the "id >= pmu->info-
>>> num_domains" check above, and num_domains equals
> 
>     I noticed. :-)
> 
>> ARRAY_SIZE(domain_info) for every SoC, so there are no holes in the
>> table that the new check could catch with the current data. AFAICT, this
> 
>     Oh, there are holes! :-)
>     If you look at (and behind) the indexed initializers of *_pm_domains[],
> you'll see that the indexes don't always start at 0, and so the arrays are
> actually sparse...

Looked more closely by each one, you're right.

> 
>> patch does not change any runtime behaviour; it only turns dead code
>> into a defensive check on the match-data tables.
> 
>     I hope you see now that this defensive check makes a bit more sense...
> 
>>> make much sense as the variable pd_info will be NULL iff pmu->info->
>>> domain_info is NULL and the variable id is 0.  What does make sense
>>> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
>>> seems to follow from the code) can't both be 0 for a valid domain...
>>
>> That means there is no bug being fixed here, should we drop the fixes tag?
> 
>     I'd like to keep it (but that's up to the maintainers, of course)...

Sure, it's  Ulf's call. Anyway, feel free to add

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
>>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>>> static analysis tool.
>>>
>>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> [...]
> 
> MBR, Sergey
> 
> 

