Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532393D9680;
	Mon, 31 Aug 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168711; cv=none; b=qg8A8l0xxfebu31szTIpe2VkmlNPuWRiKxCENjtdCuOrqJKeOWVn3mHB3Y6NObXv3kM1df4ntr7av3RBw1QpB53pmdX4QnRFrpyvxeO55QPSy+G3+LOL9wFLMvo2kHqxT7aE+8DV1zQw9ojKCwdXp67em33rVxvu28eKEBMctZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168711; c=relaxed/simple;
	bh=A/vt1hf0Z6gfuhvuYt8mGNHjXcdcuBY5UjxheryYVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXD0j3m0nBvrk2GoWH9vfySFz7hQsmv3s030N9Fv2KNQmmUmiG182Y+I4csieAbBeP2ZGbI8/XqGNfQM56WxnoHI+lK/G0VYqTSxjTx/lTy6+i8RtR2mQxu8oYuhkFIa+IXfggCnpkAFqjTpw273bm8xbv14Xhr3o9HsXLgMVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPlWHXg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPlWHXg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB31A1F000E9;
	Mon, 31 Aug 2026 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168710;
	bh=I/ZLphTPjUkEeHKsQ9Nye7MuF7iO1KEVcoQ4aJjUww4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EPlWHXg1NML3NxDQYNNqFlvMhreEaA8zk2aGoZ0XTubZIhFjC85EhDQSlCqT9NLh1
	 o3UDmlv+4LXBwmxLPqg2M/C4hjC+xOkwvS4X6ogJ/38CBquHp9XNq3bLQisliTRekm
	 JSKZLFE3tAHdLVL2AhVebk40GgtkedGabDQUDZwlWVLEN8zLl/9Whpjt4wQtcHvkZe
	 2Ag9PM+Q+umblIw9DnRaCxnc6kYmLE+N1PMT3S9Wn7nwBrIGMsqBl/NpO9WqMPFpqU
	 518P8xc8g+4JnCFVWUbSsiunCPTizkgVkKuld+t0mR4XlOaQcjhtz1+cytG7B6w4Zg
	 uLol7I/TqKovQ==
Date: Mon, 31 Aug 2026 11:31:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dhruvin Rajpura <drajpura@qti.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom,pm8775-mbg-tm: Document
 PMAU0102
Message-ID: <20260831-finicky-holistic-mouflon-1e8bed@quoll>
References: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>

On Sun, Aug 30, 2026 at 06:10:25PM +0800, Shawn Guo wrote:
> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> 
> Document MBG temperature monitor on PMAU0102 which is programming-model
> compatible with the one on PM8775.
> 
> Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

