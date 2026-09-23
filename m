Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65E52CCEA
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195890; cv=none; b=ZE7uMpKtPR8e0S3C55Y4JUVLfYV6ySpHsJQdpKK2q0790wd5yUeXx+eMNoHXdIhJhUGaSLXoqG8CdDoaw+gwW8wgXisOFMxWQWWkIIQIjhyEeow7u2FCdttzZljrMmD6WmBkKmEuhPH0ePvQ370bbuUw6Y8dIP4iB6B+zs0rW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195890; c=relaxed/simple;
	bh=1izgqRgDgf8F4DJdotcB+sXd9AMgBsYaT/oS7TyvQ7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HhGT8U0HE0PhQPHSqAuup6kyWmK53/+r72KBHIO6hZe1Ug5FNlRLNjAT77Vv1uO88U/uytTiSY0bo5rPLVD4YKNo3AEtUTw6TFJ68lDA0HsTiz/yM8/SLJXZ18beecpwtuWFzWn3ccVYVF6jPns0GNw7w3dkBd1F9t4QkadNHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.46.39) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 23 Sep
 2026 23:38:02 +0300
Message-ID: <d07cb609-ca44-46aa-bd56-2554846399f6@auroraos.dev>
Date: Wed, 23 Sep 2026 23:38:02 +0300
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
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <CAPx+jO-Ph038WJQ4gMH93XzoMC09+meht=yT9JQBAnTD6HzGEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/23/26 3:14 PM, Ulf Hansson wrote:

[...]

>> In rockchip_pm_add_one_domain(), there's the check (most probably for
>> the case where the "reg" prop has an unexpected value?) which doesn't
>> make much sense as the variable pd_info will be NULL iff pmu->info->
>> domain_info is NULL and the variable id is 0.  What does make sense
>> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
>> seems to follow from the code) can't both be 0 for a valid domain...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>> static analysis tool.
>>
>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> Applied for next, but without the fixes tag, thanks!
> 
> Note, that I am dropping the fixes tag because if there was a real
> problem, we would require yet another fix on top to get the
> corresponding domain declaration to be correct. Yet, the patch is
> useful as is!

   I'm not sure I understand you. The patch should hopefully be
enough to detect the undefined entries (implicitly init'ed with
all 0s). What fix for the domain definitions do you have in mind,
turning the arrays into lookup tables by adding a domain ID as a
field to *struct* rockchip_domain_info?

> Kind regards
> Uffe
MBR, Sergey

