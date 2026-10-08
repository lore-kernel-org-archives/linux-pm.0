Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA748593B;
	Thu,  8 Oct 2026 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450915; cv=none; b=t4K651lnenDf1aPLG69ROER5XeH4QGOAaeVgDVCiRyElGbupbJ8SFMnrmYgr5Ogs9WIZzDgCzk58qupa4p198a773mqqb9NVEeW42ZwFp1MHrj6tgvn2DsKYB7LDYUdZjSw1w58oryLPxRhhd5VrLmN0NIjAiZhpfv5bLJ8EKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450915; c=relaxed/simple;
	bh=//BfIGMkfiK7mCRKESyGBvGJW7LKLJ1qDoF+qWE8xQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/g2xWn83eQQ53NMlKkTlofXdBk3x7HPfZoSl5tXdWrF9EQOi0i2OUeEwfKfgtg5D0QI0mA4JWhLFMZYgZnPC3L2C+FSfDt38xMhUndH0/jvhqUINCibtCye3RH00LLi8W5lMatTaBS7PNAolUYyMiw4N3ic6QN74XPN4r7+P0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsHLvdjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsHLvdjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B8E1F00898;
	Thu,  8 Oct 2026 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791450908;
	bh=N0iVQ+icpXXzIWEz3mV5Uf7KkvSTdwHOk+gN5yGHz3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VsHLvdjS+390MDSEAalnQqsiwY25PV9OUQmvvuJ+Lfj66g62QZTeidCVDdQw75wU/
	 oKXDd5/Q5mex5jfPtVj7K1FRf7FxupmQSzzPNbaATyZKG4k798DaMD8EtgE6QRTN1T
	 ZmxURI1lyE6urspVilk5eR/HiW62t4fTZXaxr+cMxlDfyqpBRWYYaiG7RnfwtexKOZ
	 H/Kco3Xqz71EqFrfevHmqLh5ak12nNrDeS9GZzFx/WN8FVNGC5S1T7t2bBSioq1mDJ
	 xNAIcvV4Ez9/WvxCaUaEU5PuCiP8rl+VVJpCz3nSBO+aElABCAWZbSlP5TMigwWSUo
	 BwhAiuRIiEO+Q==
Date: Thu, 8 Oct 2026 09:15:06 +0000
From: Yixun Lan <dlan@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Icenowy Zheng <uwu@icenowy.me>,
	Iker Pedrosa <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
Message-ID: <20261008091506-GKC2005@kernel.org>
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
 <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org>
 <20261008-df80c21d73b287d09b6baa78@squawk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008-df80c21d73b287d09b6baa78@squawk>

Hi Conor,

On 08:27 Thu 08 Oct     , Conor Dooley wrote:
> On Thu, Oct 08, 2026 at 03:44:29AM +0000, Yixun Lan wrote:
> > Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
> > Domain Controller is SoC internal module which is part of APMU (Advanced
> > Power Management Unit), it is responsible for managing power across multi
> > power domains, which includes power on/off, isolation, power-on sequence.
> 
> You should prob mention that this APMU is already documented elsewhere.
Right, the documentation already exists in
   Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml

I can add a short note in next version

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Thanks

-- 
Yixun Lan (dlan)
