Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD038E133;
	Mon, 13 Jul 2026 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927866; cv=none; b=SURasnmvNZH6VsW/D4JbsqF2A+/IZG2jfc8TJKEe1Ph+ajj5SoVEIbN86+SnBP72EbFJHU8TCWPPgszTGaztQOE8S6T42jKpEGMmMdolTgzay2k0gHlg4ClPsK11FT2eeJYVNY/bEmqySyZDfoP7rvaF8TYti4Se8yrXplFGhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927866; c=relaxed/simple;
	bh=uUPmojSvRJjdxDTfSrqL6xDcavcrxh1FCKzLi5plkO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svJCNJs/aLVHIEWJ6woDhG+vi4g5QVgtUQMrKfmCoihiwTj+bTWK7r5XzLiO1COk6oZjSDh0vUqFdjr0XZAWwF6safkU7fqfKHBYPBTYxG/ZB43e6UZbUvHT36fuBG4gePWIPw+M5l7L2G8PJrVs/UIxUpLH7GDDn19MFg5KR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Qkb32s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Qkb32s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC1E1F000E9;
	Mon, 13 Jul 2026 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927864;
	bh=KCDs4r72wm4+aWixawv9t2EtC+MrFNUw/QnmSNHgASI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H0Qkb32scuMJAg6lmDTHcHLtDE0tieBnUEl8BJeU4fNX6ixwSiQONL+YF5sN89wTf
	 dPidT1mgtFrIe6V41jfYLuqZ4YP6lrvjco0YJMhteZIZVhuLaEfrvMHcyjl/T3qxR3
	 JIgDQC/Bxr60+TWFS8IxSCOFj4FH9Keqp/sIuvXQad63gUqp+FIrW4MfhxVpPvTyDV
	 ViCrt34viGfJ4YoH4Zqe/A6ZORbzx5QisSdOXS4/JB12r0KOBHDl56B0keP+olmTmg
	 J/RYyjK+pxj9hUkF/Dhh9XDZsytNs2V+hyjdTOoSnnkmOPUL18O4mKXU4AIuSL7P+G
	 n6hLplKChsa/A==
Date: Mon, 13 Jul 2026 09:31:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexander Koskovich <akoskovich@pm.me>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: OSM L3: Document Milos
 OSM L3 compatible
Message-ID: <20260713-intrepid-archetypal-malamute-eaaca7@quoll>
References: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
 <20260710-milos-cpu-opp-v1-1-ae7f4b09bc77@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-milos-cpu-opp-v1-1-ae7f4b09bc77@fairphone.com>

On Fri, Jul 10, 2026 at 11:22:39AM +0200, Luca Weiss wrote:
> Document the OSM L3 found in the Qualcomm Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

