Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BED35E92D
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412399; cv=none; b=Cox+qo4ohQV7bIyEroIIZrdT/ISgKDkS7pK6oEoiUqXrUTZA8x7QA0DQpadXjIf2+cEQ5QNt9g/bK0DSosbP57Ey9SGtP1bH0m3oOZolP5sDDP+dBv6M1uS5eBq1KiLer4hOyUJsiT24RHydlwW4Mirxmd7W1v8t2+CJuP8y6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412399; c=relaxed/simple;
	bh=m3YKyh/WY8cD2z45OzOO3VzffzzojcrAYmKe4Wimn3Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fajGZ6IyWGUKJ8U1E5y0s1hXK1wkKqur46KZdkhvNyJ8Lpws3Nf905a47EBfBgKG+SHtr8OeyYkC0CnU4WZs+lH212NEccjQx5cVwyJSDDHbx+Mvv6cr3K9bV6ecTiTCqhROSA+N+rn5bwenbWEni722tuScLg9pTsTEaZBBD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXPCmhPa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXPCmhPa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d74086e5bso315308f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776412393; x=1777017193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpo7P+uEagDswLieoNvqnFSXN/IsF5q+qpaAheY25VU=;
        b=MXPCmhPafD2JJc7m3ubPPO/DLgLdgfiD3VHlS+i7D3q0R0RhDwsR26712hGJlkjwjf
         zxOWw7hAek28AWGcTzordRfecul4yJIdgZmYhV6ZiHoTBun0/f+/HJEPhL9mXkORrsWU
         Zhkz83bNhsksCJQF0FJt6OjQBFz/xYv2Gwm5xA3PNTVXm9YRHDISozO5IwAO7bgDZ3d6
         Gp/A/nfk21L8rECCVOqhPh/OtTPFr17fnSapxfwk6iV5xv9fECSnu+Q3SY+wM4+GrFl6
         yi3H2puAmRQ+T/tWnhV6xCZaBnjpp75MCPhZt+b4XW+n52i2wuUxKlHONFJyGIWgdNMq
         DChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776412393; x=1777017193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpo7P+uEagDswLieoNvqnFSXN/IsF5q+qpaAheY25VU=;
        b=XHl8DzV44zxUZ/+hDm+LbUsI9+gzpmF8X7nGgmr04aF08LElXagJEiOCESQGd/ovq/
         tL57785CyAJd5sAcyJ3SzdBm39W8kNqsQotnMb9CauxO9vCkvbI7jlU7pS7H0T1SzEl8
         V/oQlTit0xkYG2Gu3+cesE8gsGcpqxcmfDhGKdUSbsBWo7Eci95jatn0pTUNcjGPPgtz
         5KzmUv5DuexrJsfoorKsm0/j7Nq35fBL/s8q4VXd2NfssHnBsRxrbL+yW//OPW+lWk2G
         1Dd+wK3NBYNNEWxaN/B8vBvf+/XtlrMxBz1Faoo5WEV2eKwtDdAUaZTl4DTpHBYF4+5Y
         RA1g==
X-Forwarded-Encrypted: i=1; AFNElJ+Ezy1c4PPmTvVUsspDNw/cFyISr9+A+/iwFoTXeBo4PgX0BSktY8OXRDmD/Dlo48eHhKprfE6UOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVPmrgvOXXYj7pHbtPECQyjYeVXP0zlHjatb72sMhhOK1QSIh
	GZIWPmoCgGcnOlGu8aypE6K4drquklvAAe/J321k0TQvb8ABDg8M6RjIiMFPE7cfMnI=
X-Gm-Gg: AeBDietbQt6K+v3io7POMwpa1+FH+ivj/5pnRiQhuN8yaWqAG+RdCN0OOiG+z7GisvA
	U78Fb3Xb09o0ZJcTq9ilT6bpA2UIFzZTlW96kBSXBkmERwLMbBKO8Lf/RhUqaBgAfQ0zFHBusbr
	Lgk9Jzy/GCAVoa/Q4qxL7eNgCm4w67DVq8kZyrmO9BFpwUvVG57oNUE4k+T7WWepK4ROiQyt7qr
	H3uog3Bb1po5TGpbguOny8JXNNSPnHmNI6q/cYpF1acqpvlAHI8xZ1kSqNbm0VvVnE7HZY2Eug6
	pqu88DymzWn9eH6hUsRRZziiO4zFkBRDKyn5ZniskYaI8C2FQ+4XkvAbfNQxOwV562fM5bbHZTf
	1pJSk/uhq8NIwObZaco5BPKMfZrb6Mr3DROrWPbF9yEGAX8mlyWaa302QT5Fn/g0GitNm1FVf5P
	G2cA9md9ohSjOSBnJzOdbqQyBSLkJtccKBiKfOiXgU744m4kQv2Q1K44BIN/JNjP7qCVZVCvWI6
	XYWMHND7aiU7eY=
X-Received: by 2002:a5d:5d88:0:b0:43b:5231:e94a with SMTP id ffacd0b85a97d-43fe3e0d12dmr2364823f8f.30.1776412393117;
        Fri, 17 Apr 2026 00:53:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b416:50ee:20e:8775? ([2a01:e0a:106d:1080:b416:50ee:20e:8775])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm2584776f8f.9.2026.04.17.00.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 00:53:12 -0700 (PDT)
Message-ID: <6758aaa2-ac1a-4751-aece-2b445b84f2bc@linaro.org>
Date: Fri, 17 Apr 2026 09:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
To: Ronald Claveau <linux-kernel-dev@aliel.fr>, Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
 <20260415214815.GA602572-robh@kernel.org>
 <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
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
In-Reply-To: <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/26 10:25, Ronald Claveau wrote:
> On 4/15/26 11:48 PM, Rob Herring wrote:
>> On Fri, Apr 03, 2026 at 06:08:34PM +0200, Ronald Claveau wrote:
>>> The Khadas VIM4 MCU register is slightly different
>>> from previous boards' MCU.
>>> This board also features a switchable power source for its fan.
>>>
>>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> index 084960fd5a1fd..67769ef5d58b1 100644
>>> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> @@ -18,6 +18,7 @@ properties:
>>>     compatible:
>>>       enum:
>>>         - khadas,mcu # MCU revision is discoverable
>>
>> The revision is no longer discoverable as was claimed?
>>
> 
> The firmware revision is still discoverable, and via the same register,
> but the VIM4 MCU has a different register layout (eg: no DEVICE_NO
> register). The new compatible is needed to describe a different MCU
> variant, not a different revision of the same MCU.
> I will remove the comment as it is confusing with new boards.

Yes basically it was discoverable for earlier MCU version, but is not
for this particular board version.

Keep the comment, but add a comment on the vim4 entry saying this variant
is not discoverable.

Neil

> 
>>> +      - khadas,vim4-mcu
>>>   
>>>     "#cooling-cells": # Only needed for boards having FAN control feature
>>>       const: 2
>>> @@ -25,6 +26,10 @@ properties:
>>>     reg:
>>>       maxItems: 1
>>>   
>>> +  fan-supply:
>>> +    description: Phandle to the regulator that powers the fan.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>>
>>> -- 
>>> 2.49.0
>>>
> 
> 

