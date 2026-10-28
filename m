Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192511;
	b=YtpSLuB1bUyeaN0fHvYtBKT6ZIYhRNiQpenRxJp6DcvA0TDzOOFeqYGKDw8LU4JmPCpA
	 GqlHhMpQo+CyFxO6+mrAFTQIT0VjsmJ1llWWvWxdr7YC7OZJSo+7L03rsRBP58PBQG5ZK
	 I12IKJ6Cd4b6Mq1kkGxIILIjrpmiuHiD7DLt5wj5Jo/jucPrvwKyrfwsidBy2Ilx3IXk6
	 2z/HITZUnAW/vb1mxqKdofCSalmXfTg/mC8gYhw5A+6fDCvMwujrZjnLsHT7anupUZ8j2
	 UoaTeCqGb9BFXcqeSyaWLFjQxWKGXmRmiyHoY3nKeoBn6t9aAsZlWzOEZ7LmwqtMWYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192511;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2s8hbBcIbYi5ITvf/mtBJDRTfD2CW57Z/I1IxHbdhm4=;
	b=Xx+bPs/kGWNwG3nybDRiar+6uJQce95h40PmaZQ6a6Eh3TNjdNdNeP7ugTXwO6ZcWebP
	 JdYZibweqpsQx44uAEO24+4g16DbR5QCgigx4z3nLF+vHeurVvbh0zJF72mv9urLcBvKR
	 SFhk5PWEEXH2k+wlO4a3krAR5R4WmAnYkkbQR63CJs+fRtn1LOIhGqA8DnvxqTIHBVtD2
	 v4Oy6UN4YmuwtIm2HNYD5KQpvYWZwf0tyHq9rlKmWESyhI3bxytY0FUAWNeD1Gdt29Nx9
	 PpLeOYzQ5JBR2TlNvcOVFasyNlJDMD3Q++/6vN/FDkdnHyXzrBSi/ns/dJoaIsJ8tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgZWipTv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA69606A31F;
	Wed, 28 Oct 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgZWipTv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2AE1F01825;
	Wed, 28 Oct 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192511;
	bh=2s8hbBcIbYi5ITvf/mtBJDRTfD2CW57Z/I1IxHbdhm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GgZWipTvEB2/3Zvj039fdzq9q108ATG0cgEAjSluQmUkmz7AUaZhdRhlf1zAfjElz
	 W7VIXrUS8QKRtAo7Qjn15vUqp1VwdWFm69dHU8rG/A7S5Jdu+vJRh9r110TKuy3OzT
	 mDJNfL0xDSErMr33tXEr9AblKxBv0zWtuFC3K3aRwuCSMhhQT/MHrvArSPOoGpTGS3
	 zLlMK5ahRNcfNd7Ax1rc3PT//9SlaoxWgmCthVYVvUTEO8i5XEj+/Z10VRjDw1Vgob
	 uFIwY8y2BFv6pp3i8nDSCOsNLM2+XXiUDgArFxD/igAvYlEb42Qyg3INFdBNKLlAnB
	 Lp/t7LaTW4mZA==
Date: Wed, 28 Oct 2026 14:01:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Khanh Le <khanh.le.xr@renesas.com>
Subject: Re: [PATCH 01/11] dt-bindings: pwm: renesas,tpu-pwm: Add support for
 R-Car X5H
Message-ID: <20261028-phenomenal-delightful-cicada-eb7bbe@quoll>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <8b2c7719c301a445891fc6c5309456327ec8a94c.1793026273.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b2c7719c301a445891fc6c5309456327ec8a94c.1793026273.git.geert+renesas@glider.be>

On Mon, Oct 26, 2026 at 03:55:17PM +0100, Geert Uytterhoeven wrote:
> From: Khanh Le <khanh.le.xr@renesas.com>
> 
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car X5H (R8A78000) SoC.
> 
> Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

