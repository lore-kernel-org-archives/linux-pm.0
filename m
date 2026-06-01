Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C34405B
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296544; cv=none; b=r4qJrRDhkQqp9e8TVSKrgZ2w0U010HsScxE8OblK0RBFqS/vBEUidnehvf/wrgVIa03Il/f/Xt0jFrz7V+8fjU1pi1gE/4+wTWoT+u1jNkdDwysZfApEI+hD2fTOQLmVNsWIVuebZgsxLhumtefIPGVSCIC9mHnDAcg233befew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296544; c=relaxed/simple;
	bh=y4/ouupBjoYRS77m3fiaKDERYhLyJZEdAdivWI66SqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRCmGq49JMlweCuZH9pQwtcPjGQgtVrAddH8OtB6Za5/4FP6qVDPCYvbtaXsaq2YiMyhMyBQ7NwbO/POBA+4QjIPBnHq6UuB80juc85YltpMKi9nGi64iwtZTZI9xtO8yWIRGRpfsL/l1jQWvCES6ciL8N/dXTMLOTt01a4nSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFr10+Tk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFr10+Tk"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39677242021so9969151fa.1
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780296541; x=1780901341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGxbL9faVDVgrvfQsBar+KVqQ+FJr+nh53Wa1vgTsOQ=;
        b=VFr10+Tka5udOyEZeHPRt2c2LQ2IddntCN+iHIqekFX5bgmGIESaNGgHS0qbcaisHR
         2wmbZqfGGKL4SQ9p6Ztk15Rh9+Yd0xMWyokc/NZHZIdo6e3WC6vVY7nh35WclbutOXzq
         Pa4NO465DvLhArlqwwkbOLv7kDd4xo+LuZRBmHtRRoAAnwSrsWrHNXlebfL63HxuwFXF
         lHYTU9Bl8WpbgdtdSU06TkbL/VJw0nlwaHNk3JD/jB0LrKdkDH+CWHROKHLlxcCjcj0v
         bGdC+ckYGDG32wXAjM9XgVFIwfCePrhoT0jY3rUVBjMqSb+3tZWL1qx1AyRXX3G/2Pvm
         yJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296541; x=1780901341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGxbL9faVDVgrvfQsBar+KVqQ+FJr+nh53Wa1vgTsOQ=;
        b=cqSxEHgMN8FsdvujCAihs5cNB3h2oTk2URoiZ1FGhpCmKC8Nglw2y7YGx5rVyjW0gF
         ghoD5w7yxGvdprlc5RCw648zbfhWTFVbaKNcOpkR1dxAAZ0P45sD5UP6KBGHrXj8Ir4j
         ASpppeEYOi+6FhA9mHyzWW7Lpga0ypGL4+Fgv6iLS3DWoXJ7Ea3LyZUtdq9avD1BDvTu
         H6sIZTeHUUFF1V2TtVTbiEXgYJHmAC5aRmYsH8NC3Zp17hrnHcGTHwJSyjhroXbUAIwt
         0fNXjvxScFw83W5NyRoDcmEbBqCC1Ct02LiVgDNzhFI0Jm+uJ/4ukREfHE70+LvxQTl8
         WTxA==
X-Forwarded-Encrypted: i=1; AFNElJ9zC89N4JqAmdTVc59LIHMMhI9reAgW8s8Vm5pb22BZoSTdF46p+aNUHYTqKYfY1+LUrw7BcWyTLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHX2bd8WptzRa/rOH5AZMQ7J+cNs2QzqNMrkAHs5o+jj+Qse8
	L4zu2T413ps3HxaSB9J0yx83n3pnyUVzBvFWRALLD5rCekeGEaKDYSXg
X-Gm-Gg: Acq92OGhhnYZGIITbCtKTfZaFAJCqBe4PD6MLNPnRvUwljIHpHEamfMIf1oFJvVZbCh
	qkjEFZdvvwNaes7/OW1Qr+DGLFHp0Q+bGShxDpkOX6ITjWqhis8MbGi/VN6ggal4RaQ1v0MuMCV
	ftPTV5DV4W6OnbxN28Rxq+2Gec1I6lv7ghrylyPdooyGh3mBNYwdVqxd2lVmSWJY5PZSqRPEoXC
	//zVsMNNlEocX9KlXGMzzo/qGZQ/YR5sZ5k6EbtrCqR9F4MCbl2EgENBUNpSfEkdkyyFnQTY8AT
	zvoRylWu+S48dab6jFQegutyFQMoediI+To7Xv4xWQUelXzGmh5iu2f/0jsE5lzY/fuXIaOT0zZ
	iM+9Fvk9lCbkTES3meBVkIFKnyoqadKL4mXXTElvF4ns4YYLUYL2m6Ks6FNUXfE5QhLu3zW6jU8
	WHjh9apGJPoSlAcQZnO6aHhj6p4oknzhiz8tbZ0qVIsmn4UwFB9iZCGagiXVWYhxtr/853wEHsl
	p8h7Npw9j09ELkPpqA=
X-Received: by 2002:a05:6512:2306:b0:5a3:f25f:cc30 with SMTP id 2adb3069b0e04-5aa60a32f56mr3289885e87.32.1780296540285;
        Sun, 31 May 2026 23:49:00 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b793e24sm1898970e87.73.2026.05.31.23.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 23:48:59 -0700 (PDT)
Message-ID: <b509c623-a47f-4216-9202-2c542f3c2e7b@gmail.com>
Date: Mon, 1 Jun 2026 09:48:58 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] power: Use named initializers for
 platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Sebastian Reichel <sre@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>, Andreas Kemnade <andreas@kemnade.info>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Amit Sunil Dhamne <amitsd@google.com>,
 Samuel Kayode <samkay014@gmail.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
 <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/05/2026 13:18, Uwe Kleine-König (The Capable Hub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
> 
> While touching these arrays unify spacing and usage of commas.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
