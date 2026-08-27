Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF563C1983;
	Thu, 27 Aug 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822594; cv=none; b=OJcgarDVGSOHYoLmBN1h8N93oHlmu6Q63ktulG7QhQPCi2MksPHygWc51IYHWRqtWTpw0iMnF2p7SUXU+UqI+B5iOoYBTbCTsbaISE7P5You4VVm8JLLZff6Jz8LAF/pydyH98NQjHeakQteP/wRSOXpeyebjCZTuJfeIXCGEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822594; c=relaxed/simple;
	bh=Ie/cAy9KfD2GFFkBETq1farDKVxA0DobOvxLT5gKbdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE58f044cC2WfDOwPRnzAxKWI1JTgwrCQEUz8Eq3RqBjp6mUTSiCLmjtsWmMTYcln6LrUbM7wDxh8zMvFIBS0QuVSqZyHBtLBgBBwGLrg7wYlP0+xO9Yi/WiMe5FcHimbPLSFhiBkOwrMFAsh+lT2F5eZylRJOt+G/6duyURCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAo8Mbiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAo8Mbiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447F31F000E9;
	Thu, 27 Aug 2026 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822593;
	bh=YpLVvCqE/ILN9yRjN+e3+yelyQFbjeo1FO+mT4iZEAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAo8MbivSaMM6VB4x3hWTb23uUkZRdAP/1Lwr7frPbKHkoe1XbTQ6x880wCmzrv8k
	 80Agmzok9QTrw3t3noEKi8aslJFZ7tZRX4Z//IePMZbQwpUpl5Q2+r7WSekkKRRD76
	 2Q3jPQhvXWLF2EC6C6Xc8ad7n8w3XDo4b6vmc5cDbDukbMi/6ex+bmXoxJaOTaXtEb
	 9b6MqPIcXrX/HjfXr6NmHmLMai/giotLh4pZ9tfbAhZ74uNsU7UNp9Ic2QAzfeqm65
	 A6TvKikprLN1htDXQFhY/gwACSHjeYdUmZuz6g5v/TytvjFjRXgaHbAhhl5b5KYjjF
	 pM89CQa8kHyrg==
Date: Thu, 27 Aug 2026 11:23:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC
 ICC binding
Message-ID: <20260827-thistle-puffin-of-chivalry-bccc47@quoll>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <20260819093211.1436275-2-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819093211.1436275-2-atanas.filipov@oss.qualcomm.com>

On Wed, Aug 19, 2026 at 12:32:09PM +0300, Atanas Filipov wrote:
> Add binding for the Qualcomm CAMNOC interconnect provider. CAMNOC is
> the internal AXI interconnect within the camera subsystem. Multiple
> sub-devices share CAM_CC_CAMNOC_AXI_CLK; the ICC provider aggregates
> their bandwidth votes and scales the clock accordingly, avoiding the
> last-writer-wins race from direct clk_set_rate() calls.
> 
> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,camnoc.yaml    | 124 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,camnoc.h    |  52 ++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> new file mode 100644
> index 000000000000..b2659db2cf27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml

Filename must match compatible.

> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
> +
> +maintainers:
> +  - Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> +
> +description:
> +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
> +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
> +  between camera sub-devices (IFE, JPEG, BPS, IPE, etc.) and the external
> +  memory interconnect. Multiple consumers may independently request
> +  bandwidth via icc_set_bw(); the CAMNOC ICC provider aggregates all active
> +  votes and scales CAM_CC_CAMNOC_AXI_CLK accordingly, avoiding the
> +  last-writer-wins race that arises when each consumer calls clk_set_rate()
> +  directly on the shared clock.
> +
> +  Each camera sub-device driver that shares the CAMNOC AXI clock should
> +  obtain an ICC path from its master port to SLAVE_CAMNOC_AXI and vote for
> +  bandwidth using the port IDs defined in
> +  include/dt-bindings/interconnect/qcom,camnoc.h.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8250-cam-virt
> +
> +  clocks:
> +    items:
> +      - description: CAMNOC AXI clock
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#interconnect-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
> +    #include <dt-bindings/interconnect/qcom,camnoc.h>
> +
> +    /* CAMNOC ICC provider node */

Drop, redundant.

> +    cam_virt: interconnect-cam-virt {

Drop unused label

> +        compatible = "qcom,sm8250-cam-virt";
> +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
> +        clock-names = "camnoc_axi";
> +        #interconnect-cells = <1>;
> +    };
> +
> +    /*
> +     * Simple consumer example: IFE sub-device voting for CAMNOC bandwidth


And what are the writing schema/bindings asking about consumers? Or
DTS101 slides? Look at other bindings instead of coming with own style.

Best regards,
Krzysztof

