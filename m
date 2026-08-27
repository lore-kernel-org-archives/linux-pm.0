Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1842F1FDF;
	Thu, 27 Aug 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828386; cv=none; b=JtA1bTH/K59KfDUcmpD3rWG3/tpWXftJOT39P9JbTHHDhLNnDA10x5xvmIwDsNrnUWqXeNV7ntVVBcHFRpy3Q6iJu63ejPFe7VdtgHTxbcpXdaEBy4p+rWilMobex1iYPjiGy3HglZ9JlMezMAQtd7oLvJFi+Rw/o9pP7fAVejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828386; c=relaxed/simple;
	bh=bRHjGVgVZwcZPagqQ7xNKpOapfbrj7gFrpPk376Rjr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M87mIECRBGZmqhtuHlO02BjasDxMs7hsMKajKRDqX4UrDDwoQFNnOLmFvizQJNmFa4r/DJWtPexBjq2VV8K67r5qc4F6vDB8o64F7/pl7cbp04PLxQvM8Vv+dQWOFNQZLoBLZbqiyq4iZ9OmWCfDNeLHMAyFjFB7pPFMUnu0WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrLSsaOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrLSsaOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8D1F00A3A;
	Thu, 27 Aug 2026 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828385;
	bh=TZRsV8vNDRVo9F7ciFv80HfJau+HMywch8sw/p/3+B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DrLSsaOHitPY8kuAMzVmS0+h7w76MxSkY3uNic+yobFGOox+53E/Cqw7A1zwD7A1m
	 06qcdKBdKfAoWEv0S1V6Jh0a903cWMHIbQLGofQXdOyVQJromPN1jyRShEO2XWxV6k
	 mfb3V4TonAZJNVeKiz+9KBtXQzoIfn5DmRwGKKSYma947Prpw7bAeFJOvojPYNhrVd
	 U9KwxW6mrTlzYem8HRAv7vCinfj5tV4pm/SS8Cn6HwFQ8CBHocSyORAw5V5MEVu53y
	 JhB80F4bgurzi2AzWfasd5SwtZSWbAPJ9rFTiePwX5Bzj9nGyqBZA8b9rCx4IlCkWj
	 mJDP11DzrM/aQ==
Date: Thu, 27 Aug 2026 12:59:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Linev <admin@mswin.me>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: add
 qcom,sm6125-tsens
Message-ID: <20260827-elfish-quail-of-saturation-eb65bb@quoll>
References: <20260821030325.1823829-1-admin@mswin.me>
 <20260821030325.1823829-2-admin@mswin.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821030325.1823829-2-admin@mswin.me>

On Fri, Aug 21, 2026 at 06:03:24AM +0300, Roman Linev wrote:
> SM6125 has a TSENS v2 block with 16 sensors. Its register and interrupt
> layout is identical to SM6115's, and it needs no calibration cells
> because v2 self-calibrates, so it is generic apart from the SoC-specific
> compatible.
> 
> Document it in the v2 list, bound by the qcom,tsens-v2 fallback.
> 
> Signed-off-by: Roman Linev <admin@mswin.me>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

