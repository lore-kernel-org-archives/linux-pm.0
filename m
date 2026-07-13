Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188E3E44E5;
	Mon, 13 Jul 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936290; cv=none; b=dc/VERFEtlSxGL5kcAeGwPSivpRM1XGfruPbHMYfDCwEGOTTtgJOLyXDwYXMSH8nycCLVq5zXIBoPNm7fMkWW3DFVbIzUvhP/i/9CGbM4eYfyv8YqDFF/gFVk97oTi0D79bhBDPEMXKgFoJW8b29+qQFezirjm49v6w6GJxEAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936290; c=relaxed/simple;
	bh=u8epNtbSFGsnzbtde7qH8/XDqSt0CCWizPnYhAK+vAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/fuFGAt19XMaRPXzPhNoXpOuYx4hZFoESVkGCURhXow0aqbKEzVtZtS/QzfMJF92q1C5278ToSX7MaApNsw+Qt+Hqu5hYIWJFICUqhtcpVpl/+4YhdIVPSsTWj48pBLOdDC/u24vkYGSsNdapwBh8vloVFpXF0lohz1YHbBiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU+5nyPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU+5nyPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C31F000E9;
	Mon, 13 Jul 2026 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783936283;
	bh=0AKHd3nNyOcbXAMrk2RZR9YeluYyWtoTErb/MLCvWlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hU+5nyPrf7EcyakWXdUVFQ6RrZFpynBBgPhKGzI0bmlDEsYU5oIrzcZ45EHtmyUOB
	 XYSXbGRNdmWICNG1JU5+UnGwPp/tT0UKA6IRPSNDwzOBDvGCKDFm3TeC+MaKcTbHL2
	 kKSp6bgM0V7giPdBmc+GH2+HRRsoTsO+2M4+TweJD8wOOfDiV/WMffXAcNXIIJ+Zr8
	 KX0bsXMWd8vnNscnRGPUGtl+QYGqa0zmL+SnNYYVdAdgLlL8L2D+wrwJlk3DZR7DE4
	 bSQXz4pvNo2Y+ZDfhPFp8J7KagRm/DrcgOwyHkMx1+/Bw68Pv8F7dVvhxs1lASWhtp
	 WOLc0jPKAuZRQ==
Date: Mon, 13 Jul 2026 11:51:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Message-ID: <20260713-powerful-academic-pronghorn-e895ab@quoll>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com>
 <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-1-69405c306c6b@cn.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-1-69405c306c6b@cn.bosch.com>

On Mon, Jul 13, 2026 at 01:51:33PM +0800, HaoNing Cheng wrote:
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
> 
> Document the optional fsl,temp-calibration-offset-millicelsius property,
> a signed offset in millicelsius that is added to the calculated sensor
> temperature. The property is optional and the existing behaviour is kept
> when it is omitted.
> 
> Update the binding example to show its usage.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>

Now this causes a warning as it does not match the From. Well, that's
trivial thing, but why did you change it?

Best regards,
Krzysztof

