Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864243;
	b=qMfrQmgFrGYRoHzQ0bIPFcA7kpBbTZjCEaQhUu6KhuqH8o1m+uqMyGqEkf8swiq15eVB
	 EjTHl2+Gye6pnawDWrtjKl8W+cXAAV+nBELlUGoNHjNt49Inv4wYk0FD3XZW7FhLM9Iyf
	 fQ1I2SdPEo+5oZWUKbZdeuxzNW1KF4lCgCz632/3d5+k9Qw/xX/yLxxYDWkZd2DyzG4uJ
	 Swc8i3ER6x7r1btuaG3o1OWuBMb+e2gt/5hH+c9RWPzSdEQicgtI1Q1lfrdF3UA8wYFuL
	 Q6CIoMsUeSP/inT50Ryz3P4sRQ7vhY6ECnOmWHg/1qpz3N8cpoyMJeyiF5wngtqesSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3NDCplZK7ik0X8Yf2ESiTaq7yDLCV4EImoCaTstoWM4=;
	b=Ru9Pd9eQKOkW0TjTvl5ncygMbpFz9aXhmtD4FdTOOoTG9aeem9Mc9ZFaxJHED/Yy8ZeT
	 EuZdlJVYkbPeOxiE64R1ge9az4kh6hUvE3bx1KmHOFkWexzzEtQv5I9WKRUeZGlr/25y/
	 XAdAAkU87WJdoD/VcNbaO4wXTW7TRi9JCKjSRLTWePP5Xhx/aPT1zdDg6MNImGxQLBWnM
	 5pAtSVXHOr5Zf3qbocidHHvO3ycGcigLZZY7OgGZqQq6hzo12wZVhmrW0K4ePKjF+27Hh
	 o5R8rQOZS1OVL5APpHecqWIuff0SzGnySI8X8O+s7IlZXm2FsueBs8VOfFz+AdthG5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dFXwQd7t;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E2606A32A
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80E2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dFXwQd7t
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so25150585e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794864241; x=1795469041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3NDCplZK7ik0X8Yf2ESiTaq7yDLCV4EImoCaTstoWM4=;
        b=dFXwQd7tTuURj2BECf1IhZuZKNJtzMvXRCZY1JBMIbvQzl61PWtjZLwQb6DtvGAVNP
         r2Jh6UvlMoDYUGGIUTooz/fVGQU1cYBgbRn1fYjXnMLGkO+j/rUJsjv7b4hsLbxCTnsP
         Tygqyc3qziyZWxwkLhEhgmIo4yfpbR6HfjAya2uDzxoxPStl1nTjwrVSxxUIc6F/1tI3
         qNlQxH+mRIxYcY+jcvoXQQgbCAe9dI+Kr4lIWtFnHqJzpOW65mD6FoafA4eBrUMKAAg4
         UqSsiCjhMlDD3ABhRvMIS1h+CQgCgFngqhpNR3NCCFRhTfqYVnV23jSG4KrjvPRAQw+T
         WWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864241; x=1795469041;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3NDCplZK7ik0X8Yf2ESiTaq7yDLCV4EImoCaTstoWM4=;
        b=n2bk1tdYZujPed9CNscYhpaVUoHHYUczgsJx+IXi2fiVMMyChnkq67hLIL7GrrYm3D
         Zhf4TJ6OEOWAdr+uwyWip4C0ZQegm2WxQV7Qa/VpqMWxTqdH7rg3K8bgj3tGYhjDxxhy
         QzuAN/t78UHdNq54rvRuPMyBjIPuIa67AavUuzB2FBsZMrzcDjR+ns8LEEcYi5BCAPlB
         ycs0bsuHMv8g7F96e0B9BzdtJRRQ/Uj8OTlnAR580JSz7dxm+ES8lKeyzvJ459TyBnfw
         jgitjAlKhGv/xCnD+haiwKMyG8B3efQyhTjHwarTVkFYtW6rVY1WtRr4G9vrklvNTwAy
         dIiw==
X-Forwarded-Encrypted: i=1; AL+hErE74EOv8o63V/kZhhotCBkEFV5sg4XdCcwHHLhmI+1cjgSUwMblSem56L/hJm6oHvVW89ExEWDj1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Uqb4WQLJDqHDjAi9PaKjiCIZ3PLqsTBHM0C0rUHJ9LkFPkKLE
	2sYzQcHSv1ERe2ygCGKGSlZlNyzr08/X3m8PF9Whi9jMGjvvPL04L4iiQiMzpUpzoHk=
X-Gm-Gg: AYBFou2KP+ZRw/YL9hL7XvH+BtzzHi7vL52diy1IbosKeLNgND0/d2ksnGLWzXhcu/k
	nMpHPY/acY2tL3BD8BMY22oPoOijwfIOAV+o5KqfqO9FlhOrhprPlisiKxsvqEwP5ZzptMGqaY8
	+3rqB1SU3qRml45/2BcYJzoOb7/bKXN9PfdTQ5rfO4kkpbPzJg6YUCUppyKc4jQZwknR/480e+Y
	AXxV3PsOn04w+fpbFWBxgr55LslJFoYcPLACIzcTDEhFAByniWp4pDz/ecFh9i6FC6Q//97HVa0
	Mr1FfW+0v4/SQPzsnonPwOQbRWrQJio500+mw7JkIbcjS8+c8ZmGTjdMD9G9dcEZNKxNl4JKFsZ
	5hImSTDksO+gtMPSH3JeoR+m+lB7x7AENK3sbOKJ6iJZdm23t6HMNKaPmZCu8A8vIUbFgqZpqmc
	zw6v/xTceelzxIShQeXNgyXaJh13yuzCeoC9C3skfOKNkabZSOJmjDDoED1Nlx81b3Uuf0FfbVm
	X2O/xwKqDDC7aM7ooT5td4hNtUm47w4+lnT2lQ8tOYGN8sXm/GMXHRqfTWrh0L+4OZPJAimKdDj
	e9imdEZXPQZ0KK1oRTUdjcD+VUMG19dzezwzzA4c09VvZ5eDCT/m4jfehFv+2gEMtBHrcxyykGw
	L/XlFaDiX
X-Received: by 2002:a05:600c:c84:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4bb55a68429mr264065535e9.26.1794864240857;
        Mon, 16 Nov 2026 13:24:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:7319:1134:8f94:f341? ([2a01:e0a:106d:1080:7319:1134:8f94:f341])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm220605515e9.3.2026.11.16.13.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 13:24:00 -0800 (PST)
Message-ID: <63a95c40-2371-439a-8974-4dd7a65d14c8@linaro.org>
Date: Mon, 16 Nov 2026 22:23:59 +0100
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
Subject: Re: [PATCH] interconnect: qcom: Don't read back BCMs without an RPMh
 address
To: venkat.yadlapati@yahoo.com, Georgi Djakov <djakov@kernel.org>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
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
In-Reply-To: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 21:19, Venkat Yadlapati via B4 Relay wrote:
> From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
> 
> qcom_icc_rpmh_probe() ignores the return value of qcom_icc_bcm_init()
> and reads the initial vote of every BCM back with rpmh_read(). When the
> command DB has no entry for a BCM, qcom_icc_bcm_init() fails before
> setting the address, so the read goes to RPMh address 0. On Molokai
> (SM8845), whose command DB lacks the QPC0 BCM of the Kaanapali gem_noc,
> that read never completes and every later RPMh request times out, so the
> regulators fail to probe and the boot stalls:
> 
>    qnoc-kaanapali 31100000.interconnect: QPC0 could not find RPMh address
>    qcom-rpmh-regulator 18900000.rsc:regulators-2: failed to read ENABLE status ret = -110
>    Error sending AMC RPMH requests (-110)
> 
> Skip the read back for a BCM that failed to initialize, like before the
> read back was added, when such a BCM was simply never voted.
> 
> Fixes: 11a44c6087c6 ("interconnect: qcom: implement get_bw with rpmh_read")
> Assisted-by: LLM
> Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
> ---
> Found while bringing up the Motorola Signature (Qualcomm Molokai, SM8845)
> on next-20261113: the boot stalled in the regulator probe and every RPMh
> request timed out after the first one. The Molokai command DB has no QPC0
> entry, so qcom_icc_bcm_init() fails for it, and the read back added in
> commit 11a44c6087c6 then reads RPMh address 0, which never completes.
> 
> Tested on the Motorola Signature: no RPMh timeouts, the regulators and
> the interconnect providers probe, and the rest of the boot is unchanged.
> 
> I used an LLM (Claude) to help write this patch and its commit message.
> I reviewed it and tested the result on the device.
> ---
>   drivers/interconnect/qcom/icc-rpmh.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 4a2a746a4e59..1fbf4c960e1e 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -332,7 +332,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>   		return PTR_ERR(qp->voter);
>   
>   	for (i = 0; i < qp->num_bcms; i++) {
> -		qcom_icc_bcm_init(qp->bcms[i], dev);
> +		/* Don't read back a BCM without an RPMh address */
> +		if (qcom_icc_bcm_init(qp->bcms[i], dev))
> +			continue;
>   		qcom_icc_bcm_get_bw(qp->voter, qp->bcms[i]);
>   	}
>   
> 
> ---
> base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
> change-id: 20261116-icc-bcm-readback-a339f8caeb09
> 
> Best regards,
> --
> Venkat Yadlapati <venkat.yadlapati@yahoo.com>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
