Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004471;
	b=pM8ckT/RcIiqwKF7nW85BjEpZla4LtQSfhINpftTRS/MGku6LckeVm48/ZWvfg0vbSza
	 xO5EA3IxB8M5keoWznetY6LbiUVDD0KQFC6OjsvoV7Ec7OrA6GNROuTFqQ+MFsNJMwd3w
	 0NS44whJbRhcFSsZQ1EVe/tOIj0NLYKzGzDERUDGf6K7Jrf3AyuMBHGBdsNM/cxBm8FqX
	 A48QVOFpTwpmybb9fPK8+FTvspA4Q8ywdHWQ4bq3yoKvHALhEkMf58Fh8UAZOWLX4fWYr
	 yYmT4fSwyt6mVCKsb99WmpNTi/tR+w4CUlBLhdISN1I9MtLCyLOtDU7rPL+11P2hTUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vNFCSReGDddi8uPRrxfpuCwFDb4KWoAVuKYCjqBpfo8=;
	b=O7x3XItAELaQAN3NAmB4TkVlIYQ6kEsNz5Ul1XUDEciYJNMQ5plyrtkjtSG0QZXwS9H5
	 PK2PKcDDRxp9LsMaX3t0bA4n6E9YYP/qFog67REJJiqoHBZ4yU9qjSfoNxz0IuB2XAwGY
	 ArBgQ7VZxE6mIhsOMnrYv2EE4/F2rmYMuXJUT5TvsiaWDAtPlFWaO0Tu24NSuiVfzTw56
	 SyJ4wcOg65Wx0XirR76q6s/akVxhbsP0knHK3lYzrSd8XulPSx7N96A0iHu8gJ4kPGiJH
	 /quKWM350PVej37cT7RGSzsl2S7gpBFVM6Zwxf3Ixvqd85Z3LEmUBFWqWY+ECrIZevw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fcik320u;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F125606A320
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 08:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F125606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fcik320u
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso11460785e9.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793004469; x=1793609269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNFCSReGDddi8uPRrxfpuCwFDb4KWoAVuKYCjqBpfo8=;
        b=Fcik320uh35ifV8sTeLMXHhwLamo192JsaiTAcKLYZL60+Xi5keCuAB+mM/dKd99/b
         99mixi2QXZlnSKcly3ViuJ0rhNIjclfFz82fqXbj95VGeLiCzUzEsRjWe0mOa+2gm2/1
         6iymnIKiqDed546xIu91lGLwTY3Kxr+B7iY28kQLETer7MpnLwt3Z5U+jJ+nhzYqQ4Ht
         m6CRB9BfIKhg6bGrrV8u6qzO0hcQkBlimBmRVjsnMubkVZ5b66YCFicr+z9osOcTesq/
         soFSYnNm+PnYk1PkePrQ++/bmM/8IE07m/lLMJekroZ+0Mo/2dfagdYUjC2pNXH6aZAP
         LzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004469; x=1793609269;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNFCSReGDddi8uPRrxfpuCwFDb4KWoAVuKYCjqBpfo8=;
        b=YYNf92JrHHr8YRmLPq/CMO9MyTxL+S8MbpdAggFlEusAxIkXIPKslsQ9Mc0sqH+573
         J4GmWy8Cqfc8/m9K+PIHxReRCDyikrMl/SzuEv0Xpa+v8fKp2wrSRhm9WfKqqFVTuzci
         LNYU0+DjWjfrpg6tJ6Pm0YdfXeAvu2pN/2k63FZBzVM/vKtLmdNslZJrJ+XnCxu1FVDr
         AMOyj9SeGfLYjFrnM/3HFYqQN7xsquJTzFYbKqAUzo8eXfib9C9Ki1TdwnHWoCup7izi
         VRX6ZF4fprmO21i5yRwn2oZ30MMJXgwzJOyLhNGpfcpl8ZWkcrcDeWtLzjfwC2i1y7FJ
         zTww==
X-Gm-Message-State: AFq9FYKaNjTofAHFJ1BypJIAbWdZNHqhWDm3iBWzqnE0ehbIe+aJEy2d
	FSDfLG4vvcLWmTOEBIAdKohWXoD6bCP5IhxtE8XYmFLkvSlE9MVK7EJXbafiIUd/R90=
X-Gm-Gg: AYBFou2syiwJkRmophRbJ0JrGNYiPkYsp9FPTNtMhGvJ2pcIa/W8gvnKWaqa4sCTal0
	peD8+ZRzsXaHTrHlOeaDAHvv3HQeTdGw3QURN0hRDb7s7Y4aEhJuanayu/jAvKswztdTd7K2kBM
	fS9/GMpOe7AJbVRmq4wL6kfyGO5xQpKCjHCKdRPlMq74VPJLHlgLzQ7PP/V0sayHj/NB0SCuGgG
	sotfQgjrfTulPtKYEourqJWSFtn7ZcbbOuhhj9ME4Z9MBg7BtaDqrZKC8UAwaVYnD944B0d2PnM
	1FBc3Laqyar+A3jOMBGWUKbJiRUlbLuZO7tF8NqiskknyqUk1sfZddT/yPjqkKB+t8qxyZrR0Pz
	SvyGzHNu6+/zl05Jtjh7Ug74kVw7X4nykcO9eppsDKU94hQo0F8/5EixDv/RFLjqzBTFn5dC6lS
	z/3CIMJFM0MzWq9SgY+3waa0M8e8Gl6Pb2ThmeuaCJGZHyKb1GAmMVRW32icnCoGgaBocPQoYGw
	JooDB/aCkK3r8irdPjSIGGq/p2Fy3rZdYPITXsZBJV78Wgltt0PWKWOlZKRabLNC6fDr1hDwATh
	AVfGjwSQELmoz8q/b3I/4UGAgH9setKugVzx
X-Received: by 2002:a05:600c:3b2a:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4a35ac99d0dmr99335295e9.10.1793004468879;
        Mon, 26 Oct 2026 01:47:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:d07e:c128:5c21:78f2? ([2a01:e0a:106d:1080:d07e:c128:5c21:78f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa097sm197353145e9.3.2026.10.26.01.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 01:47:48 -0700 (PDT)
Message-ID: <7eddacd6-a394-4bd1-9d33-38e70e75e3b1@linaro.org>
Date: Mon, 26 Oct 2026 09:47:50 +0100
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
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] thermal/drivers/amlogic: do not log the secure
 monitor deferral as an error
To: christian.koever-draxl@student.uibk.ac.at, glaroque@baylibre.com,
 rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192244.209256-4-christian.koever-draxl@student.uibk.ac.at>
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
In-Reply-To: <20261025192244.209256-4-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/26 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> 
> The thermal sensor usually probes before the secure monitor, so the
> first attempt always defers and logs "Failed to get secure monitor
> firmware" as an error on every boot, although the second attempt
> succeeds. Use dev_err_probe(), which records the reason for the
> deferral instead of logging it.
> 
> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> ---
>   drivers/thermal/amlogic_thermal.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index c58bac633bed..54e59f444d46 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -196,10 +196,9 @@ static int amlogic_thermal_probe_sm(struct platform_device *pdev,
>   
>   	pdata->sm_fw = meson_sm_get(ph_args.np);
>   	of_node_put(ph_args.np);
> -	if (!pdata->sm_fw) {
> -		dev_err(dev, "Failed to get secure monitor firmware\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!pdata->sm_fw)
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				     "Failed to get secure monitor firmware\n");
>   
>   	pdata->tsensor_id = ph_args.args[0];
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
