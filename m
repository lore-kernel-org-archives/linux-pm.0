Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E335C685;
	Thu, 23 Jul 2026 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791348; cv=none; b=JHaTadDVEKMarUVgsxRQxj13Bz/ilkmOAZjlk+CaYQYbvDclr13P00gJOzcfpVb3csp0V318hGuvZ3y9vz47/r9u0+eGWHkgLT+kJ+WTQECwO04pdIc48A6IcSMsr2i2QOBNedbKdlhVyaOF6GsCNFuTg4KWO53xzXJo7bQHHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791348; c=relaxed/simple;
	bh=mA3U7pWvFVNGxEPqn4zWz9kbraUWwUOw/sRiQbOhzuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9h9PE2xkk/4jpkrvbFqWtHJ06nP9rl/09jYPK1Mjv4MhimjZaRyJtf+bCGDLi/kixWmKjxrDha9hRLjecPKFphos18MjqSafcHSz50FoNXspdS0j3b7QbPETg14zAWWtnxAy5Uk47eN7lbR3G+9PbaSkJ7E25+mVxFdGcqyASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXpQgxVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXpQgxVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8001F000E9;
	Thu, 23 Jul 2026 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784791347;
	bh=sqEqx/dsEBv1eP8UyW1cZ7pHK0Q+V0EqkrcAbtlOXUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WXpQgxVZ5AtlZV2o2NpWt4AFrXuCoyHa4hA3yGPbXDN1Rb0df98k38s8Rx8DWF6mq
	 ZbEvS6IjppLXdfUUnK4eepeD/UK2ThTeXbk6jtyZmts1z4oYnkkiTlOI/IjnIwM9jI
	 cVEQEcEObkLf2HwKYbSOoBGRw9R8vmi7HwIlSEkJgFLnRacsehThCdZNpc/0iUpxhI
	 wzBpAoPO7oF+hKgpW61+R7pHR2fG+m5QW+UQVpvfpUGoekHiQ/NBKemdPmIhNFTVfq
	 lD3V63ptoploAmtAawSFPEG5E2xcznwYA9wYBxpckiCth144vZ6SvtZOoTxuD9+Zb0
	 Gi8Ij4FjUJUbg==
Date: Thu, 23 Jul 2026 09:22:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Message-ID: <20260723-encouraging-flexible-skylark-c92ab6@quoll>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-1-99620e07f505@oss.qualcomm.com>
 <20260722-active-kangaroo-of-order-ebb28f@quoll>
 <f3864ed8-34bb-42e2-a821-ac2d1a653076@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3864ed8-34bb-42e2-a821-ac2d1a653076@oss.qualcomm.com>

On Wed, Jul 22, 2026 at 07:08:07PM +0530, Gaurav Kohli wrote:
> > Filename must match compatible. There are no qcom,qmi-tmd or qcom,.*tmd
> > or qcom,.*qmi compatibles.
> > 
> > Which device is providing this ABI? PAS?
> 
> thanks for review.
> Yes, this belongs under PAS. Should i rename the file to pas?

qcom,pas.yaml would work for me.

Best regards,
Krzysztof

