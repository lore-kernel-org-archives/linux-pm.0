Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3B4086A;
	Mon,  6 Apr 2026 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515492; cv=none; b=uNU5n5xVodFOOpPIu/Q+F2F4ODKqMRx8dUs9yX7kiTmZ/o+VmyBpAo9GQ/N61HUXfmk3aQlytrfVfRDO7hovnwfbwBIFkyt1qFhO75XIOGthHLQ01e290rcMbZrwbv6d052G04VSvvyEUeD9OJPqkHdi6gXQT2IYR8Ibvi3+Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515492; c=relaxed/simple;
	bh=/CFkjj3+/ryJNmY/lsY7aA8MiXH1RADOaeMkoWo/D8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNtylILJyvS/TILoopwvkSbRi6WVM4AjGBOMbxyDHoSFduWMoJCFF9kcdJpn7erGFQk+KNB65Vlq45by0lW20le35LYEirpgKeWvDTqT26cr3RjkXvZ1R3oXTtx9+Hh8Y/bBEhoUEw00aRZIdgAR9pXPotXC7o5siOxU7gABqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM5pjeN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM5pjeN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FEEC4CEF7;
	Mon,  6 Apr 2026 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775515492;
	bh=/CFkjj3+/ryJNmY/lsY7aA8MiXH1RADOaeMkoWo/D8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM5pjeN24OlBuzeIUZaAj67WpWNdd51wLFrdqCN5TBn2E1JljBiXiMlInEEMMH655
	 J29e+Ji13DiNYtXJfcfz9elrmbqNpWkm2LSm+5CxHCar29TjRK/olpnOHHH3mVxg3f
	 NnfFMmz3Qh4e8Fw6rP9UpgSVHGRJDGmeflmpiP5T+X4tKvgJ0xfcY6UEis39qd8sU3
	 RM18oNoACBr1RW8+zmeXt6ntBXtw5sU+3IpXiwZziCN4n7mQmaibphoRJZiyWkaogj
	 4B5Ig+l/Dkf/ztI4fgyWNuB0GtcYjQQCvlLhdULSd5RnMZGkY2/0oXoHmPcxPfJm8V
	 FOPf9jbPslZ7g==
Date: Mon, 6 Apr 2026 17:44:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
	devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: opp-v2: Fix example 3 CPU reg value
Message-ID: <177551548862.54189.5385282573432382422.robh@kernel.org>
References: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>


On Fri, 03 Apr 2026 18:34:29 +0800, Vivian Wang wrote:
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
> ---
> Found while trying to figure out if cpu@* unit addresses are supposed to
> be decimal or hexadecimal. This is AFAICT the only place in-tree where
> an arm/arm64 DTS uses multi-digit decimal. See also:
> 
> - https://lore.kernel.org/devicetree-spec/00ddad5a-02f5-474e-af9c-11ce7716ddfc@iscas.ac.cn/
> - https://github.com/devicetree-org/devicetree-specification/issues/86
> ---
>  Documentation/devicetree/bindings/opp/opp-v2.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks!

