Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523051;
	b=QxngQSxsf9taZbe4xHKdOPD2PJMnLKeV5r6x5so5IPWe5TjnlpTcwDJoHIjJul49NTQY
	 2bW81/SydyWxVF2nXtWwfbPcBDEb1Bg1ubTxEN2Ggt0k4Gr6IMbJLXKWiMNXAS5lBpXyW
	 UE2ie5rq++s9A8rQ+l8m7TTdYUtSFmnazuVRvgIJSgbjL0L9b2Dz4+82Hy949pN2p+3Qf
	 OlaOqzvVsSqxh4LN3eLHiQM5ob2xRHunnnT+PedFaIhDxHuOfd/IlJ2w8/O0uDvXGHUsC
	 D5v65jiLTmxRo5wD/OVIUzCJTDS6Ms3rXqIxzytcEYw2SeFrGqmrdZtvwZSK0fV2qiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
	b=HcenQG6kFocDO8SxV+PEetgOsVIaPrv8lyA9uhD9+hbv1toMlCHGz1tMEm+LeGS582P/
	 h/e9GjSvFbnI3IR2KL3/Wp+f2O7Xb+s22fxQfJQjOTmWr5bUV6b1+62W9vwemvf69caXn
	 Nxxq9c/DdSFZAOf3jsrjOG80PAvicc2ic+fhHSKn8e3Lj/JpRmccpto/iyGNVclkgcj5y
	 4TmsYjAEUrZTVLnSJKJGW2h/4Zx948qi3/tHoJBi7IE4bjCH5z9FaUrf2SVk8W5SOojLe
	 eT6cy26Zk4Y4jJ0OUaXhQnfjvS4oDzbwFfczOa5qQdClA+JJ3m6xFcmS8jJ5QdgKBrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLr4Pt+J;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328F606A320
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 19:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3328F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLr4Pt+J
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so4511496c88.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792523050; x=1793127850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
        b=hLr4Pt+JNnJwfVdSIiwSzVwN2M1EdektMGoj8qGvTIg2MHi43g6P3LOjqDktLIrXJc
         /LbjGbnm0fv1Cio5pJKxGcmBKzdvQ1Bf8jSuV8V5JJip79CY3ECKV2x7PotCCn1kvzCQ
         4YaZ8G9IpdE+7Ow3oYO6+adNmYfrSPrPRZiHksLbJk7N1fryAL33UOp5jSq6Nup2ngpH
         wOl0+Aik0n+dpNKqrXJHKnb8BU2rkXjhhP8rhu7nQdn7ktiO6XlCo5a1Jmr294bKdHsr
         TPkfN5DqX8YEfDV0yTlKP0LpctSqRfqyj58P+bLiOitnTlcAmXRX4sdFHQMGgmS5yS9g
         opWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523050; x=1793127850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7NqznRIlKLn/pELhTMEco0REzkh4v7wlCaqZptITogI=;
        b=j5ypQ8gRZ9XyIuaF3HU+rGsnmAgUzq+I/4Lk3mRD5v78FTvEY/+wG/gGH5saac690b
         tVbiW5/UmtYVE3NIMup9M1B/90Llz9Z4oMNpHCKVTlBMWwjKTBAckxHYrKpp/QEbU+uK
         rc6k86Tpe7kVE4cPZOn4btwS8eqw09DLK7QVnQj4OAzoiEVnShzMYunADjVzrcl+Qz2Q
         r1IoDPLlJlGfqVAWBs6ZPBq3B1wJ3riuL4lH0Spqxm73z4gAxCk3BMU/EDBTFjxEvVs0
         pGU2Sy852koktYIu10jGf82xlUnBZYAfsui8VDZBJbMFp6Wd4T4Lzoc6fDwBOJ4p0AOh
         /ESA==
X-Forwarded-Encrypted: i=1; AKwUvBx2iBahy7y1oDMW7fgsYEhutAnMQ5mv8lQ2IwKAp1hA/DvM20JFf9u9xP1FzkOiyuALLk884wcoFQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+3x8NNzJsao/3w8miaVVLbl/OE03BbOVaM82wgNtDaZgCmUDw
	OhcEixmOQ1Z40jIRRPnxfgAH3jcZs1iK2+Dsob3/8cfw02199pRqspuG
X-Gm-Gg: AYBFou33i+Tx0G50OYma0YQHSPADQ4Z+hbUHT6duvpsFQeJxwTF9RKo87ZB8r30++wW
	Q8HqzFFtgAPbdzuy5OQ8es7fsXV/l2j9bWXO3nKjNvuGe3qdTzlghQHHnPbd4EsdpgDyuli99LR
	Z2SrTI+KQjlPX/068JaW/kL8wi6s4SsKkKl+9q2nvjJxzfygnW5P8x2V/3iylh80Ecw5Jgemzmr
	JtOFWPPBM1J70kCatuIzhaxlIFzN8o6nns0ERfsHi25fYDo4Trk7Fs0TQFdsGQeuBtD1zrvL7Rc
	FyfXFuMgT2F0sw65l+SaYxSaKug9qyvAJVDDKk+G2/qSXs/ulEP2eWmRQUw9iLriOafWc+fHmdg
	Qer7k4G1Bs2UjKshjb3y8aAcLn4J53/R45wEDd+J+U7wHeHyNc/8wjz+lxO0d/ZEl9RI3q6jwAj
	RNjU0eNcZkQQoqIkkMhnMscflKmsI9Ixbxjvtdg5gfALeJkD3Xy/Tz8QX4PCgfS/I6RsQNQgbht
	xZv86PwXYZkjnuNYphPsBEet4yyRfJJijKITCJz1D+ZpRd+NJk=
X-Received: by 2002:a05:7022:e804:b0:13b:3132:6e99 with SMTP id a92af1059eb24-18512c38164mr17695167c88.20.1792523049985;
        Tue, 20 Oct 2026 12:04:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aefe90asm552320c88.9.2026.10.20.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:04:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:04:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Message-ID: <ate5K6ZdrSoBUI08@google.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-4-clamor95@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019100406.103687-4-clamor95@gmail.com>

On Mon, Oct 19, 2026 at 01:04:02PM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add input driver for ASUS Transformer dock keyboard and touchpad.
> 
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
> 
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> +static int asus_ec_kbc_probe(struct platform_device *pdev)
> +{
> +	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct asus_ec_kbc_data *priv;
> +	int error;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->ec = ec;
> +	priv->parent = to_i2c_client(pdev->dev.parent);
> +
> +	error = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> +	if (error)
> +		return error;
> +
> +	error = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
> +	if (error)
> +		return error;
> +
> +	priv->nb.notifier_call = asus_ec_kbc_notify;
> +
> +	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register blocking notifier chain");

I think sashiko is right that we need to register the notifier first,
and in it check if serio ports are ready/registered or not. For that we
probably need a lock and set pointers or flags in serio's start()/stop()
or open()/close() methods.

This can be done as a followup I think.

Thanks.

-- 
Dmitry
