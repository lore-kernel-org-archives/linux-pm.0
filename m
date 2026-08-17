Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1F3B42E4;
	Mon, 17 Aug 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951516; cv=none; b=IgadMyZUZL+tK2X4Fd+3QpsY2lBPPGIUyYmjhvETixByo6m4z4nFq2qplvSvhupBUR/3k/Y6igntyp3bB/WXLvePs08BhkeujjpGQ4AtUFmWvG7FuKQ3ln/Zfyd7SpwD1MuKRMQ13LCCzBeCvaRqrftIiuMq7NwETOF5Mqa+/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951516; c=relaxed/simple;
	bh=mPZi/ETCDAY5SnkV834hbmDwFi+58HLYx7hyrVyplk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUnNnbxDCRjhm6Q2PAEDqpq6J4kPK3R87TynkA9Z87ipZQxOP1PrQ5ljoYBodtMCTNj4z+w7fJIknNMtiTfgsXlQPGy0TwOakDckw8A8s0FPZYTmi/9tdIThsi4CJjUtT1bNdp8/Qx1rl8BjEp8gD7QnOLzYT/hqywqsxl60b0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBkBczkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBkBczkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B671F00A3D;
	Mon, 17 Aug 2026 07:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951514;
	bh=sexVLaAvus5i+4QbLxv9ZcdjQTc6DH4O0Hmjp+yRD1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cBkBczkgjJDmUoHfrp8HGEZR2Id2sZaSpmpYVmRamLLdwXZ3wzlONtL0t9CPxvw90
	 Lvr+rRcyhn4f/2uXYmIl7Fmjgfc0ldz46XMcHQZgmoMGdk04qPxr7KQ5k7dI7dP42o
	 Dust/XoKLfcrQTIFGUs1Jp6PkRitBEpTBaXhK5eOFumvk0iekWJM+8B4EijorUj8RU
	 skXAX6fxj6NB1repo3TNSekp0hWSNKKJRNK10dsoDxfz3vyZiLwGFEaGqYIQZH65JZ
	 41g39uNW4qdHvmZyF5XhPix8dbpoZjt0UWisWXHwgDIAbgsXOfQn/g0wjPCcoFtETw
	 RTFdnuS1jNHpw==
Date: Mon, 17 Aug 2026 09:25:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 04/15] dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh
 clock controller
Message-ID: <20260817-gracious-infallible-duck-1dec6a@quoll>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-4-3079794f0f73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-kuno-soc-support-v2-4-3079794f0f73@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 01:01:35PM +0530, Hardeep Sharma wrote:
> Document the RPMh clock controller compatible for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

