Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D31282F04
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554479; cv=none; b=hI+JnX89u8RJcNIJjPl8S4qc7hzUmWwE6U2uXFgxY3hvA0JUZRn73VmBe15t/Qonjyagvmmj/M35TC9OZuBVoq2MsatA5QsI/3h/1PYQj2raC+8+YS7fsuwTsU1jWwzyPSx7pbnqwD47jJKpiVgFnJOUX9I3HQrrUME5DIG/Ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554479; c=relaxed/simple;
	bh=KhRQj+iRqtW+9HWFZenOFSuPZ0WQQSN49Yl9CqgIP6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FZGOx78Vro99k6JaRur1ymmE5+B4gu71Y29WIekhiNFHUY2q95OvoGh+sCJ0hlKnoaWwoa0Ch6fqb2kwo3s0fy4lytiz1YvdvAAWYzDUTwn9PtvY/rQa1gtM2uuvMotNR6VkeYLdltLZvCQuMbLDOBa1JheOe9r5o+QKNFbgF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ttx6BUAe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ttx6BUAe"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891f625344so10087265e9.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777554475; x=1778159275; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvDuNaRN8hH9izY7kpqOKXTCHfnDxHlyvhuaEy6Gtkk=;
        b=Ttx6BUAekpqaGc16Ygjpw/uU2dRApAkiv3xEZObvHlcKWC5otMLkdORqENVRXZaJxz
         0pnBJd2FuVIZXxBe6Led+GIDxzYGoTlSaNE0NoaWdbAR/6KMvzfuyk8cHWRCBd1Rsi/A
         0XrTFrIlAoRVazq3ThcTRMFZL3SWuRdrKPmOvftVEexLSEYzEALy+Vx53YgRzAjVX27J
         FZj+iDDY1EvD6un8sRQ94LWTNG9Y8ZnFD4OCfD/BsXH9v33Yyf9t/TRX84c9LdLEwLwJ
         DauQlxuv4zVHq4ZwdxE995o0BvgMbE+cseFlc6S0XXQgXh6KRUyR7AUPjQjwoNj7jAwz
         m4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554475; x=1778159275;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvDuNaRN8hH9izY7kpqOKXTCHfnDxHlyvhuaEy6Gtkk=;
        b=puLbjpPYR2gL8jwj3QTOTXDm88FQee2Xs6k/hjZFMmvJrTKpQEDeAD9gNIl5CBR8K5
         lwTZZ5fDBnsKZM1o06+tSRVuLGItZ2PtXxeo6vwRFCFFV9tI+g5KggkeuPlJVIQ240g/
         mlUaAG/ZeaKSB4OOzzDXnn/uN0bx3FVwQEVjPPsxPh7SFq+666bic0COMWIyt3EyjLT9
         jypywTmue6TcTiqN5hFeJrwSSpuXgbbcX/+wcvraLrXKwgMZl/lXjWD/MK/qU4XuFg7U
         DvNg0dkoRFRhMwfeeZs4WMgSCXu8mBvZ7BFnUcxzeIBZ1dvq8NeNc1Etk+zurKkllum8
         9bCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8M+RlIhZjtfWapt4IMecQ0QZLrj9pSIky2gbwKH87kMsPVm6j6EbezJ30fW2aHkU2W/wdf0gCCkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYV7p0ZZ7A/D2gPGdL5yK8mgQw6spNqY2MOVmZs5wuXF9uhb4e
	Rk9HxtL9mJD8yS+4S07w3oXmqtQ04r9d8ZCSAl9zXe1SOY9ZRNyOOc1wv1LZQO1rb2I=
X-Gm-Gg: AeBDievW/Ul0nps+YYAJfRNMGShmEXZrdLJomsFb86jJe3wHUvYxapI+nKykQGXCRQr
	dKQIEYrq982MyrEwITJltwPXxVb3AK3MSvnR6btd2z3Ar5rReDI7u4pIjHSJOJfe5Z3TTvVP4Ag
	Wwt8uyd3xnTcvccXqH2PL4NKYliA6HoFvC454xy9NYlAF7HO8TnCERyR6MLzOmRioNAIgIjnAXa
	Qxj1H68U+cmX0499CGhDHsZx3BwVpM9Ie1u6lYX4AsF7TiPXC6oNw8l4UvlMh/5isAe9xTBx8f7
	6Z5oxWoP1xDzPtZ9PdupuCcndP192Ie77EdVh1UsqWtV7AUwoGLkdW5I0gfnE1T9UO3/1SNESyA
	zoDMe552KSJLPF47tDAzgI54X01yP87RLcSRsAHQZk8fWcC36HkH4bhqUTWy55Co05mVXqXgOWR
	fpbyBoW43dyCfmCN/Rn5t9LvUnZnAEZU+1CoL3yOynuWGgCJgM/YW2bMzlJhqeAwkx26wBB0mmo
	EinTr19k5q8Yhf3c4ndy6QfXQ==
X-Received: by 2002:a05:600c:4b1a:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48a85dc37c2mr23717425e9.0.1777554474275;
        Thu, 30 Apr 2026 06:07:54 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:b0e1:a8:4337:b2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822d4a9asm71861585e9.14.2026.04.30.06.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 14:07:52 +0100
Message-Id: <DI6IGZIW2HZ8.OBLZIORMOH2F@linaro.org>
Cc: <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/11] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Lee Jones"
 <lee@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <20260423-acpm-tmu-v4-8-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-8-8b59f8548634@linaro.org>

On Thu Apr 23, 2026 at 4:22 PM BST, Tudor Ambarus wrote:
> Add driver for the Thermal Management Unit (TMU) managed via the Alive
> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
> Google GS101 (and Exynos850, autov920, etc.).
>
> The TMU on utilizes a hybrid management model shared between the
> Application Processor (AP) and the ACPM firmware. The driver maintains
> direct memory-mapped access to the TMU interrupt pending registers to
> identify thermal events, while delegating functional tasks - such as
> sensor initialization, threshold configuration, and temperature
> acquisition - to the ACPM firmware via the ACPM IPC protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/thermal/samsung/Kconfig    |  17 ++
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 547 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 566 insertions(+)

[...]

> +static struct platform_driver acpm_tmu_driver =3D {
> +	.driver =3D {
> +		.name   =3D "gs-tmu",

What "gs" stands for in the name?
Shouldn't it be called something more acpm-ish generic like acpm-tmu
at least?

Best regards,
Alexey
