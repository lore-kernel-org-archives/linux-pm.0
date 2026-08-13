Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64F451076;
	Thu, 13 Aug 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614099; cv=none; b=HgnjtUbmwiSEA8uJrJvejO/H7tTJ+huGe/yk+urcHY4fjNAxIi7tC3i19l6YFsp8Ya4p39W17N2IRfbttjRbdk6eerp5EiibuP7QfaxY74znVhhldLEbkOXZtxO/U6g8+BUC7RCrUi4VsRmiIpq34n+JqOkNY439Lm+UTFuuzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614099; c=relaxed/simple;
	bh=Bk6mUWK9sKfAXi/AQWVfvgZJsbfaEDYanxKhg6OBuPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOi2XU5qvsAv3Xnl+gl5a5OnO0aN4suKgyTnDvbJTsp8Rv986oRlcGcLqH269fFt64XdlRwLVT5A4Y0xeTiWLaZytWgYx43z11iz4I+WahK3ttD1YKFzQTysW8DRgz9gx+G33X8v3RBhH/3/FgZASt90imHXfHJpcj/QyWjSBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVM0AZzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVM0AZzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CE61F000E9;
	Thu, 13 Aug 2026 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614097;
	bh=zTHVpiTVGtdufqVOSNKKix47+qzymCH6tF1w2mu3xKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVM0AZzCHTtCw4yxKyyFYkS9HasBmHZ7Xw18S0yFOsdnuQ3RHfze4xp5qSwp5zSpW
	 dEDNY4OsAjA/EMEZ2/+cxmNp0CfBpN1aSuagaswuur45Xefvp3srZSqZEtAdfdyn/k
	 aXfsRA1C9VZum/273hA4psXuUfpGzAuA3DbG8iq1BkLoSdA/VTqCyfuXVh2GHIIb1N
	 Zf9YxG20mHkkfIJHSjiie5wp5rOmPQ1H2cIsIEyPONQgCVJYtl6L3vGgkrw9OxdtQK
	 JcDX3yEF3Vp42+iaRpjsg0z05hMlI+ktT/zKXxs1zMCE0nmm8WcRGcRN/D3yFmCQ8K
	 9UQoKkDb1nFrg==
Date: Thu, 13 Aug 2026 11:41:25 +0200
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
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add
 Kuno compatible string
Message-ID: <20260813-mindful-imaginary-dragonfly-c84adc@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-12-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-12-5e0ede4a0c72@oss.qualcomm.com>

On Sun, Aug 09, 2026 at 12:57:11PM +0530, Hardeep Sharma wrote:
> Document the Power Domain Controller found on the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

