Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692823;
	b=WggOTbA3KNJvQPBnr9lGHurA5xgSZZI7C7MdHE5ExyRVTOA0ukhsa6uEDjfWF4isMU3q
	 lA0RHn0LFDvUbDQZvLQdhnehl4bhA4AqSy4ZxzUlk+7u/CckMDoPmlGTDZaxwIYGPRw7T
	 UKGQb3fnoZG57mplpNsBpcq79ywkjOemLr2xSfa+3T4LzEANcW/GL0BzL6JjRLxJrY1B/
	 qBHaS1ZBGvEDsT9qxwq+S7K48lq6jsb8g2bEIrgESRG9deJ+WqivrQrRGP9prQnekMBJ5
	 ibX/J6RlP0TCE1v3ar7z38z/5D9RRnOMas89q7K291Qfq8tBTz+FT+SUshUuCmGUx8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z6b8XUkAe29Qbtx4GPrsYDuZ84bX6oCBHUSF9JuGiVE=;
	b=XJ42uevnjdCSI9KL+CdRYVDWmseyPNrweFHEEQVpN2O9sfx1/qyRSJBCbSVyvpNdn44T
	 zZBRAlVm4D9FO/xX6FVeQtQ7uNAp5bhVDHTzltkmT9gLXagFwZO7NI6+O00xQL4JV2B5T
	 K2BvM57KMvFTyyZD1DkWc2cGk0FzPdSX7sceLRN7Lq6H2sUkIpbNjGyrLnonS1FgY2lVs
	 paB5QDAvZ/xW9wNfmdKrn4wi4jr1WOWTUHlTPdkpBwOtCE+AIJeQop8S3ARqmHEBMAgnE
	 l1HszqbEDFa8X985FaYR3egU7Izl3fwZkbypHcDYONhrcqGSKnooma544RSsht+I3TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kgbgu55N;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E360606A32A
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E360606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kgbgu55N
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so88878435e9.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795692821; x=1796297621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6b8XUkAe29Qbtx4GPrsYDuZ84bX6oCBHUSF9JuGiVE=;
        b=kgbgu55NJWqtsl819u2td1h3BTQU/9so27oCJxFth9UtpwHASiUMZJXPMU3X3DVX8a
         XHYpyO1Bj9RCj0FdM3Cv42VJb77av4BgmPN4oKfcfnO+RQRyWv8i6HJOHdbIavx0s7OW
         4vGwxmmNQFnOsfhlB2XpUcy6Xc3cMs8MusZr4djrwqMIJxhhSNL8j0W71saUumvV9TOR
         nwTh2CHjddK8k6Y5/U20tmOc3A7iiYaVV6pCEq2FG5cH2GkBab7F+sc4HwMI0pylQotO
         gMfaPP3WQLcBsf4nYys8Eok8jEEiJtdIniAXp9nQm/gXUO5Ie33WyjbOmXpd1Y1FmCS/
         HYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692821; x=1796297621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6b8XUkAe29Qbtx4GPrsYDuZ84bX6oCBHUSF9JuGiVE=;
        b=K03RBWHb9VCDWW1e3ozw1lud28yomoA2uOZHmNncg7nMsFlj8/W6vGKnj9fw2y1i4l
         RVdZRxp887nXytLB0pkjSOPGQcp509pn9n9iVN87dWrFmfqa15Kr7ZJAU2OojN+YGGh+
         xzgF/dEL6Gkvd7gTgDhY5eCFZ+/yD/ebUr3nIdMtrknnmBaAUaHBRPlwA2P95pzpUKGs
         9elt3yqPvYQBLOcvcR78ojQ6AeKzdJo/53EsxT0gocguufuYP0R/m4C9Y9vLmA17ld9h
         ZB0W5VRqvQLgVSTWHBvNAXDt6/djE1/ZKvqXNCQhK8Ao0f79NACFLglmwnfmcxylOzeH
         NARQ==
X-Forwarded-Encrypted: i=1; AL+hErFlTXmF/WpcOk0Jy6ddYp9OlENeAB8JUXQTvHlV9WlvA3eTSxw0yH0LPQi9OHvrhbTF2GoBjGeG8g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+svsq4slSL+nPhu6mfsLQghXhr60Uy8aA2ptv4rGNm6h8B3e90
	/jgsuv5HO6n1kciFB/kfNfAmCTJDxeCt/1WixxZm411uznWEVVNk5mYD2VL2rFvKvvs=
X-Gm-Gg: AZFdTZeaKo3kjyo3ieum1ylfXXjFk2BwEvvC/7RJAQgAc71ZjaSc8CGbJtHOE9G/T6l
	5GOW3aNFWQaVvI7h7no7zZcMuP3ITvTyce6Pucg/0JQ3k54ISB0TD4bMGCB/Ryo62rrtiqm+MU1
	v318NhJ3P640Clo4FW8hvvW7efyANqwmJMm5OxioYrr4qy4EA+0S/053HX7OXQQaJWtitYSYigu
	LMHhbNZUBJ/OvPxXhBA4Hupz0CfT/YlEDl1Y4oVRmuBt5l0VjbFAXHs0dFTjKZ4qXjtWjr4dg5k
	CbhN9BxuzQrR6UX6EFqpwpWcJg6dWf/ynptj4v8SG2we2+EFak5lpgHocBP0A+IRZOQLeIdJ4M8
	CWfHdhKLBXdFpQu7EkwJFfVpX8FskbEehPl8BilmhLPIJBMUprgbecDjn9DALP8cJn71pkbauXV
	a1v1vMq0kVKIqc1RIGMFGEf4H3USE25vudd5cbTzxI64lRaoQ5jV9/aQQoDe7SjDceY6SPkJg/2
	+X5Fh6pD4q4ESnOxZBSHSOOrSn1A4cLGOke1cpF4zAmKXum1Z8sBPj71zAAo7c/D6NOikedjSjp
	bskqKKjQqgKQwh+q2Wkh04Z02ga8qWRtT/dRTQ==
X-Received: by 2002:a05:600c:16c9:b0:4bb:7ad9:311d with SMTP id 5b1f17b1804b1-4bb861692a1mr322942735e9.19.1795692821256;
        Thu, 26 Nov 2026 03:33:41 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm36638402f8f.23.2026.11.26.03.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 03:33:40 -0800 (PST)
Message-ID: <65f7bd9f-b8ea-46f9-94a1-5129268ead0f@linaro.org>
Date: Thu, 26 Nov 2026 13:33:37 +0200
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
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 Alexey Klimov <alexey.klimov@linaro.org>, Peter Griffin <gpeter@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Juan Yescas <jyescas@google.com>
References: <20261125173959.2198116-1-christian.loehle@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261125173959.2198116-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


I tested the patch. With the driver loaded, all clusters now run at their
maximum frequency (measured via CPU_CYCLES) instead of ~200 MHz. Lowering
the hot trip via sysfs to 55 C reprograms threshold 7, and the hardware
then holds the CPU cluster at ~55 C under full load.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
