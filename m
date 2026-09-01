Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454203128B6;
	Tue,  1 Sep 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252322; cv=none; b=HJ7t3sQ8H+E2NtdZMexRdLXVgDOaHTQuFKXhzdB5QipG5FPaq/unb8Nv0FEze6LUezeQZFTlgrAc1ECQUNkatPaSeLFu7DvRx1XM5UnQsp9j/LprTwqoJ0hMo8PMxvgBeBOX0UXMH8Mhf8BDtkJIiId2yYDpH8Z+z2+45Of5Uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252322; c=relaxed/simple;
	bh=uQSoVjcK+lMlmoA/C9r/QFPG5Au4WnyAPBA+MTeASWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukj0HcI5ceJUnvKCpKPFxKljPEPl2k0ln+ptJH83vd0LgqoaMkUnxa2b2hM9fRiLejfY43YUJxeOGYU8L3xz6FhVD9sW+XZCsy2TljcChc9+HTWMHjjIcKs5BCp8xwfUZyt2JAppyYac75RXb5R7FOEbqmfnvG/xgwr3PDiEoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqC/HOVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqC/HOVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079141F000E9;
	Tue,  1 Sep 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252318;
	bh=ZI6RhrNjelrLJnYNZnIRhgWOUWb2weSr68SncbR1Pzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NqC/HOVXbR1yJWMxBgaowTRTVlFL+X2Dhgb6FWn2wedonvxshcgL1w2DikA3S1DWe
	 59aScJCTYoxx9CAwZ1UaD3jWunwDo9wyt+squEc1HW9s1nwLf3uBFzq7v97XvQUsHw
	 VH/Bvu5yg1Ia0tB5D6+3x9QGgH1zxRrvhmKpMFD7jwFIeA6KwFVQ+y8nrW/c/OlRT4
	 CzXdc7ZvmhTfiBPt5gR2iNHIor/Sc07A5KdAL6ZyOJ/aohfu+mVu0v1pu1ZvRP4qUV
	 P9a/MKwSon924J/nZZaa+FRUMlNlTLPrRt6bazqZikRYnlWvb7AbsRDq4GTVf/oIRW
	 Kowe33XfVkMSg==
Date: Tue, 1 Sep 2026 10:45:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, shengchao.guo@oss.qualcomm.com, 
	bartosz.golaszewski@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord
 cpu-bwmon compatible
Message-ID: <20260901-skilled-frisky-serval-1cadf5@quoll>
References: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 05:01:34PM +0800, Zhangfei Gao wrote:
> Document the qcom,nord-cpu-bwmon fallback compatible used by the
> CPU bandwidth monitors on Nord.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

