Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629483911C9
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142203; cv=none; b=Y4wgfGmItktR/okSVFuQiqtXgU3qju3/BO5kTVfmaF7xGvQPc51J09PoU/qHZgUjQpt6XfZf/4zsHvRUcfYd4LPk9aNFC22D+J5EhlDgnncPJzxRBUMhXOBtHBpp9S462ew1HLVw/jXOSuR8QYt5rIIOKyvYU9E3/ICRusvtJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142203; c=relaxed/simple;
	bh=xI99615I0CTtUDBESuiSUBs+z7i6jN2i+CMwp4HJlUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIr0Lg3O3dMmcLtbzBgTBQC59fPkPYthJYSveCzLSUJdcfKb87r4oHgPqTkRD2We7LxHYIfdOg1d3Um036eA8AKzqh1e3oNvtZYmLc7vP4mp3cn0kw31krAQr71V6dRcX+Sv3Fc/3NtJ0q8B5fhZx/+NdBMiGwV6ondYHNY9X2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emDmkrPp; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emDmkrPp"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so33461495ad.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142202; x=1782747002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYUa0y2VQ6L5ucliJrlQD3LW1X+q2pOFWv7Ws428vpk=;
        b=mqdk25IQlwctIZZvUJjskqXDlnUEP3Pe4oIQ/1VakohcSsnkEsh2jWMKerXZoU36oR
         0zx1h0mqJWJz7Jju9kMZlUc9+sR57+sBiCT1ZZkK69yR3NeOOFfQPu/e4HqORlDXQuE5
         UtU5eWXvvVL6mvOYB6V/Hfn56ha/+xVoCTRgqk1GJKHIkZjDmcKMPJRSkfXqF/jQ1vaH
         tBHWD1i+cfhQ8E9GjGL7aXRfZwDnUUHxxUQ7Xbv4+uAstBVrsY8tjm5Xi6bFmkCXFtSl
         TGrgHAc9otyyBTMy7Y+2siejGaH6VRiw9lFWGDTN6SRqg+lc/ivoPMXR3rdf5PYz96OG
         i+6g==
X-Gm-Message-State: AOJu0Yy7ysowskoj3prxij1Wtmhkf/7t0TayYsMd2WjHms7SpveBTB7X
	1X+xGeX5tcsJKNuGqHr1SGPXJ9Er9BszsV/LZ0947myC2bYSXgWGcd0/7zS15XdELWX6BHxwUeZ
	dXdT/j0AFoomUVsdNbNGso1rZXyV6atduxlt+zbsBJiTUrnrG2dQ9CVi4WbxfCqHdIX3UqMRMfb
	MRPWOcx/VjKNKfuQMH8A78zVbMVctb690wXO3F3Ecpnu2yVPAMf9Knyk2ZIXOMjoh3srg1vFmwQ
	e3Uisig+S8dr43/ZP2ld7SJ
X-Gm-Gg: AfdE7cmynV914rpeGsFBjrjOxIE/cfUvuR38KfEPFDVp11/nI9GITwIGMBTfg5aCAB3
	Q1UlwsurPj/EafuVV6MnE15VWtV2yt+2DCelYj0to0fAxUyWNk8XSYtkUE3K0m+Qdk93ezQaTom
	S312rn8+aQhAfzeakbm293ok/wZGmcCQevRjnVRWdIw3e4LcqsNAl5VY2jaH2g3vyeh7IG1R7eB
	u7wAZJ9g5dhlvxNe7gAG35R+PFgj1bJ7WoHkGlKjcFJH9PtxDvOqLTF0U6gDlDLIjvkzKLa4Ezc
	ddnuGUta3uJkRehKyPEWyKke85SgSttrWr0f2/q2Ynchwthd6HKmeqxkmxOuXtGcMZndZyjfB9l
	A0XSqGXIjO5OtUAfipRbio7kCw7BORBUjIhDu7w1fi3YLPIls3ht3IBGzzQ9kKhsqdg8jVY6SaO
	Z7g+ZpQPOK/LmqyTA8JHwEExnzhmRKw+xcklsQoCkzBgl/x2m+eBw=
X-Received: by 2002:a17:903:390d:b0:2c6:b38b:e75d with SMTP id d9443c01a7336-2c725d38359mr165760905ad.20.1782142201532;
        Mon, 22 Jun 2026 08:30:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c7439b1304sm6324335ad.16.2026.06.22.08.30.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:30:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so4712204eec.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782142200; x=1782747000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYUa0y2VQ6L5ucliJrlQD3LW1X+q2pOFWv7Ws428vpk=;
        b=emDmkrPpU1CHpajfNrmcTRjAnZOmCXjpBVH+/g4LLNlTAr5Y9XrNjGQ4lRTxQJv6kt
         47dlsHnInJc9tRDPSLmEccSmnPy9tZsJEI5LVLD/mXgFfalXVQkzUiE4/z4H99epyZZa
         jhAHU7O0um72yb7DxT8vi+TGj7HE5/OrijXeU=
X-Received: by 2002:a05:7022:6890:b0:138:4023:8c1 with SMTP id a92af1059eb24-139a4eca6f2mr8433114c88.11.1782142199861;
        Mon, 22 Jun 2026 08:29:59 -0700 (PDT)
X-Received: by 2002:a05:7022:6890:b0:138:4023:8c1 with SMTP id a92af1059eb24-139a4eca6f2mr8433093c88.11.1782142199204;
        Mon, 22 Jun 2026 08:29:59 -0700 (PDT)
Received: from [10.178.4.71] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcb7aabsm9525774c88.5.2026.06.22.08.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:29:58 -0700 (PDT)
Message-ID: <dc06a108-342d-480f-849d-908b76fce2d3@broadcom.com>
Date: Mon, 22 Jun 2026 16:29:54 +0100
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
 Ulf Hansson <ulfh@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260530204636.1115120-1-mcanal@igalia.com>
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
In-Reply-To: <20260530204636.1115120-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 5/30/2026 9:46 PM, Maíra Canal wrote:
> Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB control
> timeout") raised the ASB handshake polling budget from 1us to 5us.
> Surveying the pmdomain subsystem, 5us is still one of the smallest polling
> budgets by a wide margin. Comparable handshakes in other drivers use:
> 
>    - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
>    - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
>    - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
>    - 1s    : mediatek mtk-pm-domains, mtk-scpsys
> 
> Raise the BCM2835 timeout to 100us, matching analogous drivers. 100us is
> still negligible relative to a power-domain transition and gives the V3D
> master ASB substantially more headroom to drain under heavy workloads,
> assuring us that the timeout is enough for any scenario.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

The response I got from our design team is that turning of the the 
"slave" should be immediate as it does not support multiple outstanding 
transactions, it's the "master" that might requiring bleeding out 
in-flight transactions and for which a longer timeout seems reasonable.
-- 
Florian

