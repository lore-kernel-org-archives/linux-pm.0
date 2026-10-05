Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95F30C171;
	Mon,  5 Oct 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220220; cv=none; b=YhDuV0UdIXrgFnII7rZdaiRdEoTIiVN3BRcy5lnUE8/JemesLwYO5QOy117JOOzrTHRPw1JSWLk1nu6Uq6Gl8LdzeR587Sa39+Mpn4n+/O1zjYg7tSGOB2jYioaQz1YZEbaGCqStUbGwXUaOLN6PbUHnlEvDH/pSnG0Rs7K1Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220220; c=relaxed/simple;
	bh=yDEzQord5aEkactcvC91rQ1pfLSNa3dnnSS3IXTYPes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucll+/KPl6QbucDAMPE9azONw5W9aAvCLkxLCeXcNXTreimlM0hvXnvt4GVPC5ijVD7+ZCcSYD81SkW+FOjLaFcn2WsfJ6CWrAFLiNbRQbzV9QLcxiVK9+nRgJfUZS+bx/3ZxgbWm62SMbZePDL3XTDyL3ILu33ri1fUsrcNYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiYDJ3lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiYDJ3lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5531F000FF;
	Mon,  5 Oct 2026 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220218;
	bh=j+FzQmuFc982Fpyb5YqfutuQqzkwuNPpJt3TwtEdCzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MiYDJ3ljjFkgVwu4NDowIS0GwcjGcd2Z3idP3d7rEpbtUfSb82gRGKK4OmGNmopyq
	 8e6LMsNXkyiXnOskYtswS7cxFmGbF9RXeoYDwLDgEdN2n0N/pElXA9ZL6IBFjHLii9
	 jbudxFqGr6PfGbup+Z5L/O+gpaJlw0gTwMiWxcuMz66JKtrbajGhEJq94D8dqsgL5e
	 tLoH835XpKxbDhy6CX8EKudVx6CO8+ZTyzOFp0DYM3qsGuAT0ZHqUwvv7u7S6uupmJ
	 Vm0XTISFBx/6bt72pXIG3Ietg38jEVw82bUxL8eCOuR5n1J+sCH2icQMy8MY6QBY06
	 XWWq68egKuyDA==
Date: Mon, 5 Oct 2026 12:10:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
	linux-pm@vger.kernel.org, Brian Masney <bmasney+clk@redhat.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: devfreq: event: rockchip,dfi: add
 clocks to rk3588
Message-ID: <179122021710.1033485.12654188717454178869.robh@kernel.org>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
 <20260921-rockchip-dfi-cleanup-v2-2-43ff34ac8599@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-2-43ff34ac8599@collabora.com>


On Mon, 21 Sep 2026 22:32:45 +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> RK3588's DFI has pclks for each channel. They just weren't noticed as
> missing until now because nothing ever gates them, and they're ungated
> by default on power-on.
> 
> The RK3399 clock situation needs no changes, as there the hardware
> really just has one monitoring unit for both channels.
> 
> Add these clocks to the binding, so that drivers for this device can
> properly know about their existence.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 70 ++++++++++++++++++----
>  1 file changed, 58 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

