Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9572358D37;
	Thu,  6 Aug 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000587; cv=none; b=pbsoWla6pGorU/3xlxXQbrlaCTO9K5/tNUKsJIGHbyuoPrvgFXyJ/XNJYGpQpGNKaJl1c8x+8jV3mcEC0YetoBtZe/OTXhicoKk5Hqg2ZzBgc0bOvmxCRKMJXhO3AiCmBLE8CuY5hKDsbrz6VpH5UJSimWq1W1zXFPI/A8H7FsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000587; c=relaxed/simple;
	bh=FHvhI6H2FyjyzVH5lbcV92+hCxEh/dMGTbgIIbuMPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtXhG+x7eWo+RJbBSOEmOii41uWIl6Whty2SetLT0Tus91mSuT2tafQZ9nBx4PyGnca7rc/eOlqVDDiphp3rUqMyN3jP0QGLlVf0K0KQ8sOM4x4ayIMIHFeOj2+Y6UMJO6xQldco+Yw5w4Itax548K/YXQTtcYUGoy8xJeEAyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2+JCyXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2+JCyXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C376F1F000E9;
	Thu,  6 Aug 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786000586;
	bh=FHvhI6H2FyjyzVH5lbcV92+hCxEh/dMGTbgIIbuMPSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2+JCyXrO4pHKHHyzoBprC8Ekv1xAmHsyLo6E27A5IB2asj2vpe6MZXRIiHmveJWI
	 2n1DxedP4yYZy4YuSS7ZZRZN+Q4pu2eYYFR3FUyoEqusrSvzZBrc8UUY/VvV9WRGfQ
	 dSH63jhdcvPXLxQzYTzFY5WwWfY7yJfD8ysabJS8UMwdlajeKQ9bx/9wQn+6J3DbT0
	 T+X0g3PkjM5TUtBeoidubaeCUQ72zwkYu1T5QTI2J+pOm9SitQy4zPhiPj38pwzX4C
	 dq8eYipYmTq7wUnMLbKrSHC5FVlMAR9YCxSfoVp3/n76ZyPNUQ0iuRUFotH3h7TNqT
	 UfPnQDU+536/g==
Date: Thu, 6 Aug 2026 09:16:23 +0200
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
Subject: Re: [PATCH v7 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Message-ID: <20260806-turaco-of-eminent-domination-9baf8a@quoll>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
 <20260731-b4-qmi-tmd-v7-1-3befd44403d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-b4-qmi-tmd-v7-1-3befd44403d5@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 04:03:41PM +0530, Gaurav Kohli wrote:
> Document the optional #cooling-cells property for Qualcomm PAS
> remoteproc nodes so they can be used as thermal cooling devices via
> the QMI Thermal Mitigation Device (TMD) interface.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

