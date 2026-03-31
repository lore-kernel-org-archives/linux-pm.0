Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190023242A4;
	Tue, 31 Mar 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920447; cv=none; b=C47eI1B6kCMsw+O/RkdIoK/RXhKPOORzBCwblMqLqsy4g5a7gQquHGjZ6G5Xg638xHZ+QuNsug5gmkzqC3aaUCcdi81TYwCYoq2zFrEBDTZHf94XhgyBnyF/wUXyk7NZz3rLL8owY1Ny1Yknb+pbIedyekVmXEFfxHtnTDXLiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920447; c=relaxed/simple;
	bh=kapsyZIBVUroUUNajFkxmom2J6m4kP6pbhF+wtAGe1w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UWuYr8dukaGnIKPKLbrAezy2EHwzQHLWsJbHeHJ2ax9CQDh8qtx848b31fFVHrCDKUdR/w+zGrZbm/9uJsUNba6H27eH70W6Yada8BjRCZ3mfQ9frhRFPEojA0tVV1h5bennHtf7Z3FmGaZbvjvhM0ecMPlrSZC8SWCbIsixHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2zfqob1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2zfqob1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564AAC4CEF7;
	Tue, 31 Mar 2026 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774920446;
	bh=kapsyZIBVUroUUNajFkxmom2J6m4kP6pbhF+wtAGe1w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=s2zfqob1JZMTVWiaB6+EWyeeD3Imgk2m0lidZuq31dXI5h2UG+dyvc7ks4E9pGx9u
	 1sxWU/3N3Tf1Cy+DOXxGhDOMSvIdm4hIMo/WIPyAVYYOFx2ZXey16x46OVkwd2UQAY
	 Sobanj6a9GS9mZGftMFIcRU1H0h8VE9qh277OMNJqvzSGiqJiA1+e6TTOAPRvnF2rp
	 82Eb6TQ5pZd/XmV1860HzByoCsKEJUXgv1hyMf1fvn0XR8/X06iszKyDq8VBQeiFsH
	 LJklszk3vpJMzww5kYYZw7XfuoIn198PGPz2iP+MNcJtHVWq2SQtj0SN5vvr7oPmE1
	 OHAXNYVqzTWKQ==
Date: Mon, 30 Mar 2026 20:27:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
 linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
In-Reply-To: <20260330-icc-hawi-v1-1-4b54a9e7d38c@oss.qualcomm.com>
References: <20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com>
 <20260330-icc-hawi-v1-1-4b54a9e7d38c@oss.qualcomm.com>
Message-Id: <177492044387.3803846.4874547665749104183.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Hawi SoC


On Mon, 30 Mar 2026 17:40:00 -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip Interconnect of the Hawi platform.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,hawi-rpmh.yaml      | 126 ++++++++++++++++
>  include/dt-bindings/interconnect/qcom,hawi-rpmh.h  | 164 +++++++++++++++++++++
>  2 files changed, 290 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,hawi-rpmh.example.dtb: interconnect@f00000 (qcom,hawi-aggre1-noc): reg: [[0, 15728640], [0, 345088]] is too long
	from schema $id: http://devicetree.org/schemas/interconnect/qcom,hawi-rpmh.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260330-icc-hawi-v1-1-4b54a9e7d38c@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

