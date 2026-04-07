Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF972617
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540908; cv=none; b=pdK8G6N7YAWOSel6EaMuq1hQouSJuujpDiT3yEMsABSx0dRoKPessaREkuFZJszXMf2Ns/ryUmpLIeG6mhXRSaKq1yx32NBtsgATg6PTG8ADay/y8MHIHx5VjA4gnVC3JuQ2N6DYsrQJ4EyXKhVQ944EU1BTfnkma9pgAR+qxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540908; c=relaxed/simple;
	bh=sjhu8s/9BEyLmfTn3Gefm+TsPuDKvZMrkElzt+2EY1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c1QoLR6u5cRvYDAh5MgsYnk1OJQ9pplYMG0X683Rb45DgsY5I1kLI4AqLmEju8f3dPyMg88mRSEYfjyL9AAec2MoMG6ffPulfgEsr8bYADATUy8A+z8mbTp45uyr659yRAjsaQDj/y4M6E9p7lE8qdjNOLo52ZZODssGz09Mr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV2DlM7V; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV2DlM7V"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so5551450e87.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540905; x=1776145705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYD6o8pTb5SmWUUWjzRiT8q6m8i/9lJd0DY3W44VJyg=;
        b=BV2DlM7VOmRsP4lK5UaZVK8khaLCrLVo9rFMvfeDYnna3OU+LaHwhoZM+xWHbYfKY3
         W4xVfnL+esCLlpMV035tMtAERyFzd6A/6DgDKRPTpP+407hCmtpKsDaoNV4SZfau8AU0
         CYWSP5OtEGqkIc8hAX1nPYdN91kJWT/lOFvbl9Ca/t/gPVE8lG4gMFE3h77InP3YD0Oe
         B8TNo+CbN3beA7sqJluYOy8x/OOYnEYemt18vvuWwRhYFT2+K3xRGEYJRQmRHRwQGBON
         Tt3S8tCBIT4mLUbfFspnxAhqtmtM1tO55pRsCl1SuQ5ykVyBsAZ+zgK07e7XofclhAI+
         w5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540905; x=1776145705;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYD6o8pTb5SmWUUWjzRiT8q6m8i/9lJd0DY3W44VJyg=;
        b=CrA2bzmHF3Q27FjsUK36GOibMC539Rr6+8G09cGpsx80kSHyHzX5SDbReRIVhuar9Y
         JdiHcksKFVbKGo2h7yPty3cUtHRCF1bouECcfu2Sv17z/zAbAASHpkIUIGYh7Vwe8Z/g
         dot+y1RifAbQSwMd42tvmr+YT0mo5yoJDFXaRn2HaQwCqFNoEh9cWtkYjXwXQKJX0zYr
         nwrqFnbYkUsxKHgz74YFtqxqq34aZt+UnlXyIJgiY3vUdQEdkOiMIZbT1RkYf9dcBJ3D
         GSyf9kxH/jPNHzgZPMY6r8rlu94ZtF8EcPh5LU5FTq8+XBQZD098nEJnwcllnxbSnvR5
         iBKw==
X-Gm-Message-State: AOJu0Yz1aa0ZP+RctjUgJiPHcdiDJuN/0Vn0j+lpa9hDKd6P1/7zaW3w
	9LWUBT6WuIyJNuKhn2YNo1CY5czx+jqQtcVr65O0/B86uy6ErDqNc9f2
X-Gm-Gg: AeBDievv3gZ7VZDSc51QCcWOiJgJD/olSpsEQDfeqAVvkQPnCr8iUkmrigX80BxtcLk
	l6xbfpJnNmYrZGKx5q/zQjd1eOPPwRpTUbntR0tR0Hw3uVy0J89L0v2Nj/6oqKYynm7SLHqN3/R
	HaDBoND4jXO6FhIZhjQW6gdua8iw7iCOwQwzx9dVhJHDPtHESzmmHPfMQ+/Q6WmasZ5c0pFSJQY
	Vb0JbpNKbVfN0uBQ8onQ0kZKYFCB0NmBCBXDczUh3PaLMpjwKFHn0hXLumqGoiHjyz2QvyoYM02
	RWZMJQl9hnniJEPRlsU0qb49dlDWJi4UQLYmk4s71OZPERXrgECOKQ+u0qFE5ubiBYe+HdZzX7P
	++LBhQo1j5UGWA0jWFtAPcRirTDuDqiYlaga7X9bnqHLum7NdLjaQ60fa1iXzXFwu++UzLbcApE
	sFtDnjdMo7PfjxKPc2A0mkWr9iL/a28jYV/jGtTnHjmcXIQjYRxg/RPSeiq5fcjKNypY4e46UmY
	O1BJCsD
X-Received: by 2002:a05:6512:3c85:b0:5a2:a70a:a87 with SMTP id 2adb3069b0e04-5a33755cc62mr5629460e87.4.1775540904296;
        Mon, 06 Apr 2026 22:48:24 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccc9fasm3756778e87.63.2026.04.06.22.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 22:48:23 -0700 (PDT)
Message-ID: <50777d1c-f133-4402-bf89-055719651004@gmail.com>
Date: Tue, 7 Apr 2026 08:48:23 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add input current limit property
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
 <16340915-f63f-41f7-b68f-6208120d9c09@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <16340915-f63f-41f7-b68f-6208120d9c09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/04/2026 08:34, Matti Vaittinen wrote:
> On 02/04/2026 00:17, Andreas Kemnade wrote:

// snip

>> +    .ilim_stat = BD71828_REG_ILIM_STAT,
>>       .btemp_vth = BD71828_REG_VM_BTMP_U,
>>       .chg_state = BD71828_REG_CHG_STATE,
>>       .bat_temp = BD71828_REG_BAT_TEMP,
>> +    .dcin_set = BD71828_REG_DCIN_SET,
> 
> Hi Andreas / Sebastian,
> 
> Sorry for belated review (although, I don't think this did float on the 
> list quite THAT long...)
> 
> I believe this is the ILIM_STAT register in the data sheet, at address 
> 0x6d, right? (The bit field is named as: LIM_DCIN_STAT[5:0]). If so, 
> then I have a follow-up question in the setter...

// snip

>> +        return regmap_update_bits(pwr->regmap, pwr->regs->dcin_set,
>> +                      BD7182x_MASK_ILIM,
>> +                      val->intval / 50000 - 1);
> 
> The "burning question" I have is - how well this has been verified? I 
> ask because the data-sheet version which I read (rev 0p17, DS2 draft) 
> marks this register as a read-only. I know my data-sheet, targeting the 
> design-sample 2 of bd71828 (not bd71879) is ancient. It may be this is 
> an error in the data-sheet but I had to ask anyways...

Please, ignore this bit. I somehow misread the patch. It is the DCIN_SET 
which is used here, not the ILIM_STAT. Logic seems correct!

I would still prefer the linear-ranges, especially if other variants 
support this. But the logic seems correct. Sorry for the noise.

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
