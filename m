Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE125CC57;
	Tue, 14 Jul 2026 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069384; cv=none; b=C/VcBV8ug9dVvVFANQXLxPgxV3jcOsKuMuf6PEVQFgQSW5lp7YSVFh88eXyf56P04GxiE/IcOB9HGd5W2dxi/MWkks3ayiq/AtHa0jZ7Fo/w02ibbpFjse8NyIwJ7AgXvTR/H0co4vgpwYDGga/hKgK0LmzuDlFk4gvA6HWAcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069384; c=relaxed/simple;
	bh=GIhijpG2E6Yu8UVi3EtyTNDMQS+0eaChPrFTlN5MqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBCqcfuAToU16EN8v6ZLsAAJId4+YhhHcSthA9UvO2Tj28VbFyBrEhssfZEIODN0AA07BLhkTFwlSZCmbhNdLKf+PyQijnzNFnpqffh04gHk4qnqjLkk4BNmXnigUIZsJGhuzEv0On0rDQ7HuwU2lognVYEQGkjV68YjkcceAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq7tWWJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq7tWWJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6EC1F000E9;
	Tue, 14 Jul 2026 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784069382;
	bh=PJr3xdYo5O85I5lwR0CL/86n0qwagbLxFzej3nisPIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hq7tWWJiyRpVUu0HieOgsngJMw/gTdsmLAn5xy0xztl4JNb0PvlKlQGODIT4SwXdh
	 7D5Ma/KZfAzIEDM9oTGtVkL5fglMB8B186bYLv65uY1gRcMIhYU9ocjkLWbo+XqS7R
	 I/mi6OKEmTIP33GPMDFaZ7wJsdTDM4iPyLUwODMMtWbRtCQI1oS2pO6APxpn0D/bsu
	 04yQyL19SBwAQFDGDcDkgBPsqsUxt+nmY6qjBk0fXQbUwPueNloWAHERlerhA4ESUZ
	 CAMRXMK21Ly7MqVsgCMd1wTiMuw0bVSGt5d+Fe3NeF4PXUA+c2bdFFNqKZRJ891yvz
	 cCBr/dRVJBUxA==
Date: Tue, 14 Jul 2026 17:49:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 01/11] dt-bindings: interconnect: qcom-bwmon: Add
 Shikra cpu-bwmon compatible
Message-ID: <178406933124.3270615.16874673383126107695.robh@kernel.org>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
 <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>


On Tue, 14 Jul 2026 01:06:50 +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
> bandwidth monitor. Shikra has a BWMONv5 for CPU.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, since I picked up the Eliza changes.

Rob

