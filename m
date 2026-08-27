Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F2332917
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817060; cv=none; b=cx9lll7e3jjMHesOY3SDxD07zYrPnlSKutuwjSHfMOqGgVs0EBZgLqXSfW/mqmTaPzaoHLGq3Ur7jIpkYYWmns8fJ3HiFXsPsD54XonH/3OwV02iKQ1qTiOzONTabzYLhFc1TKUtIFyTXz0nQfab4yOp0PYeyhAFBAj78YHg/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817060; c=relaxed/simple;
	bh=/yGEffIVb2AqJDTiWtumihhK8BhOW3hi4oRosz9adas=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYs4/XKU5dmlLVpumBcvwIWN5TBRnWLrMncp3NC4rtqjSzZPSY02VSo5uEYsKMdAR/wH1uP9yQlPRUHX3R7Btn5YrOcwlduR32vAkyYxXeZ+91oN52uYSa4fZhaIDrAPc1EfBmvs42EVTQa/yuJpXPDHx37RgJBC8KJnv+kO3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9ydyh6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9ydyh6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457671F00A3D
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 07:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787817057;
	bh=/yGEffIVb2AqJDTiWtumihhK8BhOW3hi4oRosz9adas=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=d9ydyh6Z1Oo0JNZR6mfaIDqz/kOMSVllcGNpB6gKew1vcgYf8e5ECRsHviAI9DSzn
	 TuwFocCEJsRuSVIE5wGjIe8YRuYlX8GqQ8R4XwYzZATEzG8DJlj9pD3KFAIAvt+loU
	 praeYlVJ4bgkVKrYArYdv3yG+pkaAKL8zbqxh8fsgNvULo91AdpyipG2tW7H2+Atnn
	 Ub4w4ylfpKzndHWsVshhnZo3JyfmPhUMu12gsBr/1eFU1uKe5oMWJYeBXmRDkEsR5K
	 AKTl4bXaIVUdxul48cDrn/ALtRWakpmuNI2aJuRIFX1Aupjyy1XeMr7Rk3Wh+usk4W
	 9j2h0K7k68qLw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2056633e87.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 00:50:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro3x8QYDE5acsXIxblyrJXpYkJ62QjeJoUEvZenIeWiJPlY1LBY12mlHSpnSw6XLEVpl2JNPXAJSg==@vger.kernel.org
X-Gm-Message-State: AFuF++ke5y+7BZsvcT5eFXPAgfRG9nMW32gIwQzM3RzCPL1cNnaWs5sK
	DCyzeo5k901NGLIFYDRtxDMcTXPHZZ6RBwt0XLqC71Dvm6J9yliuEwfmfjcaA/ADShEywMShXbR
	/nRqZZu657I87jHVPi2tHQTuQh3QDQqwKTRcpk2X8fg==
X-Received: by 2002:ac2:42d1:0:b0:5b4:73f6:1d9f with SMTP id
 2adb3069b0e04-5b4a90bb4a8mr3488516e87.22.1787817055812; Thu, 27 Aug 2026
 00:50:55 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 00:50:52 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 00:50:52 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260821-kuno-soc-support-v3-14-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com> <20260821-kuno-soc-support-v3-14-196e2b306368@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 00:50:52 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfumxz2iEZ=vYiGvCoe5+sU2Fdt+2N_77ZgQvJuLADejw@mail.gmail.com>
X-Gm-Features: AcwNN1UU6-WnRzQUnew7Tb3gj-2qznjwfQi-BvrVCswjSCg6fe3o3ZW4Upxhu10
Message-ID: <CAMRc=Mfumxz2iEZ=vYiGvCoe5+sU2Fdt+2N_77ZgQvJuLADejw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 18:09:07 +0200, Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> said:
> Document the Qualcomm Kuno IDP board and register the "kuno"
> codename in the SoC naming convention schema.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
