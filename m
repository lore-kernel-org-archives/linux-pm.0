Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C43BA237;
	Wed, 14 Oct 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975321; cv=none; b=UR7JzhYuN8C7SM6wAos8I4wroM9pdPVZB/+/KCIdQfXMMJE+ETZ14lifzGr75zL22HXG5Iz5QpvAXSRsWetnDovWq0W6ZwFh5MQgjHRODCIH2tA3YzX8slpQVaguElwRHoBG2/7HUjUWY8kglDV+inaJ8fhHrkzbUFtb96on5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975321; c=relaxed/simple;
	bh=crz34n0TJ3MvmDEmWUt93ljg6zzV4R8+X01ZJK1wtds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQCMjutD9isHHP5I5MUZbgRkun64S5eniHySJZnFZeCeVOs4R0CFnbJv0IqOtt8uXTiBIL6Y89StJm/bIsWKXmfHUAbOFredUZa6omG6MjtNuy1N31WI95f3mFEEMvv4NAsRrQ9ZwNSkhyJcpTw7Qtb57uDxxlBNjwr1sMWxkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0QxsvaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0QxsvaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A0C1F000FF;
	Wed, 14 Oct 2026 10:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975320;
	bh=vswIt4pH1ZzQKTGqBpC4xgzVGE1sxni+SHS3dcFA0tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L0QxsvaJ+/IDbpOuRVIXMbDoDCIkzEsvhOVU54IbZ/AyqfGHO8kIuKkfPeIHXAiVN
	 mKBWMbZ6GnFahByOUbNrL4MF5dIwkpnDYI082j756cxTur6wADj3lY7jI/rNyX64oS
	 1CgMDTIsxF5KQi3ZcsYIzN+qZWOdcgQx7Y9zaNM8pjVIlhrro6aQLpfKAI6Gu8LnoG
	 Icn20sgTS8moX73R3Q3kJXfBEqXWPZA2roB3MBklSYngLa5/bBzHX01TZXR27GoQ6J
	 oQtxWRjs2VJ6LgnQdflNar3NWhlpBgZfuivAd/oO9c5/ZmAIl3G9ZaxlE3lewOGq1x
	 xTEHLnNZCjocw==
Date: Wed, 14 Oct 2026 12:55:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add Qualcomm ipq5210
 support
Message-ID: <20261014-quantum-artificial-stallion-aa6be4@quoll>
References: <20261013-icc-v2-0-196b219e25c1@oss.qualcomm.com>
 <20261013-icc-v2-1-196b219e25c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-icc-v2-1-196b219e25c1@oss.qualcomm.com>

On Tue, Oct 13, 2026 at 12:39:43PM +0530, Varadarajan Narayanan wrote:
> Add master/slave ids for Qualcomm ipq5210 Network-On-Chip
> interfaces. This will be used by the gcc-ipq5210 driver
> for providing interconnect services using the icc-clk framework.
> 
> Acked-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq5210.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

