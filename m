Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4C3F788D;
	Fri, 28 Aug 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911130; cv=none; b=h1NCcKoKZa9HKGkOaxxFzKKf2VzDZjMTmlEXX+jdMFtYHfDKjyteJ9Qo8+2x6XrUemsJwo4A4Td5elgZo/cPZt5oi2YgI3zlafyNCyO79ZFKUeSD5ifWh+7ptqbY33zE1XEJbJoqhj+olpc5kpw58cjGLZP6lc4huq5ycMILzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911130; c=relaxed/simple;
	bh=EOQHW02wH3mmUfCF1pEt5p7MY/dNlyjR822z82sdJeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGeQjXUceYk600EoiwzdHrmN5JGEvWf9/l9V1ILkN1lVtJTPe07nc8wV2prsJlNCXiQ7XR4ialGix3UrJ4ZShoVTPmcMT0NqsBY0erlG0ZjwsI4Kyk3WRPd1wiVzqjb+qpxNmGb8G7w1NdiScyK+Ge1Iu92S+USrseEedDnyb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNPlBWHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNPlBWHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B6B1F000E9;
	Fri, 28 Aug 2026 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911129;
	bh=RiC+qrpvjqHANuuP2A1Jc4rqodYlVemMvqXOEB4WrvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jNPlBWHfrdXI/Aa+bygrsE66r2FAgL8G7cpY5FNR078DWqNqaj4IJxQQf3Y7vD1n/
	 7xrGkrMuRztBio4Gv2w9BXxS0oADlBO1TgstD4yyWrW/oR2ICQvwd5PEMa13yHKW8m
	 KvNsAx6jF3Gc/6ROe4VQaZWN0/Sm1YARZ5GT4pp4+bEXHv65xnp8LPyD5nJy/qP9ui
	 aYskG9ViDWwNj5jYivhbxSZOBCCBV9+0iR+K16d8LfghrSLcqtR9eyVWsJzGyYLSja
	 IDbf87L/u+qfIsiP5QdrXONpfKXa7aiH5DJZOK43DGCReql+sBo/HvdfLLLYRqLViN
	 A+qG8p3LM8EwA==
Date: Fri, 28 Aug 2026 11:58:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, 
	bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Message-ID: <20260828-holistic-spectacular-spaniel-f536c1@quoll>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-10-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-10-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:52PM +0000, Sreeshankar K wrote:
> Document Kryo 475 CPUs found in Qualcomm SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

