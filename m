Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D937281525;
	Mon, 22 Jun 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131297; cv=none; b=K5yC6i66NPtE4Eh4mn5lOVR0EnVlxcC4+YAlc/05cxQBb/XTbH39OS8u7WmyOp4CC0PNbYJUhgfwIptoa8vwnr+ZfGraQJ4ioLKPKevo+J/tjUOFf7TXmfZ1WIXJj07TzY21MpvXvxzPFIMjnijyAgqkCDUOLJTI5MynlYDpCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131297; c=relaxed/simple;
	bh=mYlXSRdKh/G6LHvPtRHjdDVhCCHCl9wCRzu60D2WTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtrMIAHMbGRwgb8+2ghTgesLpGU/2FlSYUCO3vM84YW1sRL+XkCGw8GgSnxsGqz60P3+wU2i1jbsuDuXFW1ameE8P606WLMeIjfuqLg03bI0EUz8gP//2QtCBi79omesbI/pztk9UJQ/V66rYA2yZ5VfOQjCunUwv2sjEByX9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=galWxEqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="galWxEqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B741F00A3A;
	Mon, 22 Jun 2026 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782131296;
	bh=uKWJNXaLhCeOqXbATJWCCFi1ZU1cFNHXdDs5a/EA7nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=galWxEqg6VcawD46GcKW5dunhZBZI1IgWQ7D3eKZ4umS4gF8JnqNV/FZijHxARLa8
	 UD10P0DIgbw5lrRUD/L66F6U+SezMYtl+S069U3NqvzXqg6Ci0EJSw4yLD+1BXfNjt
	 SqvJG6jeA6qGE1GAYo+d4FkpWekslZmBG4WB9SzOSeUYddT/gN0Dqgm43DbjHVLyta
	 TPZuEHWTES++yQuHn4R2tTBbMMu2dwxq5utAoZ1IrCG5eoVotgK9zoQDQnttFUT2Kf
	 bfULpmrU46YWSF93+pzxfeO7cRKnrIW/eTs8d+Kn54+mpc3SFzfYIWTDWrelNvqFC2
	 AVoMNcTL1WerQ==
Date: Mon, 22 Jun 2026 14:28:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: limits: Describe Qualcomm
 SPEL hardware
Message-ID: <20260622-armored-witty-tarantula-84a28a@quoll>
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>

On Sat, Jun 20, 2026 at 02:09:08AM +0530, Manaf Meethalavalappu Pallikunhi wrote:
> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
> based power monitoring and limiting capabilities for various domains.
> 
> Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> ---
>  .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml

What is "limits" directory for? What sort of class of devices fit there?

> new file mode 100644
> index 000000000000..4c6e6cbfbfe4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml

Filename should match the compatible, so qcom,glymur-spel.yaml

> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/limits/qcom,spel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoC Power and Electrical Limits (SPEL)
> +
> +maintainers:
> +  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> +
> +description:
> +  The Qualcomm SPEL (SoC Power and Electrical Limits) provides hardware-based
> +  power monitoring and limiting capabilities for various power domains in
> +  Qualcomm SoCs.

Please describe here more what is this limiting capabilities.

> +
> +properties:
> +  compatible:
> +    const: qcom,glymur-spel
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: config
> +      - const: constraints
> +      - const: nodes

Best regards,
Krzysztof

