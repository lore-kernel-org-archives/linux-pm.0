Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90549AA41;
	Mon, 21 Sep 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994698; cv=none; b=sJNG5VT85kBM3v58/HewhDnO8IDBp9vwxtwt7M9pknzcNjQE3207UxktQhOiIhz/nBCYYHrygyU9Rj/g1P3rTod7gjcwNieXCgbkfqdt+arrDPfcj6iD9kCOaYF56yPGlsTRY+yGjB9/onwCklFa/uEn59ULrXtwTcxqlQS+mfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994698; c=relaxed/simple;
	bh=vQtYCPxHu9lloB/pKbqtzQ6Xj4z+2MciCeAGPstkYJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WitRgxKfzjhj+VWbRQIyHd6rc9YAZ6lUmoYDBUyIAdPMTWD0FFvik9rTeikPldbV6LuhZlPwgofpcbH5VjQItx8aSxGIBYuRvxgAn5GL5ulq3pXmjUxHex9owbGXviv/rBlc9eSJHA3MCcpXpJvOqPaTyhEACKm4QhukTS9hLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BStBRHyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BStBRHyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0091F000FF;
	Mon, 21 Sep 2026 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994694;
	bh=cfyGQvaB9SBuErp0Qx497sUvEDScukDCHbeDeVfMuYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BStBRHypPZ/YYbx0kPtXDsf5PXmSvGrqW0923VmAOXlmiG8qxsic8ZQkU+GkEnLgG
	 IhBIB2Ub5M4414tpHlEWs3N4yMtLHL+jqGFszxYWtmFhVsKc0T073zLj8ZCSNLohhX
	 76PUUndqlQIc0xfG5c13gye/097PvosVt6rByogZdJkreBN1iT8cKK90K1aVGhnFp3
	 nqcQhpXVJb1F6XuvJIda71CCjNiNCiiG5XUoJ81nNglsjSzN5662uGltTVEdBdZy7c
	 RqFGjL2axKNCh7GnTJhZnE9o7DR9aaZceK86SeXlE4c7pkHPCAB/Y+Lf1oCWThP5Wg
	 TTa2iLbTR9hUg==
Date: Mon, 21 Sep 2026 12:44:52 +0000
From: Yixun Lan <dlan@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Message-ID: <20260921124452-GKK297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
 <20260921033540-GKG297024@kernel.org>
 <e96ddd73ca83f0d8b6f08ff63a14b5f0d1bcee57.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e96ddd73ca83f0d8b6f08ff63a14b5f0d1bcee57.camel@icenowy.me>

Hi Icenowy,

On 11:41 Mon 21 Sep     , Icenowy Zheng wrote:
> 在 2026-09-21一的 03:35 +0000，Yixun Lan写道：
..
> > > (BTW I built it as a module to prevent whole kernel being rebuilt)
> > > 
> > that's fine
> 
> In this case, do you consider to make the Kconfig option in your patch
> tristate instead of bool?
> 
Sure, will do
 

-- 
Yixun Lan (dlan)
