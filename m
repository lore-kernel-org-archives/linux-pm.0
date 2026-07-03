Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11978377ED9;
	Fri,  3 Jul 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064857; cv=none; b=NGBB001zw8ePJg0rxrqkbE2HpzOAM2xtKAkYJSfcu6h5Jc3P7oP+vgmnUOOztx86Zay23rmY02mFs9j4Y8uF3NueC80WbyAz49vvGP8ukio7bABTVwNI2K9iZtDxP7tG9lYRcmOWp7ZkCfx0ie0deCgOIv2BLXLS1h4n4TV8Ohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064857; c=relaxed/simple;
	bh=8yj8IlnLJj9l6V6xHBhPYzBCdxDwypwwDMc75/R7tBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEFM7LeHcq5Tv1dt+95OmjF5wINNKB0UAEz6bLluKKKMAcpfLUyny7d+hwEdWOYKGSbXnReaLrQJSNDxl5ZM9qw670KmqxTVjm12A+AtB4DgKs2CJBuzAB/ZY2+D1kAhvnPUOttzLMK2blZBgbBvMI3SPKXSWLv8tt38UtPhWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMtsHq4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMtsHq4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8571F000E9;
	Fri,  3 Jul 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783064855;
	bh=z08ZstRUnMDlGm6RwGZUBt7AxpDYvvssQmc/mCoyhHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jMtsHq4e0KqWBASHBeX0eW7P8Hr5k89wnB3Ia2cuNHshgiMjIf9I4uaId0gl6xl4B
	 5NMP3WUb59rjlGlM/Z/kVIhLdDd6n2Xynq/Qi9fzX1eOAbWuO/qOUxwI3t5OrWu2DB
	 RAYywA9STroVf9BVyeHjpemNwUsOqcgmvXBrqNPB46LjUP62y94Rd6yfcQ8RJ5A4es
	 HW87GaDvMbHWz7R7NwIU/h4DV7i80m2prjw2vVCmUMuFeUJPcabTCmN2e1b2v6FmGU
	 ZvhFy8Mb48vnQfkvszasOClb0r8Ok3YNx0encIk5k5/HTmOl7XE5K2bqJ3jU5yWH+w
	 qp8E1uPL9ccXw==
Date: Fri, 3 Jul 2026 09:47:31 +0200
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
Message-ID: <20260703-humorous-blue-agama-4b668a@quoll>
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

As explained many times: Header file is not a separate commit. You need
binding using this.

>  2 files changed, 21 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57656ec0e9d5..ffd85fd1dd80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
>  F:	drivers/soc/qcom/
>  F:	drivers/watchdog/gunyah_wdt.c
>  F:	include/dt-bindings/arm/qcom,ids.h
> +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
>  F:	include/dt-bindings/firmware/qcom,scm.h
>  F:	include/dt-bindings/soc/qcom*
>  F:	include/linux/firmware/qcom
> diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> new file mode 100644
> index 000000000000..73efecef0f3c
> --- /dev/null
> +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
> + *
> + * These indices are used in device tree cooling-maps to reference
> + * specific TMD devices provided by remote processors via QMI.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> +
> +/* CDSP thermal mitigation device id */
> +#define QCOM_CDSP_TMD_CDSP_SW	0

QCOM_TMD_CDSP

> +
> +/* Modem thermal mitigation device id */
> +#define QCOM_MODEM_TMD_PA	0

QCOM_TMD_MODEM_PA

> +#define QCOM_MODEM_TMD_MODEM	1

QCOM_TMD_MODEM

Best regards,
Krzysztof

