Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594501;
	b=o3p2amPflvgPfjzJOroFARNIEre6ixKTRIONPaYte/c4xFZE8AvvspwvnXEsHCpOQwaQ
	 oC9ZjGbxCUAGrKcFX19GVejOgSZioqovRtE25+WsQyR5ZmmeZGjEq2CujEpbV8GijdjWC
	 q8bAjs4XerrCcqL0h/WiSHe0lJgf1rLAej1JrzVM7cX2tl1GfEzi9OvxFRqrnCDw3tX0O
	 b3Cq8m+LpW78gk0aOZYnxYuZ1AQUm2+ASmR2f1gbsNOxoVEItLcMeaCj8Z0K/FPC/Mvyv
	 K7cfCH61CR9WX6c49LTcES4eoqaFN1s/XitU/bT/+cXq7M92KGIfZwkn0HRf82w6G1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rc4aqCyzYBjWOigmv1O5fiE2Ptnz+1fYVaVELpdQ2fQ=;
	b=Axk0CMtGc1MzomQO1dIcdaiv4mhGkyUSc1rTj+cq9nlSBnsoyhRNVv5LrkfiX4rv1IJk
	 shFrafuewMD2RZWhJhwIrl6NwAHGaacVZTDV33AiqCWFGwrdlupArxnQM10b2An7cIQm2
	 xZzn2hnlMl4A+s2kuY4MUpFNb+xzfEyxwfVyb/PjeaaeaUBY47TrVFXUSCZ0/JoC+Vqjg
	 5Nzblkq++iLrQsUwXkPiVS5s/6BvrOYLdfHWMTUjylLbI0SW7X2d/9Dwv7jC6sEcJ2LOB
	 XGIvBCqG9XUvUIIVaKop1k/82SsZP0EbxViqFyLISknre10yVASIfdohzoFhzIvygug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P2gG8e8i;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C951606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C951606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P2gG8e8i
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so53520425e9.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795594495; x=1796199295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc4aqCyzYBjWOigmv1O5fiE2Ptnz+1fYVaVELpdQ2fQ=;
        b=P2gG8e8iMnSEtgDu8AYaKIyzjTUKC7CVofda8nfnwnngzWLiIL4yD7KdqqpBF3ipwF
         TZr2WGXJjSWQlfe/98yRvEYinjMCtUCLakBpm9CL8qF/WpkSw1uV2ndnFc+AMYTYAusl
         9fMtL8xGs4FLT+mFf9F83iJ7j5lNsuXCF3aUWN8lDdurs/1gc57UJ3Vfr2Gc1RYm2GBB
         CE/ebmAc+NHLFPBbsyx3UQAakCefnhz1hMH9FfCPlHF16hzxXpdRDjVTD7q4eXSqU5bL
         98qNPSmropSDF21V1dN7Ze4HG2AKrF8HiN/ySooWRrV9BvYjx6UWi9FVgveeLtdEfCjS
         rgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795594495; x=1796199295;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rc4aqCyzYBjWOigmv1O5fiE2Ptnz+1fYVaVELpdQ2fQ=;
        b=BUZE1PD5IXoYR8z8bEjAHzf5weR9n8dhKAw7lFhO2G937XVtmgSSzqZ0bD73fnoLLV
         Yj7/oykfkiSZnEVdmPv4WxzRAuDxw2jCBbyYe40n5yFihP5LohNg/dfw0tYHczuGUzBW
         XRkgGnGqFMZECKlKRtAHXVJJC6NXTEdYoEWZukQMdwTwgyZ7pAjTZeB8MUfijBy0kRMg
         6bMaxp4wwA+tMu6tqzWD+Yp8bK5WYO6P8go9i8cvcSeN1kh6M1I87NpxWScZYtGFrqMj
         epQv+umTLlNrv9yCCviBqg2g26Ae+vE6yIA/ci/VejimlDooHymZSQhZi06tnrz4oFau
         3Rkg==
X-Forwarded-Encrypted: i=1; AL+hErEcxT2JU+uOcMI/kwieRDO+FKpbqCSwDzRIDNhtVlkDqbDSypaLHqtWm8kl0L7zk9gcSeeuzbMzQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qih4qq8P+9Iat3Ue1SjRW6O4jRe+wEjtBAkrbndn9PEWXo7aA
	awjp+Xxx+kNoWMRAFLTHiD3EFz4fYUXQ4vL2lPzI8Y/Lw3sD1k06ZRyvp2yJIV5k6lU=
X-Gm-Gg: AZFdTZdtn4cbIO6Miz/hVCqNn7jRq+/tIM/cwVoSHK5yRMKXAC2fORMQaHB1r4JLaod
	ZQlGVZHObO94pt+kkzVk6M8oqx5l4XXk1fR45wwPJzqRfmt0mSG7X1grA371EP84BnD0L3hRvKr
	x+yC0kYNydadG90p8A6RF66vE4DNLoyuN4l+pC4dclbqnkGaRBlO5OXUom8tzXwH8PiEcr5a4Pl
	Xc2yHncq+XUmrKle4k5QQLrCawEY+esfVu1G3n7BGhz7WsMWGbxbKM3DXrw3pf+9a0aDkp/Xdw5
	bV64niqz8CDxuAe296xNNm48cwHfWHbgJjmW9QEHYh71Dy7WRr5mtbekTf4uZN9BBzQhipBC3bR
	bXLdS0dSBi7l8iDyDm3ryRVWPDm4pSImlk7Qpf8j+Vkmba42bECFKBDep/cMVddcOsFWDGJFjZl
	axPcrPpZIOWdcb23Zcho9JMWP4zlAPsWGigY8ruF7tli9wNOeFy247eSh3w0NeCo+c3dhFVV0JE
	A+85DDwZiug3h3PZ1RpmO6jD0Re19FTjrhLkC1wg8e9jFUC3PFcmv4rhOf1DtMRq/9ppSw/hAru
	dhjOPu45rn73mJ4zIc6OUdzBzv2Iss4wYqLltZs36NhJ5+373s4N2HtCSEKgcF7HrrrOre2Gk5U
	21Wz7Vedk
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr372318965e9.7.1795594494562;
        Wed, 25 Nov 2026 00:14:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:f368:ae2e:e717:e970? ([2a01:e0a:106d:1080:f368:ae2e:e717:e970])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm26993885e9.2.2026.11.25.00.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 00:14:54 -0800 (PST)
Message-ID: <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Date: Wed, 25 Nov 2026 09:14:53 +0100
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
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel-dev@aliel.fr
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/26 23:05, Martin Blumenstingl wrote:
> Hi Ronald, Hi Neil,
> 
> first of all: thanks Ronald for picking this up!
> I like the overall approach. Before I dive deep into this series I
> will finish the code-review of Valerio's AUDIN series.
> 
> Two quick notes below.
> 
> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
> [...]
>> Overview of the series:
>> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>>    add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>>    "hdmi-phy" child node under the HHI syscon.
> It's been a long time, but I think we've been asked by the devicetree
> maintainers to have reg properties for the nodes within &hhi
> But I can't find the message at the moment.

The hhi syscon nodes doesn't have #[address|size]-cells and so far it
wasn't required, let's wait for a review from DT maintainers, I'm fine
with the current design

> 
>> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>>    PHY configuration ops, along with the temporary legacy creation
>>    helper.
> At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
> There seem to be minor differences:
> - two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
> HDMI_FIFO_ENABLE=BIT(2) and  HDMI_FIFO_WR_ENALBE=BIT(3)
> - newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5
> 
> Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
> won't need the backwards compatibility code. So if you need to tweak
> the driver: feel free, there's not much you can break!
> 
> 
> Best regards,
> Martin

Thanks,
Neil
