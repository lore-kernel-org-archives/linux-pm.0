Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527320;
	b=ZWfd71wRuN+xmRhupQ5fsSMAHr4I3ieqei83ijccjxRNDOlX2Uo74/g0R9bEgCRFh869
	 0FtF21l1uV/XlmFzwBmYUoPYhIeXmVEr0Eg92gnBr/+N6QUlqDLj5d75WsvJYY+eR38fe
	 J3GL2LhP4qkt0a4ascGpgqbwNMaF+Q5wHE1QouXyhrKEvHqBReK1Ircyq+5klvGRXF9Mx
	 brTl5U6zXD96qlNz8YcnNjBvh3r1YosyI7HLOS12ByWFdpvz+PFkeBkn1vSIpHS506I6D
	 GdU+CVv3f0ji5+s9HPEBCo/cxZT7fN/PXHCYVFd0ueKKQX+ZsYDwPhVaC/bH2Udjm5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527320;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=dtrcKHCDOQwC/1Y9pVFvIgO8WKKsGNe4/+JPGrTVGUA=;
	b=xlCiV/UaiE8HxrQ5wX0aoBeQfowLmR51lJ3eTPPnRZsvt2cYIc2w83isG3SfpJbACcaX
	 0rVkmk6xOkwVpbXocy0d0roBag8DMiQjP3KNLvWJ27VnbDd/M9AIm9VQ7XWQyUJAXdpDn
	 cS3Lbm/gCpj5pKYGmO77WK1PmcDrIbJfgX8j93atZpGfELHe+FjPStEntSNm3HrvScOCB
	 Xw+W3XLOj83I7g0B0nm4kGUXiILYwDrMGYurFhL2Y0w9g5v+g8I0kabH3S6arY4i4UtoX
	 R7cJ2kDCNmzVtAMWrD9msdtZrQqBqUafZK/pqEJefRKyW3BcbMnW/JzN2tWcAEMfuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbEFYbd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027C606A33C;
	Tue, 24 Nov 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbEFYbd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A008F1F000D4;
	Tue, 24 Nov 2026 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527319;
	bh=dtrcKHCDOQwC/1Y9pVFvIgO8WKKsGNe4/+JPGrTVGUA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=AbEFYbd7lwIf/jyWl/sn/DumUXZrfLlfnTKnyAbeLL5sbmhEOmwCHbOHB7rmeqkDm
	 ct05xZ508E575N2dRrPz0Eo+/Trzyr3jfF2+d+zR1YnGvrhLoyehmGvVU1fkHXJ7sh
	 Y8MHJYd15gvlJFHuhkHFAg1XngVpkM8buQRuK9HEHsbZQty61TCiktt6Xc4V5kt+zs
	 WR0n1idQ5+lETAtwJDiIpwEUCwiROnr0zWJhHkIDqilRv2yABTeBIjf0ahyanhCBY6
	 TbMOyRcuM+1tyNgr4Cjne5RyBjBcnZoEa3m2HGf3FTW7Th3KXk5K3Q4qSxhzKpXE04
	 DQpmY9zxRYAkQ==
Date: Tue, 24 Nov 2026 07:35:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rakesh Kota <rakesh.kota@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Raj Aryan <raj.aryan@oss.qualcomm.com>
In-Reply-To: <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
 <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
Message-Id: <179552715903.40664.16651410338735245830.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add
 qcom,pm4125-charger binding


On Tue, 24 Nov 2026 14:45:44 +0530, Raj Aryan wrote:
> Add YAML devicetree binding for the Qualcomm SMBLite switch-mode
> battery charger found on the PM4125 PMIC.
> 
> SMBLite is a reduced-feature charger IP sharing a common SPMI
> interface with the SMB2 family (PMI8998, PM660) but using separate
> SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks.
> 
> The binding covers:
> 
>   - compatible string: qcom,pm4125-charger
>   - reg property for the CHGR peripheral base address
>   - Four interrupts: usb-plugin, bat-ov, wdog-bark and
>     usbin-icl-change
>   - Two IIO channels: usbin_v (USB input voltage via ADC5_USB_IN_V_16)
>     and usbin_i (USB input current via ADC5_USB_IN_I)
>   - Optional JEITA soft and hard threshold configuration as raw
>     16-bit ADC comparator values written to BATIF ADC comparator
>     registers
>   - Optional monitored-battery phandle for battery parameters such
>     as float voltage and charge termination current
> 
> Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  .../bindings/power/supply/qcom,pm4125-charger.yaml | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dts:29.13-28: Warning (reg_format): /example-0/charger@1000:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

