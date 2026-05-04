Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EC3C1419;
	Mon,  4 May 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923700; cv=none; b=g4XlYX3gzau4hkpmJe8miI48VC1aKgpGXeYB2Q5sZnpCTaAgXKum3+rwr6/VqiZC1ANvBhXvJ241VvpGUiLkb5VLwUNHpqpg7hKWbXcImn0VwBzi7myN+4bILyjU0TbEAivowfHsKpQ+yJK91gXVC/v984gFASD9sEdqvYffa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923700; c=relaxed/simple;
	bh=mgdlbKlEQOWDLqR92Whq5tURhflQ2Yr9KuyXqkV/fOc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jA/BoIrMFkFlaTkXUNB2Xv8oAmOEI/z3ft1j1aa02nE/aRHZ2GqXgiuoSiyFk0uKQGqdnJGLsqgyk1bhO9b8XWqWGiSWZUmR3uQRmwT3xvDmKDMDtCxXMa0kBaK2i1L6qnenA8AQ6rEizEJSNp3DaOSKEeVNHMoux0Nn1iU4dOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXDisUIN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXDisUIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B22FC2BCB8;
	Mon,  4 May 2026 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923700;
	bh=mgdlbKlEQOWDLqR92Whq5tURhflQ2Yr9KuyXqkV/fOc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bXDisUINjwgG9lK4I/Zqy+kk2M+5q38IGKVNjSDriMrjWELbxnJlkuM5RDqwoBYWR
	 lfAY1WaarsJU5oxnO15BRLy3rZmOWDgFmZG6eckX6eUQRbnQGDcSiLYFJcFhnAOOYA
	 Cgt/FlhKZqkjxxT3PWe1Nf81n/pYY5BW88eMoPg3GD70VoEZyh/zZ0666xWTWqhiFx
	 AHLCL5+1TzKcYpIKvZx3v9fiqkrvHd8hgrhf4ksarSL/AG7dW5PvcXnhcgwZu5/hH/
	 n1z95QK/UCsjVOpdF6t4WhT5kJnjMhy5YXZxA/aVuxabP6ViC9shu3G8Cs9M/ATX/P
	 iD6hvGg1cWrFg==
Date: Mon, 04 May 2026 14:41:38 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Zhang Rui <rui.zhang@intel.com>, Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 linux-mediatek@lists.infradead.org, Andy Shevchenko <andy@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>, Srinivas Kandagatla <srini@kernel.org>, 
 linux-iio@vger.kernel.org
To: Roman Vivchar <rva333@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-3-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-3-799b58b355ff@protonmail.com>
Message-Id: <177792369830.4148180.15587020526695376827.robh@kernel.org>
Subject: Re: [PATCH 03/13] dt-bindings: thermal: add mt6323 PMIC thermal


On Mon, 04 May 2026 21:24:55 +0300, Roman Vivchar wrote:
> The MediaTek mt6323 PMIC temperature can be read using AUXADC channel.
> 
> Add the devicetree binding documentation for the MediaTek mt6323 thermal.
> Due similarities with newer PMICs like mt6358, which include more than
> one thermal sensor, the #thermal-sensor-cells should be set to 1, to
> avoid breaking devicetree ABI in future.
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/thermal/mediatek,mt6323-thermal.yaml  | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml:52:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml:84:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
	from schema $id: http://devicetree.org/schemas/net/micrel.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260504-mt6323-v1-3-799b58b355ff@protonmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

