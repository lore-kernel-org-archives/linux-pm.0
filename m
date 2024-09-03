Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF7185939;
	Tue,  3 Sep 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377253; cv=none; b=uAMwOAd11+U4IlZAUjMP617XT7XcVANnn5W1/Ykb9fnOfNG4pX79xls2zQEhVRJukCmOhY0nWJnnXc+J0185gOFMcsBzyJFUTNXh329Nps+FQ4KtAejEgIPF7+FGhEgAf/wNWAIxhxdd1wbqoI+EUE/emI3zfa1fDXlmXiHwhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377253; c=relaxed/simple;
	bh=OfZOyhZO5T5uML9tsbGZ34vqRSWcEd3I1hhAf4cdeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7pE2DvGXD2tfMVqchH4yL4vgHYU9p3khMd+bqJzTiMl1P8qhBjgM6Oqqj5VpkGp9nhK1qX0ADxdxBDLCtXg5vWRtusRDkUp5t+zeahLSvT178/9Y1oGRU0HSrt5bP+H51yUthTPWIt65s0J+p98YajeobqGrccnrpvVR6rOIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XygraH4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XygraH4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA80FC4CEC4;
	Tue,  3 Sep 2024 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377252;
	bh=OfZOyhZO5T5uML9tsbGZ34vqRSWcEd3I1hhAf4cdeXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XygraH4VmEUHzxTlfR4nLAWVVRFkG0vE6AG7dF+ANhxAkQ41PKc2XyU/IJcixNdHI
	 6pidOBsRSPSgWO7sFt3mAayAtg8pmerJXmQF1zyFX6rVEStfmVi+UrjzQa69Av3vpc
	 F7wmGNsQfOB551wodS5jNRHhdOk7RuITSB1tD+R36mwqULVRCEFv7SQjMkYXJbj9XQ
	 lD0X/On+v7o0lKb2o3PhVztMo6R7/BAtaDhUm6/P/dy/3VaF8O4QHAXWFvfpru06Se
	 bzmAGsZB9zZFzfXij44TkJos1yiLfQu9NMwyNJJCQQ10IZZNYBpzp8lgaBi49H9hv/
	 jnRRv0Sh2qUSw==
Date: Tue, 3 Sep 2024 10:27:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: opp: operating-points-v2-ti-cpu: Update
 maintainers
Message-ID: <172537725130.1047891.15632036914164875871.robh@kernel.org>
References: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
 <20240903-b4-opp-dt-binding-fix-v1-2-f7e186456d9f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-b4-opp-dt-binding-fix-v1-2-f7e186456d9f@ti.com>


On Tue, 03 Sep 2024 16:00:08 +0530, Dhruva Gole wrote:
> Update the maintainers entry since I will be taking over this file from
> now.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

