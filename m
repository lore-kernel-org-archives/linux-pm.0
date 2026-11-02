Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608727;
	b=jCJ9LbGiSywkRleDmDIYUxyIlGW6r2Hh1TzrBHvKvcea4wTG1A/DUjrXpMUnJa+IDrXd
	 oUE5vUcZWqeK+Dt8Xo9EmMpfJQ4fdMdc/gFEUo/rnGh1QHRXrAfqPAkWMT/WFnxpEl7Q5
	 V4ZZhuPHrxRk57GnfWOWSVeVI5Vf1twvf9QR06MuDiKZqxd5ADRBhySANOYVGyitGBYva
	 NvI8+A6HNFLGfJdseAmuWtIReGuwWNWhKysZ3Jacv1fan8wuj++oelPxict90EHrd3Rdj
	 X2iIDmHUjW8mBtIdYrie+4IH2ICCVVGSvSQaQdOnZR/ENM1XZ3g4MA6HLucAWhqiflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608727;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UlAcYWzbjHUpXQjJDNvgvnYyYvPWka7R8SEFN1ktWbg=;
	b=LiVF7kmYBOvx9GptVt4dTDcuxDNZ/QeNHYWT7auY4HPzgKI2TyHXUeu/5x9ZLCIj3evK
	 zrUpgzsjf2TPc7ZV53z+Jw0A2g2mkLZjGSFxrg4/JdBbgRzjNTQ+4u5SnmHEN+2dkIiJI
	 6N8Lh3kcEQr1dgJB1cncn4maEK/UVTzTvOHfSVwK9iRfKemGn/WBJuwF6IOUijUjfPvmG
	 ykXsDAlgjhbFIRfZpgYcZ7ac/tIIY66KyiX2LvVLIa2YdDNVDUsTv5473Pzkot74AqOlB
	 VoraxgIrof9JphsVspeTex3/+0bxzlbNPO45bj4Kf8Ubg7wgPIjAWWbvtAzLg+jdO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYlpIfwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B8606A33C;
	Mon,  2 Nov 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYlpIfwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5D21F00A1A;
	Mon,  2 Nov 2026 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608726;
	bh=UlAcYWzbjHUpXQjJDNvgvnYyYvPWka7R8SEFN1ktWbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYlpIfwJvQzWFHsBMsI62YTJj8s/RHmHhx7xNtDPbxzOmlYuYkGhcnAT/wyFO3dXH
	 Rh0Ns6u9oUFN6HFxsIauj0q4nWailfoMRmYSSka6KU2TqYsxqip2kJJZNVTj0+G422
	 ML4vIvUbnvxgMOH98If8pWQv/smqVQ5ZFJqwQvby9XSeMDKI2FoVHkFvgWwHOsOds5
	 ihvpQbvalpdOwF5Nw1+3+pe0ljsx80We1a/Py/hKIN2enN5K0egkjbxQQ9cgR7g/oT
	 4qx2u3i/ajE8w1AgrwDmkxWgnCEmAIM4F+oznTPnAwIarF0y58x7mr8zi5GlnDUqUe
	 dirsx+7CUxByQ==
Date: Mon, 2 Nov 2026 09:38:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Message-ID: <20261102-whimsical-marigold-ammonite-3c772d@quoll>
References: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
 <20261029073012.1498-2-johnerasmusmari.geronimo@analog.com>
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
In-Reply-To: <20261029073012.1498-2-johnerasmusmari.geronimo@analog.com>

On Thu, Oct 29, 2026 at 03:30:11PM +0800, John Erasmus Mari Geronimo wrote:
> Add the devicetree binding for the Analog Devices LT8491, a high
> voltage buck-boost battery charge controller with an I2C interface.
> The values of the PCB resistors used by the chip's telemetry are
> described as properties.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> ---
>  .../bindings/power/supply/adi,lt8491.yaml     | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

