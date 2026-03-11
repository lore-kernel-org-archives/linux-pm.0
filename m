Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C731A061;
	Wed, 11 Mar 2026 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193101; cv=none; b=hNTr4t2Pa5LzUrZugmxjcnuMKzi0JX4lNjlFVR7TLHU6gjCf2ZBspTjEu/fapMsHv77gYCoOxM5koh2k7Q3wkb+pTok01mF321vA8UhtGD70yulrrShJsLHc7Cxb+9hF7IzSzTdkZrEHyQ524/ePpM1f2vA9l7RbXWElk34WMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193101; c=relaxed/simple;
	bh=UBeBF6mzG/vlU5u+j5s0y+zmS6JjgSgmbq5KzdOAAvU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ECcBKCehsXAHyFnsukt+gdVt3LqMrX8rST4f9xhaRWSyE2FbHz9YE5DhYCJPqak3vS7pztccB7A4VlyLlTMmvBif37h+EdFjthk2FLCgXf+icl53E5J7vtY7/3jmcH+SkVoJDSfh6+GOPzv87yJeDCZC92/clVmaFsVZqFnP9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYk6EcFB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYk6EcFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F9C19423;
	Wed, 11 Mar 2026 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773193100;
	bh=UBeBF6mzG/vlU5u+j5s0y+zmS6JjgSgmbq5KzdOAAvU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aYk6EcFBs6HpNfDb/WTBzLlsewnnduPZguJm5+6dG7Bh7thlqMy2Yt+cYSzxuiNph
	 KnXcOtra2ZSKRl+ZRzpOWcLoY8j/KdpNqumpKLEs3MA4ONJMoo1wqez4cMKvX4k0qi
	 saf+5/xRQz0zM/ZHiXhm3yewhUMEpJgXtpf/3BPRIc+56N+IVf1t4Z/Bps3c0+nQwT
	 X/QOWL9OKuuGeGUGe2Cryq+DlmqkET1Czouu41EEzzLUb/vYo+PGJAzpwDN/e2cIVU
	 GE2E8tYMwRh4yGUyspJfiQs0VqJKtZ6O8bzTSmgcMMlktfKBRITDTkNpXhbyHA5mx4
	 5LRKu52aTmvhg==
Date: Tue, 10 Mar 2026 20:38:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com>
Message-Id: <177319309976.1426147.15580608651927678828.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power-domains-child-ids
 property


On Tue, 10 Mar 2026 17:19:23 -0700, Kevin Hilman (TI) wrote:
> Add binding documentation for the new power-domains-child-ids property,
> which works in conjunction with the existing power-domains property to
> establish parent-child relationships between a multi-domain power domain
> provider and external parent domains.
> 
> Each element in the uint32 array identifies the child domain
> ID (index) within the provider that should be made a child domain of
> the corresponding phandle entry in power-domains. The two arrays must
> have the same number of elements.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/power-domain.example.dts:136.13-26: Warning (reg_format): /example-3/protocol@11:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

