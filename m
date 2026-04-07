Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1B272803;
	Tue,  7 Apr 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590168; cv=none; b=ZNtbd58OoN/++x3X3AFQ4J4INqlebds5d+uNhT2koAabd6nWkXoa3yrBzH0I0TiBfXSX2yX10L5+FrdPBVdIf0XRciZ7KP/P+xBCi23dVf1ee2mf39LLffShdpWTW2AsHDK0bsSvkOgbn+e9JyXaWJdGDC97eXOixCOt36XAxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590168; c=relaxed/simple;
	bh=18D4cN19brYBRiRDSX4HiXep5xyejpy/zMyX/KCIrGg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YWt/Rja4gXmf0uUP4Y7ATRNKB3qzuT1OV3kIeXUVopjTH06JRyB0c7bM7hYHuBHy8k7cIiugVKXpljz2RFbKOzjZRPB6LnyFU6eRU6TcxajxpmYIOUXCMD/2AITxy9b6BaQsr937gAd42ZDnVN7TQkVCEXGI8QiNGQMEK875ey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD97f8ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD97f8ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCEBC116C6;
	Tue,  7 Apr 2026 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775590167;
	bh=18D4cN19brYBRiRDSX4HiXep5xyejpy/zMyX/KCIrGg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=BD97f8ei1c8wIE+DWoqjXkEwG1ANOyFiUNjpOZpbp+c+ycz5U5++fPmTU6H6nOXqe
	 chaiM59KdKk/YAlZZEFxO2WdIXsyhFbUH2iuNeeWV4ubCb0pgpd9t8byKYze4qAp91
	 U1AgehBt19TS6rPEJMeVJyAqE5XFd48+dddKaLzBLShygGxXbbYR7TwmMOBLo54nHF
	 m3nw9HWQ42YV71pmxEPp+dunyHyYA5wlh04JtNyJmy1VVIi8lnI480LPk2DPd+OgGJ
	 xOaGB2DRqLqUVhhCzvvL9XLkR/yrsA11AAaCMNreweLy6cIzF1zpR0U1UMaOezZhyz
	 KTKr7J1Sh44MQ==
Date: Tue, 07 Apr 2026 14:29:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, devicetree@vger.kernel.org, 
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260407053957.10508-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260407053957.10508-2-krzysztof.kozlowski@oss.qualcomm.com>
Message-Id: <177559016610.3536304.190890909066170434.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: thermal: idle: Complete the example
 code


On Tue, 07 Apr 2026 07:39:58 +0200, Krzysztof Kozlowski wrote:
> Thermal bindings expect the node name with all the zones to be named
> 'thermal-zones' (hyphen instead of underscore) and thermal zones to end
> with '-thermal'.  Also DTS coding style is not to use underscores for
> node names.  After using correct names, bindings point warnings for
> missing properties, so add also thermal-sensors.  Drop fake top
> compatible as it is not useful in this context.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> 1. Drop top level compatible and other properties
> 2. Add thermal-sensors
> 3. Rename also trips and cpu-thermal
> ---
>  .../bindings/thermal/thermal-idle.yaml         | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-idle.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-idle.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-idle.example.dtb: /: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-idle.example.dtb: /: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260407053957.10508-2-krzysztof.kozlowski@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

