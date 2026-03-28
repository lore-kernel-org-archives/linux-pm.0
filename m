Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744312874ED;
	Sat, 28 Mar 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707975; cv=none; b=Eu+u4Z788hKN8qmB0rz32X7U1tRCgK6r41adY1vqGKwXKyyKbmpboSSviOjT84fYWDElYtykJ8qq9vGkOrbjlQuA0/CO6D1IwcIm71kVXo4nod4XMO/c0RIcirGZXUA19tGgTZC7QkAroQPPczrOZ4EoId9B8Ml4zntHjcPEK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707975; c=relaxed/simple;
	bh=pItkkJ/BTnCz9cKOEVj76+pTolQ8B/CGUsHD3jnmKbs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MtiHiPSD5hv3sjGtqEMbjcthRJwfPYRZd1M4xdzusysvXp86P1FJAc16JmGvLIlI8ywg7ZONmbxYgNMkg95m/fIBK66qaDLl4hA2FHsUShwe8AzhKM74Tl/Ev5kaLsc5yuFamDRpeRRO7ZQoZlrMjWXseBaxuGwlm/tb74fwywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3fcEbyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3fcEbyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1507C4CEF7;
	Sat, 28 Mar 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774707975;
	bh=pItkkJ/BTnCz9cKOEVj76+pTolQ8B/CGUsHD3jnmKbs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=A3fcEbyHFpIkxOA3YRkef8UfVu7w16PuUmBfQlgfU8vsyKx2jzWtuaQ8zV+lyHl44
	 EltCcpa+KkFfIg8gaYnogtfsvGF75OX6a1wnTZ7z6GI97sdltQGPPycVzi+NOw1wKf
	 510qPFvqzbxDdHZW+JNFpn6nEnNakbTZ+YVMpElwWgCDUAYW6ebeZ3+gDKdc0YAsO6
	 nPwp8FBg4WUBftOSxIjvf7thLBCgm61NRlVMKLdAMNZqZmJfwcNTKzMo7OFhnxNrTh
	 YNL4tcmatT3SpdY+W5i3yikIwnLK75Ob94magoF81XVkv6UQG6weP/ROhR9+sAl0KC
	 CBz+QamTHUhtQ==
Date: Sat, 28 Mar 2026 09:26:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
To: Khushal Chitturi <khushalchitturi@gmail.com>
In-Reply-To: <20260328124707.141209-1-khushalchitturi@gmail.com>
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
Message-Id: <177470797266.1536342.6967120656934552033.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema


On Sat, 28 Mar 2026 18:17:07 +0530, Khushal Chitturi wrote:
> Convert the Cortina Systems Gemini Poweroff Controller bindings to
> DT schema.
> 
> Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
>  .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
>  .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
>  2 files changed, 42 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.example.dtb: power-controller@4b000000 (cortina,gemini-power-controller): '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260328124707.141209-1-khushalchitturi@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

