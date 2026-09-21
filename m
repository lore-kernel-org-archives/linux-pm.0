Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED33C140F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007196; cv=none; b=T1WsR5V0sShpqxfXGVX7zpoV2nAglFPOyujf78vdys9uqilF6YgUVtwbGrrQxn0qqDDhdRjuBeWyGYr1cNmFayLKtrecDHjkf7JnmBRqRFM8zCGuhE17tSBI2PGDMwZZleLN4DMgDfAsO1EiHoMOcNPZ+oHSE/W20lGKHlqEML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007196; c=relaxed/simple;
	bh=gT8a/W2cE55r/tLX2wzwShm43EMgTYSbsz9OszeP88I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gg8p+K0eHEI9oYVQdGAd+IEFYab2v0LmH2QbMlTJhwWgp6yckZL0pdTOz/X4k3n2lQrqZRXdiwxkt++CuFExAHUl4l7wwthaUxJkIh/NCyyqVAxz5dmCgW6wRhDcnQYKolrrti4M9ZtUjcNzF073vCXgGpVnmJqDOHCPpUdKLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.36.28) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 21 Sep
 2026 19:13:04 +0300
Message-ID: <140e4538-d493-40a7-a682-00be091332f0@auroraos.dev>
Date: Mon, 21 Sep 2026 19:13:03 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in
 rockchip_pm_add_one_domain()
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, <linux-pm@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>
CC: Caesar Wang <wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
 <ee8bf4cf-b2bd-4cbd-ba8c-2e7a871203e1@rock-chips.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <ee8bf4cf-b2bd-4cbd-ba8c-2e7a871203e1@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/21/26 9:36 AM, Shawn Lin wrote:

[...]

>> In rockchip_pm_add_one_domain(), there's the check (most probably for
>> the case where the "reg" prop has an unexpected value?) which doesn't
> 
> Agreed that check indeed makes little sense. But "most probably for the
> case where the reg prop has an unexpected value" does not hold: an

   I tried to guess what the check in question was actually intended for
(despite making a little sense as it is now)...

> out-of-range reg value is already rejected by the "id >= pmu->info-
>>num_domains" check above, and num_domains equals

   I noticed. :-)

> ARRAY_SIZE(domain_info) for every SoC, so there are no holes in the
> table that the new check could catch with the current data. AFAICT, this

   Oh, there are holes! :-)
   If you look at (and behind) the indexed initializers of *_pm_domains[],
you'll see that the indexes don't always start at 0, and so the arrays are
actually sparse...

> patch does not change any runtime behaviour; it only turns dead code
> into a defensive check on the match-data tables.

   I hope you see now that this defensive check makes a bit more sense...

>> make much sense as the variable pd_info will be NULL iff pmu->info->
>> domain_info is NULL and the variable id is 0.  What does make sense
>> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
>> seems to follow from the code) can't both be 0 for a valid domain...
> 
> That means there is no bug being fixed here, should we drop the fixes tag?

   I'd like to keep it (but that's up to the maintainers, of course)...

>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>> static analysis tool.
>>
>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[...]

MBR, Sergey

