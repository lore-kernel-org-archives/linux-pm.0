Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF653B19D9;
	Fri, 10 Jul 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668513; cv=none; b=USI1RYfPKSfXAxhg2brPYOcvaGpz9r2l2ys3FYy0swX+pVMsGQT8ZY+U0YDcsLdv3qpsCd0ufKkSoL53RGDHq6VJJNEcnEzOgg/61F2yNvd3Z929qH2C7uwcNPGdcGuxqA0fpt+aHf4hhKQHFlcogmVuje4OZ6czFPa3CT1ad9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668513; c=relaxed/simple;
	bh=DJt/l2AOfFvwcIG41UK+4fTt8FZ8R75rCTrFGtkGzok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjm/lsdWQcEfZfvGDVrv6R1VjgVCjcxhqhiMKjoSVfA9muXfyAVxFWohLjqRuJ5AyBpFJHy0WZ+zcyEZCJV0weBY1WGrwi65KtxQD1nVcA65BN7yn0NhkXWNEi01LbDtDxinAHZYQWQundBhYHCc6+RGEmkAnWkVkdOvnSirKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOjsbwEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOjsbwEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EDC1F00A3A;
	Fri, 10 Jul 2026 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783668510;
	bh=X77cxI3Y4wjh/DUB+3afJye72e9J5XmH0QJ8nxG8KLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mOjsbwEinAqRwp8t5woNDyV1hXlGIky/vuZ2pd4VGETi5lSHlWjm+pqA9V1K446TR
	 306UrhBc6KxxIyekD9zQamy4xtAQinMsxxTRd6at/f/Hx4lvAEy9OKSrSXmmUsq2rl
	 onGXOfiQADHFCDcyesiliJTHP2Y97snb19rv2dVoP8hs2Z5lfqe9xEUcpWkyN/h9ye
	 ELTYH/nrJRYiJ9shHFqIG1lCw4VjbKJWF6A1GkzW6kZkjA8/ZH/aTrnFUiyducGebE
	 wICnor92p9LkCkeSE879HQlTijQUTzGZnsjv/Z+G6TiTWS99/L/Z4+UfjJ7dLsiXNQ
	 agUrDLGvOywDA==
Date: Fri, 10 Jul 2026 09:28:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Message-ID: <20260710-alluring-parrot-of-glory-567a07@quoll>
References: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-0-1fef97d1c750@cn.bosch.com>
 <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-1-1fef97d1c750@cn.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-1-1fef97d1c750@cn.bosch.com>

On Fri, Jul 10, 2026 at 11:03:36AM +0800, HaoNing Cheng wrote:
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
> 
> Document the optional fsl,temp-calibration-offset-millicelsius property,
> a signed offset in millicelsius that is added to the calculated sensor
> temperature. The property is optional and the existing behaviour is kept
> when it is omitted.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

