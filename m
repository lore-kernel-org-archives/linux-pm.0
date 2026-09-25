Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0B4E2F15
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365135; cv=none; b=ak+Mt6SlC9LdruI4CWA8zvVTQfEebLf3+gy4XLHJ43Huea7ooIDYDOE/rMfZsXujumDwT6QPOGcNBQ9eNP81AguIN9T6PdMYDLyqhh7OKmn5AXlj3j1JzKuJXiwIW2YmD4Y09S5jq5uxJgfE5/mQ5nKMgS5jYeay3EmHsIWhPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365135; c=relaxed/simple;
	bh=NtuTSdMxZQgjZD6OH7gqvHSJR034KGquI+zsl/blznU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PhGer6fgNW/tCrMcOqsq6DzBjRElABc6m/jN4kv/3Iitz1aWeq2wqpGpuFC5IKxujmpNgFeTZmYhi2jku/WEIhSh6jvrT1sQyeeImX3VyKHQJ0jdeFi6hOKYWgMqMFXlUs/OMZKcp7stczwikKnokMpPNC5p4V2RBFktPrEYyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.45.169) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 25 Sep
 2026 22:38:46 +0300
Message-ID: <66a4cfe1-286c-4d63-9285-2445c48739ab@auroraos.dev>
Date: Fri, 25 Sep 2026 22:38:46 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in
 rockchip_pm_add_one_domain()
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	<linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>, Caesar Wang
	<wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
 <CAPx+jO-Ph038WJQ4gMH93XzoMC09+meht=yT9JQBAnTD6HzGEg@mail.gmail.com>
 <eae7ec74-5b90-4258-9576-159c700bd8f4@auroraos.dev>
Content-Language: en-US
In-Reply-To: <eae7ec74-5b90-4258-9576-159c700bd8f4@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/23/26 11:44 PM, Sergey Shtylyov wrote:
[...]

>>> In rockchip_pm_add_one_domain(), there's the check (most probably for
>>> the case where the "reg" prop has an unexpected value?) which doesn't

   By "unexpected value" I meant a domain that isn't controlled by this
driver and so have no explicit initializer in *_pm_domains[]. Looks like
for such domain #s rockchip_pm_add_one_domain() should fail with -EINVAL.

>>> make much sense as the variable pd_info will be NULL iff pmu->info->
>>> domain_info is NULL and the variable id is 0.  What does make sense
>>> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
>>> seems to follow from the code) can't both be 0 for a valid domain...

   For the domains that have no matching initializer these fields should
be both 0. I had chosen checking these 2 fields instead of pd_info->name
as I intended this patch as a fix, easily backportable to the LTS kernels.

>>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>>> static analysis tool.
>>>
>>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>>
>> Applied for next, but without the fixes tag, thanks!
>>
>> Note, that I am dropping the fixes tag because if there was a real
>> problem, we would require yet another fix on top to get the

   If a defective DT is considered an issue then there's a problem. :-)

>> corresponding domain declaration to be correct. Yet, the patch is
>> useful as is!

   Like I've already told, my aim was not detecting the bad declarations,
just bad DTs. I probably just wasn't elaborate/assertive enough...
>    I was thinking of doing a more elaborate description but if you
> considered it good enough, OK... :-)

   So what are you going to do with this, leave things as they are: the
patch merged to the next branch (in its current form) and not merged to
fixes? Perhaps a revert or an incremental patch?

>> Kind regards
>> Uffe
MBR, Sergey
