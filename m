Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D1480942
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581143; cv=none; b=kjfF3nsRXEiwj0D4sgabTtVIOmTOs+gRpChfwTbsYXqXL36icUyaPxeucz6qEreAJHjAYYpNtdEGl/ZPRquX3NaHsSMu748RfvqF9bBL1D93xBDbsFHqpOd9yLVj1wjXVLHyzETj+I+D5STtNpf4W7ty21KHZQeSMAihq7lLgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581143; c=relaxed/simple;
	bh=ZaY5vFxG9aYZCmRrkh4G6IJ/GRp154Miry9zwaOYwzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dBUGiwzME1HoL7HPB1oSYSIHkXfZQnTUDeS2eWX+R0/DWGykC5P24bgf5rEEsHan4Ub/qVs0x41HiWVqzB0voqLgOukKJIz/6NEbfBVCuozPqV74Et5OTWzDGeTVT6w1S5SaYnJoPzSjTFl8AKnC32nOt+XiS5HHIdYrA6An2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9mp3cGz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9mp3cGz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45fd45e596cso392023f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780581141; x=1781185941; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr8tJV7XonRe9aqon2KQXf6etaodi+ES5SfBfdU6e68=;
        b=q9mp3cGzn3h2MhRK6XrbG8QMIeXE841LVChyHfXx/v/cDtiOssHcUex4ij4no+uRjD
         vddVlYmG1cGOuUAPBPAAeEF7trsMjG71cu3014VC6TONpgcIj1tfJxm+IdvBzCIOTh05
         M3n0i60J28z1Ii7Y3YtDSm5BTi5YGXjyJv6FzBUPCcPbLeOPPlZ5kWC1qstA4yjSUd7S
         Ix+TjKzndwrHsTgVOoV4H3gD/CKW6WTGMfofWnUiiizqAwpyJwfybW5wO42UJWRMqLhZ
         sb0s8gZAEPhxeUmOfnXRW+dYbPpJ8rbeKjc5knoo4qBC1CJRnHtGd4yJim9yf/MWcxhM
         SyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581141; x=1781185941;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr8tJV7XonRe9aqon2KQXf6etaodi+ES5SfBfdU6e68=;
        b=AmhT1j6rfQfjLGzcdyoYy0HdFYSOSwmxogdX6SVabmYSkSx04HXQFAN2Ii/amOcFJ/
         GHEOBrHKaHT2TSwPsrOtJsVrzWkzgaraClWni55pKvclLkMc5/0b6zu+JL3cyxO6OrmL
         N9FjboOKNaOJ5tMDxae4JyjbLwA5q+JPb5AThSsc1M0UxNLDtOc4ylU0NaO8y6xn27G5
         AJzwKT1jgwjUTbjTzwSxv4brPb5ZiuuW3VTKD/EBhySCLkU9D7bX3vIcmEU0wlrnpIVy
         FyVOe2cpw9raslkVs5eEm6zWG+cEhptc3Kv0rihWtuvLxvTuLLagINrxy3esCM7SEUYl
         Xtew==
X-Forwarded-Encrypted: i=1; AFNElJ+PmKbKW/06M73+EAhAvHRWnxXgdY5lYx92Y1TI/LXc/BoEG2AjRCNXXF/2DeLGZETo58xHGkfSOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7Xva9dUyH+QpzwTlzik2KxNg3TNzFgo/UUhEaZBOY2lZ5IIN
	lusJu/mTJwg6OxRg0qn29no6SZ9p7ArqZC2EZqNTaUarGu3LyYuNfpX7G41HrwjfOX0=
X-Gm-Gg: Acq92OEsREfNgoakRKQx13mxq0CgpI1vQ53iqiLaXh76UZ4AVT6hIrY9BSE/hNRWuDr
	aprHD1Uz9lFyrY5ES9379thLksr/wfmRy5fW+0/id6JjLYV1EBK0JBUYHdISRxXdkwMJZn0uZrs
	CMEnVomqBj0ecTsXWVwSXJylHA1fKpSmcZ35aIm+lE9svnDwBWaeABepo3L0IvjDfbotXpT91zK
	G5+VvJakvi5uO49wBg/lM5c6Eq92Co+ymWZzteAv4E7U4owEDkWgA4HIhPe5CHVnYOKqr8SeVHC
	lsQOU+oI3/wcamikoUXYTyDfrw9YMzAgryJbY+ra6hUisbkVeOABviGvbFsSmnilecPKRK01jJo
	4ottVpbJrWth6rX2gEqilZTEMJusE74jk1MDjTOQhu6saqVnIN7xZtPsGtocXhq2Yufj3T/PUJ+
	dHyokGwKIH+vRKTK/WHTHCWXg8vDCl+4QwFeeIa7DpzkUV9pTg7TY7lm38BPZbiTXwsAsickjce
	BxvG5NvktRgbeCavBshD8BQ
X-Received: by 2002:a05:600c:3596:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490b5edd71amr146656455e9.24.1780581140625;
        Thu, 04 Jun 2026 06:52:20 -0700 (PDT)
Received: from localhost ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm27268044f8f.27.2026.06.04.06.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 14:52:19 +0100
Message-Id: <DJ0BC2X0G04D.18CIJDSEP0PVP@linaro.org>
Cc: <jyescas@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/5] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
X-Mailer: aerc 0.21.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>

On Wed Jun 3, 2026 at 2:00 PM BST, Tudor Ambarus wrote:
> Add driver for the Thermal Management Unit (TMU) managed via the Alive
> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
> the Google GS101.
>
> The TMU on the GS101 utilizes a hybrid management model shared between
> the Application Processor (AP) and the ACPM firmware. The driver
> maintains direct memory-mapped access to the TMU interrupt pending
> registers to identify thermal events, while delegating functional
> tasks - such as sensor initialization, threshold configuration, and
> temperature acquisition, to the ACPM firmware via the ACPM IPC
> protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>

> ---
>  drivers/thermal/samsung/Kconfig    |  19 ++
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 651 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 672 insertions(+)

[...]

Best regards,
Alexey
