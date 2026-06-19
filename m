Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535217745
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877475; cv=none; b=cB2lHJuauujThd+lzcnMghK64cYpkDI6u2ldtBjt5bonAkb1Y/sN2S7gN9YJnbxhD1zyJo7XgZAbssgPhQkNh9F40NHavbaYANbL9fxPAYP+4ixHkamaN6HaLxSGjGRAYgDW3e6WbA2gGRH4lDNav/e3VOF1+rfumOVqTf/8erA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877475; c=relaxed/simple;
	bh=ZCIIne34ATTnxh3IYFHMgw2KmcSyxwdeBk7QsYWuOzE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TvVaSWGSG8c8dQ4vgyIKEoP+e6KWGYc8hpPKfUPUuCtPj+dHRNoMSvje6LOpY1jByrVaLHZ5dKddCP+HJRXOZbinrlaXzy/fg44W1BJbTFfr/Dvmb6OPZSjszK8FvZ3aEua6Z/uMBNY8gQPBSoDvrW3nJgl/+YoqH6X78P7QxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AUKaAQrX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AUKaAQrX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YDBGFFmAFpsTzU7UDyTvMSWoP6bzsNKVuDtNoeT8GeY=; b=AUKaAQrX4mO9lunC7CbM4MvPR3
	YZrHHtT9jGBUIHQuctZqJ6ZNkCAXtNdZbinF7VNl9MuRqVGT6oVFhg67xWwkyDI+mfh2AI1B431TR
	qAcLn6PBoZp9jTdvUsNJ4Zm+6qrE9uPR7hj+4YKMjJb3CRiJEx5XkiWU4irfE8KDaFGNV96fZeprR
	kEfWd8V3i2Gsud25LC5F9kZSXgRF4+rB2TSSzACvHPvYMZDl26TNdsX8gmdXY4UWwgZ1FoDTNARG0
	oilb2dWUroKoT+l/ee8bP526hyaENBEd/8FkYr3/i4xp06l61VBU72TVScfVIz5lqNKLKkX6T58/d
	BHI6/OiA==;
Received: from [77.26.202.28] (helo=[10.0.20.253])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1waZj6-002XhJ-Nk; Fri, 19 Jun 2026 15:57:44 +0200
Message-ID: <4af63689-e08c-406e-9ec3-f56dcbfb6f91@igalia.com>
Date: Fri, 19 Jun 2026 15:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to
 100us
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
To: Stefan Wahren <wahrenst@gmx.net>, Ulf Hansson <ulfh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260530204636.1115120-1-mcanal@igalia.com>
 <deecc409-02c1-4393-bc06-1852fc06e4d1@gmx.net>
 <eba66b9e-520e-4afc-8973-d54b22919d2c@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <eba66b9e-520e-4afc-8973-d54b22919d2c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 31/05/26 09:18, Maíra Canal wrote:
> Hi Stefan,
> 
> On 31/05/26 07:41, Stefan Wahren wrote:
>> Hi Maíra,
>>
>> Am 30.05.26 um 22:46 schrieb Maíra Canal:
>>> Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB control
>>> timeout") raised the ASB handshake polling budget from 1us to 5us.
>>> Surveying the pmdomain subsystem, 5us is still one of the smallest 
>>> polling
>>> budgets by a wide margin. Comparable handshakes in other drivers use:
>>>
>>>    - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
>>>    - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
>>>    - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
>>>    - 1s    : mediatek mtk-pm-domains, mtk-scpsys
>>>
>>> Raise the BCM2835 timeout to 100us, matching analogous drivers. 100us is
>>> still negligible relative to a power-domain transition and gives the V3D
>>> master ASB substantially more headroom to drain under heavy workloads,
>>> assuring us that the timeout is enough for any scenario.
>> tbh I'm not convinced by this explanation. Starting with a timeout 
>> comparison across different pmdomain driver looks strange to me.
>>
>> My expectation that the reason for such a patch is that there is some 
>> kind of scenario to trigger unexpected timeouts.
>> If this is the case, please provide more information about the 
>> scenario (specific platform, scenario, link to the bug report).
> 
> The context: I was debugging this issue [1] and initially I had the
> intuition that it could be related to a timeout in the ASB polling loop.
> As I don't have access to the BCM2835 SoC datasheet (the public one
> doesn't have PM information), I started to check other driver's
> handshake timeout to see if ours was comparable to similar drivers. As
> you can see, our timeout is much smaller.
> 
> In the end, issue [1] wasn't related to the pmdomain driver, so I don't
> have a specific scenario to trigger this issue. Even though, I sent this
> patch considering the comparison to other drivers with the goal to be
> conservative and use a larger timeout that could accommodate an extreme
> scenario. However, if you believe it's unreasonable, I'm okay dropping
> this patch.
> 
> Ideally, it would be great to have information from Broadcom on what's
> the largest possible time required to perform a power transition. Maybe
> Florian could help us with that?
> 

Gentle ping, any ideas about this?

Best regards,
- Maíra

> [1] https://lore.kernel.org/dri-devel/20260530-v3d-fix-rpi4-freezes- 
> v1-0-c2c8307da6ce@igalia.com/T/
> 
>>
>> I'm not against the change in general, but please start your commit 
>> message with the problem and not with the solution.
>>
>> A related question, does it make sense to add an error message here 
>> for the timeout case just like in the rest of the driver?
> 
> Before commit 18605b1b936b, I was getting a "Failed to disable ASB
> master for v3d" error message, so I believe the error message already
> exists where the function is called.
> 
> Thanks for your feedback!
> 
> Best regards,
> - Maíra
> 
>>
>> Best regards
>>
>>>
>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>> ---
>>>   drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/ 
>>> bcm/bcm2835-power.c
>>> index b76d74e3849b..d507bb675e29 100644
>>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>>> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct 
>>> bcm2835_power *power, u32 reg, bool enable
>>>       writel(PM_PASSWORD | val, base + reg);
>>>       if (readl_poll_timeout_atomic(base + reg, val,
>>> -                      !!(val & ASB_ACK) != enable, 0, 5))
>>> +                      !!(val & ASB_ACK) != enable, 0, 100))
>>>           return -ETIMEDOUT;
>>>       return 0;
>>
> 

