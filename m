Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06936A342;
	Tue, 23 Jun 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201339; cv=none; b=cSHOrxiBY2vjGzboMLEYw07X2B2cPlfpdN6twgofmvYAi7ST7vF2Jt81zqs8eGrHAuQZgAlPmJ9dscdbIJb0I7GBAU0SO6Nr9DpIrW4loF0d5+t6f4nD/KZ25HR73mYV3mHJ5WEsmUbSUwfktATG07sj4sWHX2y6nplNQoT8bYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201339; c=relaxed/simple;
	bh=08gDYLchnWuCB49pz+ZsGMWiUw6nxnumu06hY6OSPQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQGmHZBRhMpflGEIcDlKI4+wm7sfCnGeL5f/6RO85+sVkDaF1Fd+5u4JYVljjido0l3OC947pWRnT/7VpvHGF+eDr959nFOlrZrjCvCZoY9QTLddH9xZN0uhHEdmjdRj9PWQpAZ69VjohjMQqslHH4SKBU44w8hj4tPxvycJ1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMQkD1DF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMQkD1DF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4251F000E9;
	Tue, 23 Jun 2026 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201338;
	bh=TTa4EShxJj0f1lG1+jUso8oZ9pwOdecc+blVRHGnDsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RMQkD1DFHxemuwTVkZmV4VipFjc8uDVPMbZLiVTfBpUkjqIkxt+gRJbVyjtbJ8kUm
	 EVfsOoCMo9OnCDF7vRg95VxpxTVXEm38UUx3GqUJQQ6IraIOBU8vHg6wQnNKewq5Wj
	 N4JdBj1GjQj+16Kq9ywY3A899KpAY/aJWvV/0Mxp3cFd2uCs0o2wQqZowLqFVsMSZV
	 YGvZ32g1kQwtm4oz03w1tbbzIjWJzg+Kkqy4G+2fieEqHxuqi8O2P8bOoJlVdhEkV3
	 nvcylqtblb+qvJw+amXamhjZGIEJytKysJadoagAN4GZlobk+efkAcBT0jZlC4+vrm
	 WA7vvoreMMlsg==
Date: Tue, 23 Jun 2026 09:55:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jingyi Wang <jingyi.wang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: document the
 RPMh Network-On-Chip interconnect in Maili SoC
Message-ID: <20260623-cunning-rustling-lemming-8bb3f6@quoll>
References: <20260622-maili_icc-v2-0-18b5ac08c04f@oss.qualcomm.com>
 <20260622-maili_icc-v2-1-18b5ac08c04f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622-maili_icc-v2-1-18b5ac08c04f@oss.qualcomm.com>

On Mon, Jun 22, 2026 at 06:34:45AM +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-On-Chip interconnect for the Qualcomm Maili
> SoC.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,maili-rpmh.yaml     | 127 +++++++++++++++
>  include/dt-bindings/interconnect/qcom,maili-rpmh.h | 171 +++++++++++++++++++++
>  2 files changed, 298 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

