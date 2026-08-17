Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7B3B637A;
	Mon, 17 Aug 2026 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952047; cv=none; b=dam5ORcGZgXUzRRwyf+5BHHrxSPjDEfTWRGccFrhHkZgBbawVqSn2wkhAPw8s1Si6RJVyVTP/0GK5nQwouPVlqtTM5ogvNU191D1ZtNp7frl5sliA/2XiiaxrLwiMWS5K+XilXoixFU+8eA+6fNRe3pMheIpqMn9+5TUkKvJS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952047; c=relaxed/simple;
	bh=Dszy4/9tDthveOtsOy/E1oMsmq6teUORLcUGmmqahnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A77/MVxKTzhHTqJxookVib8tcUhbJg0d/CY9a2lvHxLWf5zxNqGKHC8NY3wwNZ08LVi/W94n8taN4FP6Xu4USSErTOVT/2gQGM/skIh3QzPmsc15jQBTniDD5bQ56+eZjxBZ4eaHE+hlwrjGCT6zqSKshQc36StfCdK5WG6JLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZARyJkKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZARyJkKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3C01F000E9;
	Mon, 17 Aug 2026 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952046;
	bh=OELdZFUCLGwyaUwNs1yktw4XPR6jAfb0Kxz4TG0SrYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZARyJkKya+vVkGWpoZI+yyEPlL8TLgY+iOHfKRJSoz1bfrDJTiLZCPyoff6mzVlFW
	 hDdzwqJZSQZTTGJDkPTo3h+/wx38UH4ILx0bkJ4P3LO5ClxEywQFf63yhCl03Jr7CC
	 oQrZf6q3+HTsu3lwQ/6/l34cujzlpcz016QabvWY3c8Gvs6H0rqBM4fAcaQidLlisv
	 BBZCr8FwTmb4AwMO4Xriz0SKQjslyUAhN+i05DEnIhXK7uuXwf3njb/J02YqgLhtMd
	 zyB6NbL401ORr1ekm3RfuWAdJhtdoV5a/Pgo6q8acEfnJ9lu46Wes+/FxLmjvoMZOS
	 F++3N1P1PI8fw==
Date: Mon, 17 Aug 2026 09:34:02 +0200
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
Subject: Re: [PATCH v2 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Message-ID: <20260817-authentic-watchful-seagull-fd6e3b@quoll>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-14-3079794f0f73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-kuno-soc-support-v2-14-3079794f0f73@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 01:01:45PM +0530, Hardeep Sharma wrote:
> Document the Qualcomm Kuno IDP board and register the "kuno"
> codename in the SoC naming convention schema.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
>  Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

