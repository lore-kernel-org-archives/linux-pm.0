Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DB4C6D;
	Thu,  2 Apr 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118899; cv=none; b=lOLsvH/sV5PW27BD3oW3TnfGd2E6DyyS/7r7sGNxxTr6GostR+oeLNlUlUgiPzgqIGIaaS0QNLNCjYh5CgUdNsXOR6phaw5Z49mWCk/Yic6OHiqHANicXsHKLQSYOKy6J9hbu9+00l80reMKGeLTedJsmA0WhWysU2h3oL0HOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118899; c=relaxed/simple;
	bh=AN1/6eZW0wvj995vM30V0a/DcaXupU3vIlyvDAfOmnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuacKR8BoIdJbJ2Nj558yEdysNNkBOxllylz501b8kwFqnbo+dQaewWxn63iNMAd3iQnzrksGBCVoG7M9OjA8Po4MvwL7nyg/Vc/8hXn8i5jnAjyXDPupSd0/Sg+75jHnGJD9UimqXF1YVFCLcZ/HDYdaOUhsV8XJ7xuOZs8Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEk7h3qC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEk7h3qC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F6C116C6;
	Thu,  2 Apr 2026 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775118898;
	bh=AN1/6eZW0wvj995vM30V0a/DcaXupU3vIlyvDAfOmnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEk7h3qCPHFgsJMMj4DywJBkJAya6LRwgPgAIes6PH37xZRPZrKrWAE3PT69WAfb3
	 S4jVxRE2opyy+B3Mq1E9gFTXPMUEJlrphSOrDc1HAoNL8+f+/9w59h1cLgHprT/6VW
	 Rdgy4vJsfcyhgc+ffOEEeqd3ZcgHkQYa7efEAQIRcxNRHmZl48+/Z7VtB0gxwHpRlY
	 nppn0Ow0anNfCrsn5Tv7ZwokQrV7WtvpENFcOlSK9LaAZ+F5dJXFxyLJtQYC4xZePh
	 7k4b/6JS5vKw6zTK0OzNPKvMmHvkXe15zsBPo3/odRdfyfVotRk5R1j8aXnz0vNZ4/
	 IGMQ1UikYlbmg==
Date: Thu, 2 Apr 2026 10:34:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@oss.qualcomm.com
Subject: Re: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add new power
 domains and new levels
Message-ID: <20260402-great-affable-panther-1a5ed7@quoll>
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>

On Wed, Apr 01, 2026 at 02:15:30AM -0700, Fenglin Wu wrote:
> Add definitions for the new power domains which present in Hawi SoC:
>  - RPMHPD_DCX (Display Core X): supplies VDD_DISP for the display
>    subsystem
>  - RPMHPD_GBX (Graphics Box): supplies VDD_GFX_BX for the GPU/graphics
>    subsystem
> 
> Also, add constants for new power domain levels that supported in Hawi
> SoC, including: LOW_SVS_D3_0, LOW_SVS_D1_0, LOW_SVS_D0_0, SVS_L2_0,
> TURBO_L1_0/1/2, TURBO_L1_0/1/2.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

This belongs to the binding change. Unless you are not doing it for
Hawi...

Best regards,
Krzysztof

