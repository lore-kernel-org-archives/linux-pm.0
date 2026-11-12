Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488342;
	b=KQY7Md/fXo3oSLvb+y8vzyzPvxKyRIg8M6nYDXWpexxoDt6bUR7kLcjL3/ZgM/nddfbZ
	 nD86uFeqh6+LD93VCXNeuH1NZ1MH61mLviWS8vqlQTG9Daw7mgc/it/7YJ7ucbQtN7Tmy
	 tvdTzXRTc9NCGVZT5PJE8n4kts/evFUWqeJT1t/KCsltqmC78D6r0IRMedfsB6+r2IqDR
	 fZLsDp+x9oQcDq3c69WPqodru7ZZ8z0KyV4V2hEQ0PSfHxG/68I9ckIEEx1lNPBJK0TeF
	 sWvNsc6V3TIJKILEzE4ysu1Mtid7l+PVeiAKPJSZcLDIrdzz74d+Fp6AZTucQQyseYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488342;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=QbfioGJO9aW8l9BBJUgChIfHsDQ36cO1EtliCR8l2Cc=;
	b=4tSiD5Yy2/ZasYkx0lnxrHMiRJIkZfB+5nkBUAQOX/6ljeGIfdGZpwjm8qSxe/QX4Chd
	 FuAV7SU5fzbrmJXzvH7/IkFKxkQUXpwn9F7X/RKIrOPkgM25DPMsnvCG8zFqGO0VDoOSq
	 IhHstkoLR9D5k+jdYg3wm+/V1NSsfCfTIJkoC5zgMjRtA9hatZoROIU7dg/ISjcU3k7/+
	 /osNaZLPmH/TDqPKolf/NpSgfBQi063msrzUkynNVW5a8HTyGmy7sRfIt+hF6kkIEmQws
	 ln3ZpoOHAsn0osnAfRmgM81MeOYqKuTNHdh3IF8cYnxIRLU8nvksG25brNG+SldHClg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBaRhlKM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379E606A323;
	Thu, 12 Nov 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBaRhlKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1221F00A05;
	Thu, 12 Nov 2026 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488341;
	bh=QbfioGJO9aW8l9BBJUgChIfHsDQ36cO1EtliCR8l2Cc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=HBaRhlKMml47LCxqMg2kNawbQulMRmhVRQzpLrp1LA2sMsXq0FQ96mEHYgqO2xwb8
	 FizyX1Xxmt4UCyXm/2VKUs4UolfIUhWl+Hr2nz4zI8pw74ALHhoN5qQituTFafrCx+
	 5IqNrgAZad/am4Esup/rP9zGFGrDjaYzCqXI9l+IiAIqPZKw6K+xuxqRQFvBOCO3FB
	 drJzfc7GNKpEWmxYnSVXG8PkKzBiySAajbSe93DKN8sVxHz91vVu+kZ2ZEmsaP/Qhb
	 WoUjmQ0AA/B+H1Zdu4GCgIYUx2sh6jFmdcGlxObn7aiD7MH/FjNWAdMdUzgOMUO4di
	 zVn03tC6RLyzg==
Date: Thu, 12 Nov 2026 06:58:59 -0600
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
Cc: devicetree@vger.kernel.org, daniel.lezcano@kernel.org, 
 lukasz.luba@arm.com, linux-pm@vger.kernel.org, conor+dt@kernel.org, 
 rafael@kernel.org, linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 rui.zhang@intel.com
To: Shaunak Datar <shaunakkdatar@gmail.com>
In-Reply-To: <20261112072925.22075-1-shaunakkdatar@gmail.com>
References: <20261112072925.22075-1-shaunakkdatar@gmail.com>
Message-Id: <179448831566.3881804.12223429512014814299.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: kirkwood-thermal: Convert to DT
 Schema


On Thu, 12 Nov 2026 12:59:25 +0530, Shaunak Datar wrote:
> Convert the Kirkwood thermal binding from the legacy text format to YAML
> schema to enable validation with dtbs_check.
> 
> Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
> ---
>  .../bindings/thermal/kirkwood-thermal.txt     | 15 ---------
>  .../bindings/thermal/kirkwood-thermal.yaml    | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml:32:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml: maintainers: "Nobuhiro Iwamatsu <iwamatsu@nigauri.org>" is not of type "array"

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261112072925.22075-1-shaunakkdatar@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

