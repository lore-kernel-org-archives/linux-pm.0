Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6181A267;
	Sun,  5 Apr 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775374060; cv=none; b=Uz618gaFaTtekt/rMRZ3mWz6MJxzX9o6zHBDXAX1vhY4VOdsUi3xUxk+L246xPaA8r8G3HRWZvCaq5p8JcTlFK05YWWroT+GcWUMqqzDqOcGE40oo9Ti22NxYPYOyTUntOZGEQjY8xDwm30SJ2A7P4pRv9N4yPo01+OQKdcrs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775374060; c=relaxed/simple;
	bh=ihTUzCyKiFXl01flzmcDjBecw+MV1/1LlVi2a8psvmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga1VSlR/dic/KqS7cFcVxmr6zA7hthFDidYzkeJKc0uyix4H03nQ8D5LydH6mLpp1fojYNws2p6EGrKk+O2S7Rx0WXLzdkOAND1EVxXitbPvFg5dMD1D2I/i8w04kdWctYMkpha963kx6NfvuZolcT/datlnSPhv9QUg780ECuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmtQMfoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmtQMfoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CBEC116C6;
	Sun,  5 Apr 2026 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775374060;
	bh=ihTUzCyKiFXl01flzmcDjBecw+MV1/1LlVi2a8psvmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmtQMfoGWZNeFDea3NrWV3Sd3dr5YdG4oy+Ma4jgyI9up5JoSGHVBari8msyxXl1O
	 prAnFYRare3yujTFN7WlOiPQG+9JI7vfNAadZqzG1i8Y78m1uiPdkpaqTJPIV1gtJC
	 Y+aDfnJZG0LhtqXgJ3uGwXYQHZZoU9VhYbw7kw/dBZVKOwihnhhXXeR5ON7JB2btfZ
	 ciWStiwyZoPom3XQ69m0Yrm7GjvnoMV3Rb0lNkWeesVkXyRYvtH60NZeuVLM8DIFJ1
	 BuZvine+fVxdelJyhpObf3/lYUzVrFTYIMnofrk101joFbOtRCggws1UCsNpcn1mdC
	 uIEc2iwIMg/KQ==
Date: Sun, 5 Apr 2026 09:27:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp-v2: Fix example 3 CPU reg value
Message-ID: <20260405-modest-woodlouse-of-maturity-6eddf4@quoll>
References: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>

On Fri, Apr 03, 2026 at 06:34:29PM +0800, Vivian Wang wrote:
> Example 3 is a dual-cluster example, meaning that the CPU nodes should
> have reg values 0x0, 0x1, 0x100, 0x101. The example incorrectly uses
> decimal 0, 1, 100, 101 instead, which seems unintended. Use the correct
> hexadecimal values.
> 
> Even though the value doesn't change for the first two CPUs, 0 and 1 in
> example 3 are changed to 0x0 and 0x1 respectively for consistency. Other
> examples all have reg less than 10, so they have not been changed.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

