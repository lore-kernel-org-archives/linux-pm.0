Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41904CA771;
	Fri,  4 Sep 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533430; cv=none; b=OGNjUCI8cI9bkht9p1mfcVtatjlirmDmNGCd6ulmwnn4hK2yv+3yDVaQi5C+Hkkket1Quh8ELRK+oR0NmPnnXPbR3paatK8M5CjYNDj0hS/PDX6bq6TlioZs46+YynG1t+0uodEhalVbNeBjpY/PnwOYbrpgUxrTttyNEmMeLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533430; c=relaxed/simple;
	bh=8ojOrGp13esXg76h4gTL8CQTn5Ov7uDdomCjzDitXi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOuINSAeXasNDo5iat4fEkuS2t2pksCkwgj3U1Hp2lkhscLGaNEXn8nJ8UeFRFtziM/efZnrm18mbHnXxDU4qEIm4OQahxDJbfQuj7UPp+3wDl5Fg/PVgc2ecVPEkfKa/yYMq4xDWJ3XIlDACK6N82X9894UvXO5IXtuFQtSxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERFnMCX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERFnMCX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAE01F00A3D;
	Fri,  4 Sep 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533429;
	bh=+A9vTFErWfQT0RtCnGKfq03NBjCr7KCzxcGcktHMDQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERFnMCX2zNVEuOaXAwLazkhogMvrT14LMjH/m83rRv88+dPJLGzjJRh9zjPS1zWXb
	 OdU+AMylNgfqQbitJvYOm6n9G90SQ6+qXAEH2VhEKfBUP4vKCHLviHFhc+RDBTO+0p
	 8px9SXQFFy3lvHTUTemU13jnF55xDgxYUju7NigbZPmjxWUlWlnhmJG0kvFmFqzJud
	 OXKgTeRsIkbxRxQ9az6v163g2nk+JxX21tUsBCIoOJ1Z5jSqaGbSP20kVLo+Wu3Kfi
	 8gnZUp3C1LG4op9el7Sjq4yvt/i2d6LyO7sa+xxzJ3rN0xI1cW5M8GwMZykaGkVo9q
	 eEtA7hWBeLEYA==
Date: Fri, 4 Sep 2026 09:50:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Radu Rendec <radu@rendec.net>, Brian Masney <bmasney@redhat.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 12/15] dt-bindings: interrupt-controller: qcom,pdc:
 Add Kuno compatible string
Message-ID: <178853342626.688235.4218772368232817802.robh@kernel.org>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-12-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-kuno-soc-support-v5-12-6d47636a8f09@oss.qualcomm.com>


On Thu, 27 Aug 2026 23:21:15 +0530, Hardeep Sharma wrote:
> Document the Power Domain Controller found on the Qualcomm Kuno SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

