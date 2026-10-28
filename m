Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.42.129.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186784;
	b=NqM+43uuiE3LVJBSK9ZhMgDIWNIM3yGMaYW8RIv4aII5ZUn79pXb4q8QvE6ydSr/pL2D
	 KrTdntA0aOpz7KqCChQuXQt1pH1lZ1nX3JBReA2cgYHiCV4FWPDNjD1/hOTNa3li8dDy1
	 zRCqMUYfGhbjiQWYxItRd0yQDw1l4yrhgk0s1HvZyM7J1LdhMJgEWCvb4CgTo8BiFJLTD
	 zXP6WVkmG5uNaOy33ZtJJNO7vVrzQxC4jqs5gntB50o3vXE8S1za6PkH2TjmwLCIzBZMp
	 7m3WucpcPZlzamjjtvhU+tONfNRLLUNqWcV8u6IoaLjr4GwEehTuRIrnxUuQI6QTebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186784;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K8hugQRBJFCRqRVR9TtuMv4qNp8j1eR3GJhYgLoZmRM=;
	b=y8P86I2dPk3S+WRWohlmpkCYltWvenC1uvvK3CSdlBfZOgxpAnIpROihXdi0Y16lOenD
	 6BUI0mPmLwxLX/PkTpsO0pTIW0u4jRXl+28rJb7cvVDzzVk0Imj1ZcJAgQbbYbV8Ea935
	 Cy1cYHtzLST8n5JQS+KfER/2NxH5VFUaErFAU0HkRpBsjU/IfTNDxAf41F+X5EX8AHWJx
	 ryulBQp+A9OKXOd+PHWW1MFKzLTCBVPU8gcDRR2QUaK6xBWsvxiO5nYYK+ExzVK0h8+Fb
	 2ua6FIJ624WCbKP/COwa5rK4CE8PFPQHNJ1DyE/M45VR4GEp56g6/EHwLymrV6M9F2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ixit.cz;
	spf=pass smtp.mailfrom=ixit.cz;
	dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=H5TKogQR;
	arc=none smtp.remote-ip=84.42.129.46
Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C97606A31D;
	Wed, 28 Oct 2026 11:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C97606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=H5TKogQR
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id AFD7853409F8;
	Wed, 28 Oct 2026 12:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1793186780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K8hugQRBJFCRqRVR9TtuMv4qNp8j1eR3GJhYgLoZmRM=;
	b=H5TKogQRjlf3dxbaISyp8kV1lyi5ZG9jIPOMGbL6HYGzWOpLO4EhJwXiCqCJ7z8T30/Iuq
	lr4rRonUxbMU2w1okoTP3SjZfuIqI67ng213rYUYVkyDVubMvOHTb9KuTDqn/6UPOi6SzA
	ibqL2t7FrFqixgO4yQvZlYmpIyoEDWg=
Message-ID: <80f088f1-a11d-4129-bf26-f8224c94b534@ixit.cz>
Date: Wed, 28 Oct 2026 12:26:19 +0100
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
Subject: Re: [PATCH v4 2/2] power: supply: qcom_smbx: add SMB5 support
To: Robin Snyders <robin@snyders.xyz>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>
References: <20260820-submit-qcom-smbx-send-v1-v4-0-818dabb2771e@snyders.xyz>
 <20260820-submit-qcom-smbx-send-v1-v4-2-818dabb2771e@snyders.xyz>
 <6251801f-3662-4ad4-8d55-710144462010@ixit.cz>
 <468873b2-d154-4793-93b1-82816a00e580@mail.infomaniak.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <468873b2-d154-4793-93b1-82816a00e580@mail.infomaniak.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 08:42, Robin Snyders wrote:
> On 27/10/2026 18:19, David Heidelberg wrote:
>> On 20/08/2026 12:03, Robin Snyders via B4 Relay wrote:
>>> +enum smb_generation {
>>> +	SMB2,
>>> +	SMB5,
>>> +};
>>> +
>>> +#define SMB_REG_OFFSET(smb) ((smb)->gen == SMB2 ? 0x600 : 0x100)
>>> +
>>
>> More and more as I look at it, this shouldn't be here, but within the device-tree as
>> charger@1000 {
>>      reg = <0x1000>, <0x1600>;  # SMB2, or
>>      reg = <0x1000>, <0x1100>;  # SMB5
>> };
>>
>> But see also:
>> https://lore.kernel.org/all/eodzuccugtdn42basgpczett4yatyirog4nxwe5rhg5xf46ibp@jzcjmje4aqc3/
>>
>> I'll try to do some basic separation so we know what bits belongs into which blog, keep you in CC.
> 
> Hi David,
> 
> Thanks for looking at this.

Hi Robin

btw. since I'm working on the type-c + vbus (which originally clankers put into 
smbx), I noticed that there is existing vbus driver which can be used.

This implies removing OTG (0x1100 block) from the smbx driver.

Thus series needs more testing (charge/otg/DP, etc.), I have it at

https://codeberg.org/sdm845/linux/commits/branch/b4/pmi8998-vbus

see the commit touching smbx, as you can omit changing this part, which going to 
be removed in favor 'qcom_usb_vbus-regulator.c' (there was small conflict with 
SMB5 due to defines renaming).

I'll keep the rest of proposed changes to be commented by maintainers/qcom folks :)

Thank you
David

> 
> Agreed. Describing the second register block explicitly in the charger's
> reg property (0x1600 on SMB2, 0x1100 on SMB5) is cleaner than deriving
> its base address from the hardware generation.
> 
> For v5, I plan to extend qcom,pmi8998-charger.yaml with a second reg
> entry and use that base for both the power-path status and the
> effective ICL status accesses, keeping their generation-specific
> register offsets.
> 
> I'd retain a driver fallback for existing PMI8998/PM660 DTBs that only
> have one reg entry. The binding could still require both entries for new
> SMB5 descriptions. If you or Sebastian prefer a different compatibility
> approach, I'm happy to adjust.
> 
> Given Dmitry's concern about shared charger/Type-C register ownership on
> SMB2 in the gen1 Type-C RFC, I'd like to coordinate v5 with your block
> split so that we don't introduce conflicting register descriptions.
> Please keep me in Cc.
> 
> For reference, I also audited the current v4 SMB5 accesses on PM8150B.
> They are confined to the charger core (0x10xx), the DCDC status
> registers (reads of 0x1108 and 0x110b), the USB input/BC1.2 registers
> (0x1340-0x1380) and the watchdog/AICL registers (0x1651-0x1661).
> 
> In particular, USBIN_TYPE_C_CFG at 0x1358 is part of the USB-input
> peripheral, not the dedicated Type-C port register at 0x1544. The
> current SMB5 accesses do not overlap with the dedicated Type-C port
> (0x1500) or PD PHY (0x1700) register accesses. The DCDC peripheral is
> also used by the VBUS regulator, so this is a register-level
> observation rather than a claim of exclusive peripheral ownership.
> 
> I'll update the public register-ownership note to reflect the exact v4
> access paths.
> 
> Thanks,
> Robin

