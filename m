Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391356;
	b=oSHoYF7VMH70WBHz9og8H4p8jG5mNuNx+6Y6Yzr2oXUMhVBVbbEYBeCQsrTlG+Z9XS9n
	 EBPG4Ge9MequIXklbit9M3UgHfSsRVbv2jMQWvWAMmbVXoaFbr8rVaIlonfNx1h4BVtkt
	 38vwehjT+qGNtHC/KmzfFkMCuhY8gPbwnBM3g+3c42uHE2zhtwTscNtjAxBDJWqcw2urb
	 WTdGtmMxzKwUJvsAYJBHyrMdPOH+upzYvNP+wYiNhbQVdxPsqzdHpt0RbAeMy3tg/AxOq
	 oar7xo/p20kmInVCcPV7OWa+97/DDF6lxomz9jLBui8wQ46L3ee2TGEWONxpL2BnU+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Uf8NjTATLaSx0T6xJbOfk8n0GZJkRQt+2l2OmlV7/s=;
	b=Hv7l3wsoYiuFHe2jUUi/2odYMCRlXnstNF4bzoHKd3ewzBJYL+IDrZmxTVn7RpcGssrw
	 9th5oaZBHMemNLcf/M/yP9k2w7MRk5n5nmqJ9XBXHfminNORFvQM47SClgBBOXcKmFgZo
	 79jQVW+WRzt7mFjaQvEo6BzdWos7txkS84vB1QiJ0PD7LZIULpwBab7beYCYH5F1V52S2
	 VB5sS5sI23OUzDF7lfWazS+3PCydjA6cpQV8cVZso1UzGcnfVuxBzLkSqBlktvaJPdE4V
	 3mPT3LIc/gWc3im+VRWCwSQfOL/gj91FQZFzE+b0tsHHlPk86luyJO0VuDVhtCtuThg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h0U2KI9H;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083F3606A339
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083F3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h0U2KI9H
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492690dd5daso2318710f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794391354; x=1794996154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Uf8NjTATLaSx0T6xJbOfk8n0GZJkRQt+2l2OmlV7/s=;
        b=h0U2KI9Ho3jaYsUkDK5Fn9tyFwbypvCXXUNlfq5rS+pYSn4ZWsgiwyV/pdkqvTjDA+
         z6ZKvdaYbjQ17EYoNNC+EFELKj1jdE59psVlK6fnVag4qu+cTVc6XqNnmtFgh7Vy5Z7X
         QnwyOkRLsdL4Jc1XSO2j/x3bC7y820cojw8HTyVPpGZTFHQFG3cIdL3eKPfWolG22ZTT
         uFnol787+UL2MgjSwk6ipu8tWjxFiAh7ey2AtVznp1Q6dsl1U8qFxm1aLzHWt8Qi7DVt
         MuAgEQ+Md/6RetRneZV8tKuZd+0Ywx02jhUTmncLH4XCZC2HC1En7KBC5mEhZLsjKlEI
         Unjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391354; x=1794996154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Uf8NjTATLaSx0T6xJbOfk8n0GZJkRQt+2l2OmlV7/s=;
        b=eMPQ5oTk+exb3jb0njZP6rMnzFOCjGotwbx1bHj7mC29vIDD0NuQsfYam6n1T9fIVU
         NKSf5T2kRna+2z0qb4dbpckRRvkUiMrKuLzPjHK9YN3mlg6I3RmfIANcXnF2CTMVGonQ
         Sk5MBEg/RS0nRPGoqRCLiMiDQPGJ3JvGGY2zBbY49t2H3livzFJd4o+w9oIA/FL48E+8
         df/v/WCVnR3nCiZA/A3rZgbDSvnf/Hec/QXQr/Ab4RWgjhcI98wCKcGdvYIMlRtx/FRI
         Z4rYjg0YrKu9rVPvRZPnVzoztYF1w50lV6JDmqEREVl0c/3cr4XddHM2DuwtkkBE8Wlx
         TaMg==
X-Forwarded-Encrypted: i=1; AL+hErHK5TCB44wZvguiFyiZWDIuWwKlduXsGv1CWPGW7UImGEMrZEcVV/kwv+eXkTVkWEWxkQ/uHmLhNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+PEAmXQ491xvQovfEvLPeXKZ1L3pyO8y8dPEkTrLyZ2fs0HG1y
	rIW+wBYQMiwraALQ8rCv/VVlmX2u6RwB4kjsiRPEbTPdBUg06N/MlY7K60ubtu0q1ShRvTWIHzL
	khO6C
X-Gm-Gg: AYBFou332WK5pOle+m23HCvQbkY6XH9GOYO4jmN3TlUJE2BfZm5/otQMLVfnI3qPJWi
	5coGoJj8RCPnJXxbd4gmky6MK2OzTqRDj/8mOvhOagyOMKpFbKemCcP2+pk4hVT4qFGrKw1AFXY
	dCDyd8lHl7Jxhnl+yD4RL+QGErmk6SUThwx3oXaejY/l1zvLBF9b1a33MYo4MeYWa1kdu0uezHP
	mK6EFZU3eANqaTGcyzH2J33io1pj4qv9qZ6qGwnJ0DBqyUZFdue3t1mMwpmSK9SD0kX67Liv9p1
	WoymBee8gFvvKmPVJmnkhezTM3ls8nZnrCDaPeH4YfE2uUOC6264QEtWACPeIvVuq8HLS9NG3b4
	i9p73RdwvDAMCVbYRq06Q/vC/j0qtVae96TUtf/jrkBeU7BJSINJkPc3ZOinxV/s5qAch29YQN4
	/INJY+CsaSrLIPhXgvBf2xQiVEO6AvmQniCIz9il4gD5BYqzkWL+WiXaIXusBDgeDoZCg5n/Fqj
	yND+9ojFb9/LWwedi1D710x3t6bVCX3MjhwzwDpdFpeQAbO8YkHdsAIzK6dwJgxB405xqE/6JOG
	YmWcC30pwVxDZkrfx96lZlEoALzuBUz9MqhDz9ilFWixkAbGr9nNLUxyarGdGA==
X-Received: by 2002:a5d:64e3:0:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-499c903d741mr3207711f8f.23.1794391354282;
        Wed, 11 Nov 2026 02:02:34 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm4941304f8f.2.2026.11.11.02.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:02:33 -0800 (PST)
Message-ID: <e7621060-bf25-4677-bfaf-2549fc5e6ea1@linaro.org>
Date: Wed, 11 Nov 2026 12:02:31 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Rename platform driver to "exynos-acpm-tmu"
To: Alexey Klimov <alexey.klimov@linaro.org>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org>
 <179389375857.1009794.283716939057872036.tip-bot2@tip-bot2>
 <DMRYQFZGG5ZI.2T97YA5MCL74Y@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DMRYQFZGG5ZI.2T97YA5MCL74Y@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 2:42 AM, Alexey Klimov wrote:
> On Thu Nov 5, 2026 at 3:49 PM GMT, thermal-bot for Tudor Ambarus wrote:
>> The following commit has been merged into the thermal/linux-next branch of thermal:
>>
>> Commit-ID:     ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
>> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
>> Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
>> AuthorDate:    Mon, 26 Oct 2026 16:01:28 
>> Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
>> CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00
>>
>> thermal/drivers/samsung: acpm-tmu: Rename platform driver to "exynos-acpm-tmu"
> 
> Also, the fix for this problem was sent here earlier:
> https://lore.kernel.org/linux-samsung-soc/20261020-acpm-thermal-drv-name-fix-v1-1-71f72280583b@linaro.org/
> 
> Why taking this one and ignoring the fix that was sent earlier -- this
> should be at least explained.

I guess it slipped through the cracks, as it did for me.
> 
>> Rename the platform driver from "gs-tmu" to "exynos-acpm-tmu" to reflect
>> that the ACPM TMU architecture is shared across Samsung Exynos SoCs
>> (such as GS101, AutoV920, and Exynos850) rather than being specific to
>> GS101, matching "exynos-acpm-protocol" in drivers/firmware/samsung/.
>>
>> Suggested-by: Alexey Klimov <alexey.klimov@linaro.org>
> 
> I don't recall suggesting this. Reporting -- yes, but not renaming to
> "exynos-acpm-tmu".

my apologies, it wasn't intended. If you have a strong opinion on the
tag type, I guess Daniel can drop it.

> 
> This was reported months ago and was never fixed in the updated
> series for acpm-tmu.c.
> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
>> Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org
>> ---
>>  drivers/thermal/samsung/acpm-tmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
>> index 42b338d..2324efc 100644
>> --- a/drivers/thermal/samsung/acpm-tmu.c
>> +++ b/drivers/thermal/samsung/acpm-tmu.c
>> @@ -597,7 +597,7 @@ static const struct dev_pm_ops acpm_tmu_pm_ops = {
>>  
>>  static struct platform_driver acpm_tmu_driver = {
>>  	.driver = {
>> -		.name   = "gs-tmu",
>> +		.name   = "exynos-acpm-tmu",
> 
> It is minor but it potentially clashes with exynos-acpm-tmu firmware

There's no driver name for the firmware tmu commands helpers but I see
your point.

> file name. All other names in file acpm-tmu.c are "acpm-tmu".

I think "exynos-acpm-tmu" is fine, it aligns with "exynos-acpm-protocol"
from drivers/firmware/samsung/exynos-acpm.c. I guess you may rename
"acpm-clocks" (drivers/clk/samsung/clk-acpm.c) to "exynos-acpm-clocks",
but I wouldn't bother too much. If you have a strong opinion on
"acpm-tmu" send a patch on top please.

Cheers,
ta
