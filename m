Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC993BE652;
	Mon, 31 Aug 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160413; cv=none; b=mAluhnLJOwm9cQiRv2xDlSvHqg5LKhtOgm6xfJumRRl7sxf5pJV8DjiNcpz+ICVZ7Lt9t9sVvWZJbjf6knQhmO4AbniA2P7sKqzZUZvtTM9Ibw2DQd9jrZ2/skQfXqNVoRxlg/+2iCfUjOqL0pMSuCLZngUim1vpXAuCmi1yNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160413; c=relaxed/simple;
	bh=DxqPqtzTp8mxa4pd1eQE88Yy6ixGznKpTnusIop8ubY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StqFQV8X4JNmHjZLLIpOg4Ws7/aGcF8ZVx1jtB0r4+2Ksc4vPog29EmODQ2fn7T0yIkBFf/jcTkiQjdLDQkDXW9H3ers2C8BAwDdYgVnu0d8+wHWlRDWNDB4AnNr57G8LqoFvhJKUZRYGnT7z4slX03SMcqLLign5g8HTiE6tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqr/4LOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqr/4LOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F511F000E9;
	Mon, 31 Aug 2026 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160412;
	bh=nzwDhMUaspxwPlR3epuNtDGJEcxkDmu+JR/CLbni2/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqr/4LOntZvMk1raKJwDPLs4PrbOimbFQe+cAb+Hoj/TrBZEWIWZrrc9hivVHtD1x
	 ApUuRoJsZ/WJJRLArudCfWfQ3DWAIK0rXpSFJMls+Yi5tIQdx5V5GUJ1S1IzB9ppPi
	 DP9y7sor6Q91pT6oBuI4ejk1g+yg3zjYZPwIrgDHpwJc80OU5AaeMwu3JOAIJK0Jeo
	 foQPTRHAaFnJ6T3jhcUUNoWnnuA+dSW2eTVgDZKU8QzO0tjspubPDPhWFYbJJ7NjtT
	 B3ZDPZqi01/VcurvvYfN9SSzUiDDShNm0bPdb6eyuRl/5zlbAN8B8yAmIMp8SxlFib
	 XVbHQC86MUKkg==
Date: Mon, 31 Aug 2026 09:13:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
Message-ID: <20260831-rainbow-terrier-of-flowers-3fd2fe@quoll>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
 <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>
 <20260827-riverbank-cinema-d898d4e5a522@spud>
 <apBwZwOkctBETKVJ@orome>
 <20260827-disband-retrain-ad995df47784@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827-disband-retrain-ad995df47784@spud>

On Thu, Aug 27, 2026 at 06:33:06PM +0100, Conor Dooley wrote:
> On Thu, Aug 27, 2026 at 07:17:15PM +0200, Thierry Reding wrote:
> > On Thu, Aug 27, 2026 at 05:35:28PM +0100, Conor Dooley wrote:
> > > On Thu, Aug 27, 2026 at 05:07:51PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > This header file defines the set of thermal zones exposed by the BPMP on
> > > > Tegra264.
> > > 
> > > Does this need to be a binding, since you're just using it in the dts?
> > > Can it just go into your dts directory insteaD?
> > 
> > I don't think we've ever used these headers outside of DTS files, so,
> > yes, they could go into the DTS directory.
> > 
> > We've never done that before and there's a bunch of Tegra-specific files
> > that would be in the same basket. What's your recommendation for any of
> > the existing headers? Should I move those into the DTS directory, too?
> > If they are not used outside, that is? Or not worth the churn?
> 
> Up to you re: churn I think, but were it my platform I'd probably move
> them. 

For Samsung I moved all non-ABI related headers to DTS. I think one more
platform followed. Moving needs to keep old header for some time anyway,
so it's entirely up to you if you/others want to work on that. Like with
every less-important cleanup, the benefit is that correcting old
patterns stops encouraging repeating them.

Best regards,
Krzysztof

