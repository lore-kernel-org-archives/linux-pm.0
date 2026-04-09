Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFC3BADBA
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737386; cv=none; b=MWZzkySU+hHN5JV6p0muPJur1xHdp1mX+K4zGmPJ+jH1DeaiCzGMS/yWSz9tFBNH+Jr/jcXG3OyNAIpYFR9qXVdkZGQB5Gff/PtswhRNzOCzDz4uAwF4K7wgpUo9vogOxfQZoC3Vtn0qrVx+yrb4sMq3S+5JLDRO3iur8eZ1X0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737386; c=relaxed/simple;
	bh=8ha08POWCdts2kcxBytAF07AGORB5Xw+1RHSI50iK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ2n0tzqsa9/GBT4XCfcU18eSx3XvrOe+A9PfWMX7rVUWGlqkAJKdEABv3Kc4TIbb8C91bu2eCEK1H+8+Nd01G9kW2IC13ya0ovtjxKoJp/4dIEV7efW23IDq+n9Edyz7tXKBisUaEIlrxctfsaWcZj3pBbhrXHeEIizrZ9mFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OEiGXjJT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEiGXjJT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso8421005e9.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775737383; x=1776342183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNUR+AEM+0xI0nm5DHe+rKxaeNx6oASLbxq9t2PiLlQ=;
        b=OEiGXjJTi57weYjl+rhiQNvazHT2ysm2cUX3YIA27lwwzCFHaPZbsXpndWn60MGp0o
         DVrrw+VtarCCVRX96UvNaBAu2z9v6pwvm+cQ84aZeFSTzzhdfGLmG4sbjVu91ih06F02
         YG1IWyi0Do33dl02HAxtBzlzteHp0xEOeh8yGzl4Ys+cc6vNPH2ndFLwmdi+zEfs8CQC
         7tjsLu1PQhReACU1uqhDjCumpcos7kWg+98w+V1ZE0kuM760A5m47y2gX+xDG5mqWEoJ
         ypTwtmZGODY09vjY0t4Gn7Qgg3Zs6KTrGMeKXyYeB+QM8446mAstDGV3Uq0Oxp8mPf4L
         9P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775737383; x=1776342183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNUR+AEM+0xI0nm5DHe+rKxaeNx6oASLbxq9t2PiLlQ=;
        b=pk2myNwtQUb9F5ZI1jyswwUlxaXZUDUGy3yO4P09XgYdBsYasXKYkqTpDcvYA9XCt9
         KJl/QHVSjcNjzqM3zTNwc3lwZ2TWVvmZa5cFScZWv8S9N/D0ufWkiZgLb5Iiu3csLsHd
         YtucaC1wHawo6+6WwPrtuklIuJg6GjkOK25dIiLIf3UbXSlXX1s2BO83Vp/HaNL7VoEY
         hQzeJ4S9eXbQL2Hmg9jDIYJjzq26SjlXt4YPrpF3gt4ahC4vHFLNoNzEPdNFl1JiRmwS
         +lSeQTsqW1kao/lVtzV+15/E3hLw9GOQ0dyt89d3gv54+4TlsoDES8IdjVpwlykqlLyS
         pbgw==
X-Forwarded-Encrypted: i=1; AJvYcCXuuCyVGFhMJ7f145VZF0ykWxUV6wuiqYVIzgEkl15AHIyONNyrho7VaktcnxEDkH+tMoBzMNi8+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEGt+3lbAu2wjBwynnnENNwWTkU1Z1aznvFkVVoJmxtQ43J+O
	99DsMCoH51XnnxweAOFqGC0qdwAhy6K9sjAZr+OHlIMCTSyErkwE/Ze6BzXF2D08zaQ=
X-Gm-Gg: AeBDieuamdIuEpRacukWYlqKNEucY3pyDSAl1gYTBWbJ2gSXYlweSi9ADY7/SswveaK
	a7kfTWwdga4Nvqw1T/cjEfME8NB8ZnbTUDW4pRD5LLMKrmrGvaGcNQ8EpdZ4Hee5mfDLawFPySl
	Phncm63AKQ6FKtvpYvDU6Ce/ItGe5XBA/NhGnCYK19LGlOm+QWftujWS7R4UPalqVOQIZWHyZo2
	fpILr+9fiSDWP5b3CJqDpt0BzPQNkbESOQ1omrSfpmM6jwuUOubztz/UkFflI1+2hLmuZ6ABo7P
	QvQ9eF2PyCvA8tYEd6BpHecTNLWGLvU0ANQLO4XFqK+Ni9ABlUXMdL4pOELCNF88OloM8O0E2pO
	VbNKrCIzQ9/2ocjbtZ90JB5HXMy4rSk065weDdCzrPLF80hLykBFG90UrTGtodIl3v7UzWiI6e4
	gjcIKw5i7+a1Q7Zi/f9kciif8EyBGV4uJN5ndHf8pG1A==
X-Received: by 2002:a05:600c:1554:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488ccfb7907mr47873215e9.11.1775737383421;
        Thu, 09 Apr 2026 05:23:03 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd21b604sm69928745e9.10.2026.04.09.05.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:23:03 -0700 (PDT)
Message-ID: <63087cad-a8d1-4ff0-870a-6e1a738ff8b8@linaro.org>
Date: Thu, 9 Apr 2026 15:22:59 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>, daniel.lezcano@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/26 5:49 PM, Alexey Klimov wrote:
> On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
>> Add support for the Thermal Management Unit (TMU) on the Google GS101
>> SoC.
>>
>> The GS101 TMU implementation utilizes a hybrid architecture where
>> management is shared between the kernel and the Alive Clock and
>> Power Manager (ACPM) firmware.
> 
> Do you plan to update or work on this series? If, by some reason,

I'd like to resubmit, but I got derailed by other tasks.

> this series is postphoned I can rebase it and re-send, for example.
> IIRC it needs a clean rebase as a minimial change.
> 

No, it's more than that. When I talked with Daniel about this driver, he
suggested I shall really focus on using the .set_trips callback instead of
.set_trip_temp. I'm not sure if it's possible given the static nature of
the ACPM interface. So it needs a bit of investigation, which I couldn't
do lately.

If we can go initially with .set_trip_temp and then come up with an iterative
patch about .set_trips, I can of course respin, it takes me just a few
minutes to rebase and test. But it's Daniel to decide.

Oh, and the device tree needs a little update on the trip points, but other
than that, we're good to go.

Cheers,
ta
