Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962D2D77E5;
	Sun,  7 Jun 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820531; cv=none; b=t49NNOSLqgTWqe7iATe0bTmmpLopQAQ6tHvELvaYcIDJtUWh6SzkZVO1V8g8u9wylIfQ0MQSc2kv6ifviL6oiu4f6C4pr/jvhZmAxqlaEKbPwaN9O0qbxtS+Q1lAGyG2L+YZsxMLjf9O5dw7DvScN6vdfD0AKChHrz10/dkjJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820531; c=relaxed/simple;
	bh=RlXBGideOm0fG24sK57Fjj9O2Bf18IpHaeAOIA6gzx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptZ1rGKCGnp6VQFR0suR4VycWnl4zea/9N+Yox4VnzrzMShTmJ3Xo03TMcojdinNmpJtfoNmOSjaMQeAfrDOqrX0xUuX3duCVa4X4Fz/nVwREHNT1eWQ2oS1xfhzNej3EYRKNvkuGGF6uIIcgSbKczghkLLVi+sXKIccz/QsMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIacer5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIacer5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C41A1F00893;
	Sun,  7 Jun 2026 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780820530;
	bh=uqI3l1dNo0fGlCLztcpYfyTopg/g/S2ClfydNwNTjPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIacer5bOOEQMfuoFy/5BQASek5+kZonDK/tQkTE24M776WBgDDCRjyAZt2p2TGtq
	 LG/ycjE4Eqbc9qzQXDHsBaKlP/IqODCa7F870lreHh3dFY6lBzBz4VrJrsdX8tjWbi
	 MT1/xDmsTvNIpo4eFH5vA9qSaichASr4Fe6Ie4A95HhwdpIYkglSlWCfClKvQ1sy7Z
	 xpFAehcPF7LADCSxtHwb+BvJvTPTHzenXUWHfDgqMojhJwUKmadeAYsCjPB+3PJa3v
	 WNFVay7zvu3MYsBdg2MNkeDQUfs94J20SZFmuoh/lXNaHRpwEggWRunmWQXtxBdq50
	 Z2HtYLKdd55RA==
Date: Sun, 7 Jun 2026 10:22:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: add msm8660 NoC
Message-ID: <20260607-zippy-tricky-bettong-1f7f74@quoll>
References: <20260606-submit-interconnect-msm8660-v4-0-6e1e5c5efa26@herrie.org>
 <20260606-submit-interconnect-msm8660-v4-1-6e1e5c5efa26@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260606-submit-interconnect-msm8660-v4-1-6e1e5c5efa26@herrie.org>

On Sat, Jun 06, 2026 at 03:00:46PM +0200, Herman van Hazendonk wrote:
> Add a dt-binding schema and an interconnect master/slave ID header for
> the MSM8x60 family (MSM8260/MSM8660/APQ8060) Network-on-Chip.  The
> chip exposes four NoC fabrics that the qnoc-msm8660 driver models:
> 
>   AFAB  - Applications fabric (Scorpion CPU + L2)
>   SFAB  - System fabric (DMA, SPS, security)
>   MMFAB - Multimedia fabric (MDP, GPU, camera, video, rotator)
>   DFAB  - Daytona fabric (SDC, ADM master/slave)
> 
> The schema covers all four compatible strings, per-fabric clock-name
> lists (bus / bus_a / ebi1 / ebi1_a for AFAB; bus / bus_a / smi /
> smi_a for MMFAB; bus / bus_a for SFAB and DFAB), the required
> qcom,rpm phandle through which the provider hands the arbitration
> buffer to RPM firmware, and #interconnect-cells = <1>.
> 
> The ID header lists per-fabric master / slave / gateway indices
> derived from the legacy vendor msm_bus_board_8660.c enums,
> normalised to the upstream interconnect-framework naming convention.
> 
> Assisted-by: Claude:claude-opus-4-7 Sashiko:claude-haiku-4-5
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../bindings/interconnect/qcom,msm8660.yaml        | 164 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,msm8660.h    | 156 ++++++++++++++++++++
>  2 files changed, 320 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> new file mode 100644
> index 000000000000..776717d4212f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8660.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8x60 family Network-On-Chip interconnect
> +
> +maintainers:
> +  - Herman van Hazendonk <github.com@herrie.org>
> +
> +description: |
> +  The Qualcomm MSM8x60 family (MSM8260/MSM8660/APQ8060) NoC is split into
> +  four fabrics, each modelled as a separate interconnect provider:
> +
> +    APPSS fabric    Scorpion CPU cluster, L2 cache, EBI (DDR) memory.
> +    System fabric   DMA controllers, modem and LPASS cross-domain links,
> +                    security peripherals.
> +    Multimedia fab  Display (MDP), GPU, camera (VFE), video codec (VPE),
> +                    JPEG, with the SMI scratchpad as the local slave.
> +    Daytona fabric  SDC1..SDC5 controllers and ADM master/slave channels.
> +
> +  Each provider programs fabric arbitration (per-master priority tier and
> +  per-slave bandwidth vote) through RPM firmware via the qcom,rpm parent
> +  controller, in addition to scaling its bus clocks via clk_set_rate.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8660-apps-fabric
> +      - qcom,msm8660-system-fabric
> +      - qcom,msm8660-mmss-fabric
> +      - qcom,msm8660-daytona-fabric
> +
> +  '#interconnect-cells':
> +    const: 1
> +    description:
> +      Each consumer phandle takes the form <provider node-id> where node-id
> +      indexes the per-fabric ID array in
> +      <dt-bindings/interconnect/qcom,msm8660.h>.  Pinned to 1 because the
> +      driver uses of_icc_xlate_onecell, which strictly requires a single cell.
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +
> +  qcom,rpm:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the qcom,rpm node.  The interconnect provider hands the
> +      per-fabric arbitration buffer to RPM firmware through this resource,
> +      so a production device tree must point at the system RPM.

"production device tree" is confusing - no clue how does it matter for
the bindings. Like a non-production would be different?

Anyway, explain the hardware - the interconnects are part of RPM, no? So
why do you need another resource?

I do not see any resources for talking with the hardware, so it seems
you just added this as a fake phandle to avoid properly repersenting the
hardware.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - qcom,rpm
> +  - '#interconnect-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8660-apps-fabric
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: APPSS fabric bus clock (active vote)
> +            - description: APPSS fabric bus clock (active+sleep vote)
> +            - description: EBI1 (DDR) channel clock (active vote)

Is there EBI0?

> +            - description: EBI1 (DDR) channel clock (active+sleep vote)
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: bus_a
> +            - const: ebi1

If on, then this is just ebi or mc

> +            - const: ebi1_a
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,msm8660-system-fabric
> +            - qcom,msm8660-daytona-fabric
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Fabric bus clock (active vote)
> +            - description: Fabric bus clock (active+sleep vote)
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: bus_a
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8660-mmss-fabric
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: MMSS fabric bus clock (active vote)
> +            - description: MMSS fabric bus clock (active+sleep vote)
> +            - description: SMI scratchpad clock (active vote)
> +            - description: SMI scratchpad clock (active+sleep vote)
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: bus_a
> +            - const: smi
> +            - const: smi_a
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    interconnect-afab {
> +        compatible = "qcom,msm8660-apps-fabric";
> +        clocks = <&rpmcc RPM_APPS_FABRIC_CLK>,
> +                 <&rpmcc RPM_APPS_FABRIC_A_CLK>,
> +                 <&rpmcc RPM_EBI1_CLK>,
> +                 <&rpmcc RPM_EBI1_A_CLK>;
> +        clock-names = "bus", "bus_a", "ebi1", "ebi1_a";
> +        qcom,rpm = <&rpm>;
> +        #interconnect-cells = <1>;
> +    };

One example is enough, all of these are basically the same.

Best regards,
Krzysztof

