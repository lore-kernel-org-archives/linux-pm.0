Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB13033E1;
	Wed,  1 Jul 2026 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935674; cv=none; b=UcrEO5pqVOXT2BnQOtoZhsPR6i8AJnAf8Z/PlbW14LWMqiLu81EgF7WOp355gnb1uijC6x3GjNPVMzRf50y8VkscTS77xJtUSk4C4pDCnUsDTBs+CHMSdA9Cakz7CEaBECWDMBGa1IBDyA2n+flvVBbWszIOe1fk+gG2kTK11KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935674; c=relaxed/simple;
	bh=Yl6EC9dGPdSCFCMfLW8JXrzWtHOvXcAjqFjox09q+Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM6c+Kf6itaJwGH0F8grQm5/SvpDWkDrDTgOb+fF/qY2a9MtI1zmAvO4SFuU57ffd/Z3bRsCko7+AX2TZGtC2XcPN9Ulvn72JiiR89J7DIqtSXHRZYCkMxPL/x8GA3PPB8uO2/CIDG5EsvSVmBWsBEcXPoNTrevsRZ15g2k6Q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKQziBTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKQziBTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D371F000E9;
	Wed,  1 Jul 2026 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935673;
	bh=IWUhXsk0B9/BYVLkjf7VHJm5st7qtTRGbplOV534x0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKQziBTFRdQ2SLFHPosHeK1iyWwPXO7ExHX8Ro001uOLEyU9UBtvol1iP/s22bYlO
	 uE2VRHaTZUnsGCSJ8UMdTdWFTxv0/gD7seoSLd4qkShxjyL94uyzbWV0QuOAHuQ4LG
	 SF3CyxQ5WMT0SjA8YxNG2mUjHpsI1C1/IqQ5bdpT1NqyN9JtixuhU/psCJVz8ERDNr
	 mSRqp0acL47oOTatLWUrC7WjQScgIHc2/x9VOrt+q4bQb5LkSCsntf0n5SqOZSlQ3O
	 c1shARwrfWfpE2k4OlnF8uAWYUx3Y4d+Va3KdpMImardukJMwXt2Vf80ADcKoTJQ+V
	 ywVtlPR/yxf7Q==
Date: Wed, 1 Jul 2026 14:54:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom,pon: Narrow allowed
 reboot modes
Message-ID: <178293567196.1622659.10991863325336166808.robh@kernel.org>
References: <20260701105907.197150-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701105907.197150-2-krzysztof.kozlowski@oss.qualcomm.com>


On Wed, 01 Jul 2026 12:59:08 +0200, Krzysztof Kozlowski wrote:
> reboot-mode schema allows arbitrary "mode-.* properties but only a
> subset actually makes sense and is valid.  Provide negative look-ahead
> pattern to disallow any modes not supported by the device, which
> tightens the binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

