Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EC47885C;
	Thu,  7 May 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181904; cv=none; b=jY0U6BLolu4tTN54+bUMIZDSvxJsNncHgERMdKJO+4487Ko0B9NJsWrw5iY537UwTZRvT/FghE/a1rwayFMEb5VD7/zzDVEzQvKgwIaXwW2/r2L5HMCemgtpZ/wzkvorJS8YEawF7YmyuIFHHM1KLgylUPl3ykKkkN00yyxyqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181904; c=relaxed/simple;
	bh=6QWGpdlv+Uuk8ptkYtEq7bplE1FYRCsaKfOAlEUPp58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saSwExMgdT/lODqEx8wQhPuZ56qAouNQ5tx6SWo+cL7V1H6ENweENV34QgDHZ8r06AqbHe0bmAgzsauTtZ3DSqKcf06Yqv5SBzMhqKaz6UkKP/niA3uxuNZTtMvnjaky1uD1u4AbfP++K+Eb9J6nKr4cy9/xOGJYfer8h6QTmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRq4pNxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRq4pNxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE1EC2BCB2;
	Thu,  7 May 2026 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181904;
	bh=6QWGpdlv+Uuk8ptkYtEq7bplE1FYRCsaKfOAlEUPp58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRq4pNxCfcL1T0eqJxS6NxsGMq04Ql8xwOF1qPPjInJtz+4E6g/5o53mjsp+l6mvl
	 M6Zn0++1Vv5MuBZcRb7zMa4RRSPmjD//7TtBYD5Q7PiC0ZGuDwk8KgUYp1XG75ApQs
	 Ow8SlhUJXbtFwc17DHES0F5tWCNh5y0pUySrDCfDO/DwYcNdfCu7Sxzgi/bENccKgP
	 cOwTjwdUgUtuq9VAhh4q2cuRKzUGJ82tg1KjHZhjQJbm7u67bD5zijbdN3XS/kvLQh
	 xk4lDaW00LZaJSZUyd5l6X3/l1TuvmjxuGF19jaQ4kFOB6XN+BttUCykUchv4uo93b
	 k535Jo6NkN8Uw==
Date: Thu, 7 May 2026 14:25:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: interconnect: qcom,sm6115: Restrict
 children and clocks
Message-ID: <177818190186.2410385.15761927675378741083.robh@kernel.org>
References: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260503161653.60785-6-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503161653.60785-6-krzysztof.kozlowski@oss.qualcomm.com>


On Sun, 03 May 2026 18:16:56 +0200, Krzysztof Kozlowski wrote:
> Some interconnect devices described in the binding have children and
> some have clocks.  The devices which do not have them, should have this
> restricted (disallowed).
> 
> qcom,sm6115-cnoc has a clock, thus also extend the example to be
> complete for this device.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,sm6115.yaml    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

