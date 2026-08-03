Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2473BCD17;
	Mon,  3 Aug 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757497; cv=none; b=nIAvGQa2C8lC6JKPgewcxieR8YLIMLU3Zde+lOyA7IcXnbBwOyTpwUaKBOg85QRh///bK4VUIrSc3qeYy9hVC4gpykxvd9E9q4ijp30p6HdXKhP2tzp/NR/q1b0jY9l9cwyMOlrvaXpTvfxrEe4smZ8r04IFhhdejOVkRmI1DOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757497; c=relaxed/simple;
	bh=J8PRGWV3+I0wXpCaHk5I0Izh5G9sTqdLEINNXqnVHwM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TAT4sypIWCu8NxcHIuAT7ou9X9KRZ445b4cK7Ltva3L3Q8Dekaaguig1z8WE0bgTgoW2eYI2v89gokLdWt6RbTrWA5fUvdd123viPSKpaoMAxLh4oF2RBr3yynHOy0k8P5AAMCOfwOUtrqxw7JhEJLa1EP6joPf4uHp5PckYh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3FjwlGI reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3FjwlGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662DE1F000E9;
	Mon,  3 Aug 2026 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785757496;
	bh=8YQ2M9Eps1JKx10yr4780R1ecWZB0HlgXUHXNalwtiM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=l3FjwlGIvY9J5WKcaj4U+GHHJ0vSTZaGjUixFKx7WZt0ScOo/BXhTkDF14UlaeWpc
	 GS+60FdPXJC2+HBGNfM815HDuGPwFTVT2ZMnIYj5Qqpp2feLlNTTkGKY1FDdZuu13N
	 9HEbTx8Hs8V2b68uOQF1IjA0Ra9kNb91CiPSQShAG+XdLbXXxvBJOq+KxVAT/IY/Fi
	 OCTiBlG1fa8naz1MYhSsv29Xqa60dU5Y7HgoD3PVylPvEz9cls3/EMcfStwYRpoee6
	 vmyofz453SgmnpYcoUGzSXmGhYs4tT/zboqO7Y/CymG1XWULb56CvCkZRsw3MdTHZy
	 RUiZFTLw6OXzw==
Date: Mon, 03 Aug 2026 06:44:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sre@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
 devicetree@vger.kernel.org, Andre Draszik <andre.draszik@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, John Stultz <john.stultz@linaro.org>, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
Message-Id: <178575749351.2483197.6720070407824857023.robh@kernel.org>
Subject: Re: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic


On Mon, 03 Aug 2026 15:13:36 +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 58 +++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.yaml: properties:reboot-mode:patternProperties:^mode-.*$: {'minItems': 1, 'maxItems': 3, 'items': [{'description': 'arg1 (vendor-specific SYSTEM_RESET2 reset_type)', 'allOf': [{'$ref': '/schemas/types.yaml#/definitions/uint32'}, {'minimum': 2147483648}]}, {'description': 'arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)', '$ref': '/schemas/types.yaml#/definitions/uint32'}, {'description': 'arg3 (cookie_lo in 3-cell form)', '$ref': '/schemas/types.yaml#/definitions/uint32'}], 'description': 'Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string\nafter "mode-" maps a reboot mode to a vendor-specific reset.\nA vendor-specific reset takes two arguments, a 32-bit reset_type and a\n64-bit cookie. The arguments are encoded as up to three 32-bit cells.\nEach mode property is encoded as mode-xxx = <arg1[, arg2[, arg3]]>,\nwhere:\n- arg1 is reset_type and must be >= 0x80000000.\n- In 2-cel
 l form, arg2 is lower 32 bits of cookie.\n- In 3-cell form, arg2 is high 32 bits of cookie\n  and arg3 is low 32 bits of cookie.\n\nAll values should be provided as per the PSCI SYSTEM_RESET2\nspecification.\n'} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

