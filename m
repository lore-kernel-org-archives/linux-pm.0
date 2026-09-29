Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C714772BF;
	Tue, 29 Sep 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671179; cv=none; b=qWqm9h106BeiusAVvbtqr5I5CJRkepdLFCn0AIBK9PP5bxRIgjpdtVLsI6BnpkL5mozyLMGKbUIifI2+nCjPcYbs7WLKywjza9QbfwL2q/BZM3+UiZSiR72EJcLSedF1YKR02Td2VRsKG61JQOB0TG4IPftGY5c4MkGKI23Wb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671179; c=relaxed/simple;
	bh=9XLVLnpAd04sheys1cEFbNRxuH25X5RyWkhQaJt/wZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJw7xr3iT/2ltKwk7LoL+EX0KPTrO4oiyPhsp/PbsB8D4l91GPDbyHH0FyhsgT45g00ZpbvnHNIc+ms3L+dhNGdW7txoLK6AMcOoM7qGTgcZwrWejsgzhEWlApRKs8aREuGpqs3pFvBmEYFUnCA9mlS78kJHnPBq4w9Il7Gv0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imd8QD70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imd8QD70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C71F000FF;
	Tue, 29 Sep 2026 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671178;
	bh=APDT/Ge7NyqJm0LUEW4MYf/ImZiM+AqEbii4Z4M87Zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Imd8QD70VLom82XyvrlV2U0dHQnHRjGOV7ix+4uE8cEUrr0obacbMCo8eJgn/fhVS
	 L3oVS8OuztmV/SF00n1dG94dzumISFWsr+t875TzEeepJWgSXDAcvQmFGt/akTvu6E
	 JeA+kKd0HtLXpe80LOvKyEU6bFPWrhE6UDGyTEvUi/lj9Z96JW8GpXhBZUq1LxSkcz
	 mWurn+2V4ps4NyVKxqqj223uzkFK8lWkD+V+3To7+JJzpCl0dXoyJwstTqGsa8x8qH
	 Q59kIplYv9lqLWJ5/jVVChT0NUOk8cCXFafvlP6y0qUTMgGMXk6SeoaMmFeltnNMWy
	 KyWHDBLfBw0uw==
Message-ID: <8df7fdb2-813c-402c-99c0-9de6b0dbcd0e@kernel.org>
Date: Tue, 29 Sep 2026 09:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add Qualcomm CAMNOC ICC provider
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
References: <w3u_oVZRxmZkAlC5RmxuB0v5k970jezsVHDZvryQ3oYkStqmsp79LjODiA0mYkNl1jkRya-7Ncvk8KGrE1vnUQ==@protonmail.internalid>
 <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 10:32, Atanas Filipov wrote:
> This series adds a device tree binding and driver for the Qualcomm
> Camera Network-on-Chip (CAMNOC) interconnect provider for SM8250.
> 
> CAMNOC is the internal AXI interconnect within the camera subsystem.
> Multiple camera sub-devices (IFE, JPEG, BPS, IPE, etc.) share
> CAM_CC_CAMNOC_AXI_CLK. Direct clk_set_rate() calls from each consumer
> cause a last-writer-wins race. This series introduces a lightweight ICC
> provider that aggregates bandwidth votes from all consumers and applies
> a single clk_set_rate() call.
> 
> Changes since v1:
> - dt-bindings: add all SM8250 CAMNOC master port IDs to qcom,camnoc.h
>    (IFE 0/1, IFE Lite 0-4, BPS, IPE 0/1, JPEG, JPEG DMA, CDM, FD, SBI,
>    ICP) with a short comment per group (Dmitry Baryshkov)
> - dt-bindings: add IFE simple consumer example alongside the JPEG
>    OPP-based example; clarify opp-hz and opp-peak-kBps semantics in
>    comments; fix maintainer email; align provider node name with DTS
> - driver: register all SM8250 CAMNOC master nodes
> 
> Atanas Filipov (3):
>    dt-bindings: interconnect: Add Qualcomm CAMNOC ICC binding
>    interconnect: qcom: Add CAMNOC interconnect provider driver
>    arm64: dts: qcom: sm8250: Add CAMNOC ICC provider node
> 
>   .../bindings/interconnect/qcom,camnoc.yaml    | 124 ++++++++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   8 +
>   drivers/interconnect/qcom/Kconfig             |  10 +
>   drivers/interconnect/qcom/Makefile            |   2 +
>   drivers/interconnect/qcom/qcom-camnoc.c       | 279 ++++++++++++++++++
>   .../dt-bindings/interconnect/qcom,camnoc.h    |  52 ++++
>   6 files changed, 475 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>   create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
>   create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
> 
> 
> base-commit: 9e970952a9503d6ab471a2fea4c10b6a2785406f
> --
> 2.34.1
> 
> 

I'd like to see the code for actually _using_ this in CAMSS, seems a bit 
incomplete without that part.

---
bod
