Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E723B38AC
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590675; cv=pass; b=uv+wqt+hzJGy68XUViiRYOgmq5/VX/4YZoYbze59RCznDXeKsfPQIEWwYOvAiJZTidf5ThAFi8iboplUGeacm6syiqrvITYYHh1FYNjWCIw7VksQsiLjTSc9w+5//hZ9CntUw1GjO7LpK2KNGH2/v+esPbkzsLOKnOEzjeHpZHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590675; c=relaxed/simple;
	bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XElQSB3p+zg1yMqKcYsofPhBIlnafHKt/CUFSEN3tX1ri7+lT68sUKwui4zzNVAqS1dK5pgLmu+bK7iv45xVSNB8S0MAwAtVu4+QaeLDFDkzYEIEHMhmpOa8fkxedq12ZjxZ78bgtToSn4IFpOoxUpGcztOUK+BiF1AdF/JJeCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYizWBKw; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYizWBKw"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so989677a12.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 09:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590671; cv=none;
        d=google.com; s=arc-20240605;
        b=k/ZctHf7/qWtR7zh2CFEjOTERPOANLu7ALN1O3Otuz7QqiYfwpLaX141PtRRF8JuKa
         njOFGO48myO6HFbg1lHBld9N+uKG3oX5URsd7n96oHQnc2IA3kjTkQKu9C1ijKV8CKvL
         m3cJoLneSwPpFD0YF0PtL30KScgeJvvHtNUDgv97Y1DpO1sKOxz49KfXANfJZS3fUtpM
         tFxx8WBrCd5FwnkcABsqAJyuzgT+9eSGEYB66x8d65abm7diXNgqP/pC5d1/L7mJfb+m
         X6WFHxkO9TO8jjpm/lh6/1/S4TAYjASXVkkjsMOoaS3duR7Z0jsxYB7pqIElugOCmr4k
         UTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        fh=zGU/HQyZhEa6cF4uaMXo7/1uW7SQF2x9hy4kdhisD2o=;
        b=NO95ov88iSlU63yWC9AhAoqxb9AOUYpNZU26Y9zokJapRcCmxXdPDcrSO/0hIEBA4R
         5imANjQsbk7ySZvliISlAEnKQHIefEfMut5TPGI0LtBhULjMlZmvCliPLtrQJBlwG5sD
         NdH2bfbDv1UJzvqbESVeUAleEHVkfrCqxQs3Czz+OVN85V1lR8kdziTwFxTEMzILjZoO
         5XPBNDqqB0OzznrmaTxvrpB2gBRf7vJGMczu+MDmjQ7ZX0vMTqzTV7gVv6baCR2+91+z
         wYC4WU/C6Qf2QhmQ2OXW2+90ypmWHI9KRLQrdqibqUkeuzK91LE4SkfkXWa9/XAnsGkb
         IOwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780590671; x=1781195471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        b=LYizWBKwjoen9RbPlZkKqVX9HO4ohwNYKnGU+2Q+9RjwmmNdoOktu4fQ5uxRDDajqB
         JqvjdzC53gLKc+JjhUzLqrcRERtB4d1WOkPgm/YeY18fypdqw8x4vfGp30qDadQFg+mz
         3menY9qVtgPdGY3X5rl6F639jENH31rWDQQcJzfsLyqg8cD+EtYv7kKJliuvNEbdZqhS
         aqdvEPZY13QDBE3KtMnin02ngDuXdHXs4Aj/y7mBKBgixCgVmSKkgsEs9z/tSMDYdAN5
         PZspOYoGtFfvUL9v1bvQSMq9dXRTaon4BybuK0CmCpAfUFbHN5URmAZ835d3n0w9JhWf
         3i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590671; x=1781195471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        b=n8dlWiH5nyFj1F1Z6hK1Y4zBw5sTDezEFdD5cDSgZbU6Rc6F7QBkuuW6+k0Ye08zmh
         Dyy7Gsq0MHyXFxpaTP/SkgQ1Raq7a+NJNgoHriW7NMH9GOwJ8na5SI5H1Z79vvOVrLOE
         o9TvgyvE8K4LZ6WUkyO4K6EtZBVxCUs9KRKAJWTuzeAJnmDLyO42LIk9nmZfgUam7E8+
         9xqN7bvWZiilLHHDafHtE0ADknJuJZiGlYfbLW/TM64QkTRnW2wjugUGYvw2WtNt9tdn
         qAl4X0Eu+Hme58GiNi6Fzvzx4/mKHhMfEXK+vnd7Ihw433CjMT6gjuNjq6kPv8dd9Zja
         yGJA==
X-Forwarded-Encrypted: i=1; AFNElJ8d0+h9JLajCiZtkZRxtVriHZNIJCCAk+LAVfOsv6h/emmGr4soAZFozjVNDg0zbvT3GMRr0AYbVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfI+fpncWQwGyIk4NSGOWhS2Y7dLkJc1wWMVLLTA7ziLH0bJ8
	xVcXh7A8hlVlVC9cDF1Y2eRuArPLIIyqanIaquBFV0apN5uykN/eRftz4/0Q1SWnEOXOHxVUD7l
	Lsg6KMX5ZwYLJsE7MZTATRfWBEtrZeL0tr90vgXKIVw==
X-Gm-Gg: Acq92OFObBgODwfiNC+yL0vRHhYmvSS1VonLWxU9RhX/A8R4uvBkeJ9TUL40A35IWYj
	66Bdw+AIRNNQCjJMfLVxlg7XUpxPpMqwPvcikcupwYkPtVE+eYirw0kjCMWIU7tDmw/2+Q/Zu0z
	D5+E/O7MMzRj2NkJU04TrGx8v2f7S2aHit+GbwSOIVc06rBEwtnCrVAhaIZl2OC5a12XQa8B8lN
	2dcn241WFuC/G6Ij21hhc+fOwCbjm3PxNsnI5D9ntU+FPjzdGu1xlc2XwVaZKNsT5zXiU+cdIkC
	T05kRQ/v+HhCJSx9y9qh8JDUljMHz8ZYwUaBPWpVvrd+OcZb
X-Received: by 2002:a05:6402:3215:b0:68b:539c:d269 with SMTP id
 4fb4d7f45d1cf-68e710ebc51mr4808114a12.12.1780590670971; Thu, 04 Jun 2026
 09:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 17:30:59 +0100
X-Gm-Features: AVHnY4Jq-Cm1FpMQ9NjMzo61aJ4t188OLXQIR-HELOPptilenf70Fcb7QJeV21c
Message-ID: <CADrjBPoHXi5hp9T=z97k4LKNKQUEnJdN4sSz5g+NgKAGC6jguQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] thermal: samsung: Add Exynos ACPM TMU driver GS101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
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
> ---

Acked-by: Peter Griffin <peter.griffin@linaro.org>
