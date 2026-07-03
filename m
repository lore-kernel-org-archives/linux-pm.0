Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0033A711;
	Fri,  3 Jul 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065130; cv=none; b=AceXNJbgfAUz8YXBdJroAQ8jN2gqLFqmnWsu7n/xNRc8ih5Y9NeExo7z01L63ax3PxQtsv/Nu+lqSAdCJOBXRwmv6Ly2HVKvcmm/SoCerRlavdIK3rGQxpSFquB6coT0GkvJTlGPhn3Uu3PDI/PvX1f0hNxZVxCi5Q/7a7WOIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065130; c=relaxed/simple;
	bh=zsdr1p5Efq9G7CRePnguZeg1sexbuAYBixN2H81XEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI6rVBRco3Dl6LWSaks7tuYuv7x9/v3XPuqIO6GsS9IlgOD+PYypWLhAoAbJNQOcDli9q50z+uYHF/mW/BsS8GSo0DFr6nAOHJitHR7M+gbZJxG6EbmOCUERAdohfkyUd4FpXLYUVKmnh9ZsESjofv2uutqp6jqOs+dMIyAjfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6BbjYxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6BbjYxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCCE1F00A3A;
	Fri,  3 Jul 2026 07:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065128;
	bh=URGNTO5qpdlPm6rkSuLXxib/AseUmenBimvYq/Y6ghs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6BbjYxij7r7DkARrIgpI3n12qcXT5aQ8+iufs/vsluvtI1Yp9p1bZ6GzFZWKkAGi
	 B0RomWTDMOHtl4CjWKoX38jXmRULncnEt1xJgeE50GakECapj7snuP8Kzxn/rZ5Bkb
	 Em68PcQuesdywv2+VSGC/naEwxTjk3Hl2pfkKq7cinbEaej6VNBMy0tfCn+N3kxEdd
	 L8EnznShNoy6kp+TqQiMYbmxScAICn4WmW4G8SNTyrIzX245WPON+f4iUZESuWqoyi
	 JSoolbRt+rMGhFOODfmDYnV59mv5p6vE/udXvq0+1Xa48QTfo6MP9WBXn8LB1BzqI8
	 AK482n/ekGUAg==
Date: Fri, 3 Jul 2026 09:52:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD
 device type constants
Message-ID: <20260703-bizarre-abiding-spoonbill-dcc142@quoll>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 10:33:04AM +0530, Gaurav Kohli wrote:
> Add Device Tree binding constants for Qualcomm Thermal Mitigation
> Device (TMD) types used by remoteproc-backed thermal cooling devices.
> 
> Qualcomm remote processors expose thermal mitigation endpoints
> through QMI. These endpoints can be registered with the thermal
> framework via the `#cooling-cells` property on the remoteproc node.
> 
> The QMI TMD protocol identifies devices using string names (for example,
> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> `#cooling-cells = <3>` requires numeric device id in the form:
> 
>   <&phandle device_id min_state max_state>
> 
> Define common TMD device index constants shared across currently
> supported platforms. If a future target requires a different mapping,
> additional target-specific constants can be introduced while preserving
> existing DT ABI.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |  1 +
>  include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++

Why is it put into firmware? What part of firmware are you describing?
To me it looks like thermal thing and even you wrote: Thermal Mitigation Device

Best regards,
Krzysztof

