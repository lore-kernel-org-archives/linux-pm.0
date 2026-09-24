Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28346490C13
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281271; cv=none; b=CosAVQQjl3Nv5uasycpgRrOXlLdy28PwaBGMSjhvzHjv+KF56FeoXlHn64S4UUnLGFvUHzNe8zFpkW6W5DgOUqiBFw3mcqVPdmutvEzXwDumHIIi/KbCQy4eAs0KQD9ucoOY37X4UcX0Az97QZxe8L5uoSLqs6mdRTaISuqHRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281271; c=relaxed/simple;
	bh=vM46yV71miMXzCUwlQPdozDUkRRNjwP8LSL2vvorqZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VeWtGrZoVhywmuoMIA/9003gxsTtACx1YARY/yzkJLkm/Zw4NUDslCb1oIm3z0qC+PAtfx9SCB2EjtJfJL/GpOGBtjdSD0YE4hR9S0033RLDSC+VLP8amdyxrJGlM9YDDWg09qY2sEmkFsEbIUBn7DWheDuOaw/wqRaC8uIdi9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.17.141) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 24 Sep
 2026 23:20:57 +0300
Message-ID: <dda8d4cb-1c3e-4f6e-8d20-14e453effda2@auroraos.dev>
Date: Thu, 24 Sep 2026 23:20:57 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in
 rockchip_pm_add_one_domain()
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	<linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>, Caesar Wang
	<wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
 <CAPx+jO-Ph038WJQ4gMH93XzoMC09+meht=yT9JQBAnTD6HzGEg@mail.gmail.com>
 <d07cb609-ca44-46aa-bd56-2554846399f6@auroraos.dev>
 <CAPx+jO-c_w55jO9i_Db459Ya+9yV3nT3akQcaPxr0qb7TqSejQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <CAPx+jO-c_w55jO9i_Db459Ya+9yV3nT3akQcaPxr0qb7TqSejQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/24/26 11:48 AM, Ulf Hansson wrote:

[...]

>>>> In rockchip_pm_add_one_domain(), there's the check (most probably for
>>>> the case where the "reg" prop has an unexpected value?) which doesn't
>>>> make much sense as the variable pd_info will be NULL iff pmu->info->
>>>> domain_info is NULL and the variable id is 0.  What does make sense
>>>> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
>>>> seems to follow from the code) can't both be 0 for a valid domain...
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>>>> static analysis tool.
>>>>
>>>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>>>
>>> Applied for next, but without the fixes tag, thanks!

   One detail I've just remembered about: if the patch won't be backported to
the stable kernels, it would be easier to just check rockchip_domain_info::name
for NULL instead of the {pwr,req}_mask fields checked by the patch; this field
seems to always be set for all domains the driver cares about, it just was added
in 5.14-rc1 (I think), see this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a69452e03564c5eaf99f729de398cd94ee90851

>>> Note, that I am dropping the fixes tag because if there was a real
>>> problem, we would require yet another fix on top to get the

   The problem can (probably) happen iff a device tree has a domain # in
the "reg" property that the driver doesn't care about -- in this case the
.{pwr,req}_mask fields (and .name as well) will both be 0 (since IIRC a
C compiler should set not explicitly initialized entried to 0). My patch
was intended for checking for the domain #s that the driver doesn't care
about (and so doesn't init in the *_pm_domains[] definitions, not for the
validity of the domains it does care about; try looking at at e.g.
include/dt-bindings/power/px30-power.h and you'll see that the "valid"
domains start at 5 (and the domain #s are not even contiguous as e.g.
PX30_PD_{CRYPTO,DDR} indices remain uninitialized)...

>>> corresponding domain declaration to be correct. Yet, the patch is
>>> useful as is!  >>>>    I'm not sure I understand you. The patch should hopefully be
>> enough to detect the undefined entries (implicitly init'ed with
>> all 0s). What fix for the domain definitions do you have in mind,
>> turning the arrays into lookup tables by adding a domain ID as a
>> field to *struct* rockchip_domain_info?
> 
> Apologize if I was vague, but you kind of point out what I just said.
> 
> The patch helps us to *detect* incorrect entries. If it turns out we
> find one, we need to fix that entry.

   No, the intent was not to detect the improperly initialized entries but
to verify the supplied DT is correct; I suppose this was the intention of
the original (bogus) check in rockchip_pm_add_one_domain()...

> Kind regards
> Uffe

MBR, Sergey

