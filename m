Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C0221F39
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782072845; cv=none; b=LAiJBfXjd1k7Fa1dBUfmdRDDy54kJF2BOio3n0StnToN8yiqG7CAj6/vinqauNHX5SDheO6swl7xuqOIQZu4bz2C6z1RGKpfB/lF7wdE66zhcUAqLYHcEbg7wWgx6BPFwsWshGf5oZIakh5nZedMDPfAq1dSg7UCODbtp9OlqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782072845; c=relaxed/simple;
	bh=OT2XCXsdFAq0T4OufUOoAFe8FWVvU0eTGh8IZ9Eq6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGPucbiVR4EWPcUoUmWkWGQg9G3IhW7lP6aWWN4djWLVWN5CGFwFrcgGXmNouZyQ75Yn2oBee6UMgVLwrq0bsFT0NEFLuINWuhd23/9mjBsCE1FaOxbO/QgaFHK2KCXB1hCAofLlV3kiiz9WYHH5oDt2MDifaTz1Ak5W/QOQLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JEM6hpcU; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JEM6hpcU"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-59d7db12342so1131888e0c.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 13:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782072843; x=1782677643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+y8xiAhzmw08ETgEfxX8TrGytWnU7QehNrLVCufvbM=;
        b=NCprViEPv4F8T6f5WK+yiNeXzHQZomBlKPFSP9OICsFkGoMsrrfDu48kkBLyyqFKa6
         BwABqdM/zKj+QjogiRXq5ltT9witoW+124G/CyWGoSxK5L6/Pl56uO8jUzkxXAsF1nl1
         S8wvJ3hYsV89WmxwYA7BZpySeLdzxW1gGzTNOKj/Kzgy3qIc9StgWH8QaVdHVvkDGPeN
         UOPZ2DQ/VkwbsNCQlrtzrLZgBvnMiUuGic9NBHNSu8yHZZj2I89/lzJUiJxg6GZxRTyu
         JEXNJih4JEkR9r3d65i7zKxUTfM8Jfev0RUZ4l7MmBnDuplgDUNklrSarqIe9JG4wVEt
         I3xQ==
X-Gm-Message-State: AOJu0YxrAHPb4R/tTWIUAcNOXqmVkU3emwl+YJ6kJQiTDJ/QgfWXlsAB
	Hew32MTF9mGFUmarQXxz5NIa1lShpBaw0fhioai3qT1WXP9NfiuTChP22JnC4wRsyTjYRlCCINL
	8TJb3XPHTU/TRAemXbHP9a8F8tdl5PuE1TdzjkXfNKYFeGCQRItkLAjlTuunhGZJQO1X8b8oJNt
	j4O4VpeGz/ARTIT9pGO/WM9p49RwOE++gni2LTMIdHhttsUoLLPsxb6sVWCj6RQkzF6urJ0tgR0
	S8YMAZXJVV3Up82QDh9XQ==
X-Gm-Gg: AfdE7cnQrRf81H08BdSJyPYkAeN/YXwjneVO+RUL9OpNBg2hI/6RLe9atz82PJ2g4Ui
	/snhT0SrzuEkhyoEeBuJf9hVB+ZpieEU1/5w9Qq+nzvNLgsnSBxAyr48Lt/Hm3PhYEPyzht0VOD
	lNENy7NZlfS+q4aHhLBz+U4Vah2DKr2FrVvGw+yJ/rbVVGAopF0d6CmQv5y9q55jK28d5u5VeVL
	Zyaaitavs5O3NuSrIVsVAhYxb3ST3B1b5b6UcL9WfiU61SI7+P+anGL1bu1Lxx8Zgm82z8h7B2+
	QqbQN2XKbPv/ZhIt6mPDFk5nh5wcX3gMQe7+SGLfFaX1UFHts4Cus9Pvk5nsXP2132FB9gaOgon
	PISEHHkgcxbP22yzybLHri6xOviC2BBZPMh2RT7MBJmyqzK8R/7/J677l1ozzyXuLcqjNGtaStB
	VtqjrkhAhayjh+5kLs6Qm7MEXUSVAcOpu4QjKsXnKrx5Lb3Di4QH5exw==
X-Received: by 2002:a05:6102:3581:b0:631:28c1:154c with SMTP id ada2fe7eead31-72a01ec0b34mr8149832137.9.1782072843313;
        Sun, 21 Jun 2026 13:14:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72ba47028c3sm473994137.29.2026.06.21.13.14.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 13:14:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-469218e618dso89134f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782072841; x=1782677641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+y8xiAhzmw08ETgEfxX8TrGytWnU7QehNrLVCufvbM=;
        b=JEM6hpcUheYiplnv8OlcjZl7PzXwNeHUz8aD3HX4FV73zJzx/QeFxbt8Zd7kP4o/zQ
         XqGNSJH17mbSUoluRkBTppuM8Yfkx3lUq34n2SZFFfUWPD2onSkCB/VNUVMf0SJ1PKV6
         5ewhKp0h6euXSAEZqjgePtqula909AHL863Ok=
X-Received: by 2002:a05:6000:2881:b0:460:3a90:b2b6 with SMTP id ffacd0b85a97d-46660c10621mr12183887f8f.11.1782072841289;
        Sun, 21 Jun 2026 13:14:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2881:b0:460:3a90:b2b6 with SMTP id ffacd0b85a97d-46660c10621mr12183847f8f.11.1782072840759;
        Sun, 21 Jun 2026 13:14:00 -0700 (PDT)
Received: from [10.225.97.41] (aerospot-mask5-183-2-inet.hub-one.net. [149.232.183.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5413sm20505403f8f.11.2026.06.21.13.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 13:14:00 -0700 (PDT)
Message-ID: <2f37b826-b760-4735-bc33-e1f167729d52@broadcom.com>
Date: Sun, 21 Jun 2026 22:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to
 100us
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Stefan Wahren <wahrenst@gmx.net>, Ulf Hansson <ulfh@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260530204636.1115120-1-mcanal@igalia.com>
 <deecc409-02c1-4393-bc06-1852fc06e4d1@gmx.net>
 <eba66b9e-520e-4afc-8973-d54b22919d2c@igalia.com>
 <4af63689-e08c-406e-9ec3-f56dcbfb6f91@igalia.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <4af63689-e08c-406e-9ec3-f56dcbfb6f91@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 6/19/2026 2:57 PM, Maíra Canal wrote:
> Hi,
> 
> On 31/05/26 09:18, Maíra Canal wrote:
>> Hi Stefan,
>>
>> On 31/05/26 07:41, Stefan Wahren wrote:
>>> Hi Maíra,
>>>
>>> Am 30.05.26 um 22:46 schrieb Maíra Canal:
>>>> Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB 
>>>> control
>>>> timeout") raised the ASB handshake polling budget from 1us to 5us.
>>>> Surveying the pmdomain subsystem, 5us is still one of the smallest 
>>>> polling
>>>> budgets by a wide margin. Comparable handshakes in other drivers use:
>>>>
>>>>    - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
>>>>    - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
>>>>    - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
>>>>    - 1s    : mediatek mtk-pm-domains, mtk-scpsys
>>>>
>>>> Raise the BCM2835 timeout to 100us, matching analogous drivers. 
>>>> 100us is
>>>> still negligible relative to a power-domain transition and gives the 
>>>> V3D
>>>> master ASB substantially more headroom to drain under heavy workloads,
>>>> assuring us that the timeout is enough for any scenario.
>>> tbh I'm not convinced by this explanation. Starting with a timeout 
>>> comparison across different pmdomain driver looks strange to me.
>>>
>>> My expectation that the reason for such a patch is that there is some 
>>> kind of scenario to trigger unexpected timeouts.
>>> If this is the case, please provide more information about the 
>>> scenario (specific platform, scenario, link to the bug report).
>>
>> The context: I was debugging this issue [1] and initially I had the
>> intuition that it could be related to a timeout in the ASB polling loop.
>> As I don't have access to the BCM2835 SoC datasheet (the public one
>> doesn't have PM information), I started to check other driver's
>> handshake timeout to see if ours was comparable to similar drivers. As
>> you can see, our timeout is much smaller.
>>
>> In the end, issue [1] wasn't related to the pmdomain driver, so I don't
>> have a specific scenario to trigger this issue. Even though, I sent this
>> patch considering the comparison to other drivers with the goal to be
>> conservative and use a larger timeout that could accommodate an extreme
>> scenario. However, if you believe it's unreasonable, I'm okay dropping
>> this patch.
>>
>> Ideally, it would be great to have information from Broadcom on what's
>> the largest possible time required to perform a power transition. Maybe
>> Florian could help us with that?
>>
> 
> Gentle ping, any ideas about this?

I think it's reasonable in the sense that if there is a lot of traffic 
posted on the AXI asynchronous bridge it will take longer for the 
acknowledgement to come, I asked the designers whether 100us is 
reasonable or not and will get back to you as soon as I get an answer.
-- 
Florian

