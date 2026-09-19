Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9B348C7B;
	Sat, 19 Sep 2026 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859617; cv=none; b=k1u4LfNHM8uz9SUU6nY12iqab1o5qS53yEWfkiVXdimnDVND5lHsntLS6F1S9dOD+o+wIjq6OJqWuRM1OJGLA5YAuzOrV5auypH66fimR9HZwnOHZHx6h+BFdI0nTXxtlOUlMB/BaTTBM8ZyvGstN0hFSGOmzfT597wQH0rjrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859617; c=relaxed/simple;
	bh=sK2yacM6Q3NGD6pgtUu/ouaNBLyacVN5mFpthK3M0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo+2g1bZBJEDqv0mCtw2MokV1q1X6LQnhTiYiw0KOI1sJU8Fd6zmkDRAzj6RsIlv/n96zRKg2ITYKc2ZhjoK/V+0T/rIU2G906xXIB98mlQLzKs3/2yffeDDTT4oTEaw0kMS5jJ8j/4/1988y0ITvxStn5sAC0fL+Doies0m834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agsW2GL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agsW2GL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E960B1F000FF;
	Sat, 19 Sep 2026 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789859615;
	bh=2Sef/0wxyMwTpjYCRnlB9CgtNUDrbK2hMY8qeX5WdGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=agsW2GL4vTTRqpy7+o1jwke4n1/xbLd5GX9CLNxEpk/J+J6CA5r6gJkG1jKju+NPm
	 wMOwUqTa8PrIQ5wkmYvByON9AH34njGzQIckoWUQPP6lfYsVH1JubRrXOdrW/fDw1f
	 J2KFvOBBVO/gh08nduHOQAzcOQ9ftbLQRO7OVHCnjhE6vE1wWWV93XFIHgu/NnTaQy
	 bwWdMoTMk2f5hcq3K2BvqZN+6n8vMasxFKOUFPoOB/yX3n73ayxbMRHE+cQ9UhK+Rg
	 2as9+UFbBD1l4QEoqvsNfhlrtSmWN6j5jQbj2zLUJ0MnCtSxGzVIQUE/LcE7liMVkP
	 JWzwOrSYgSyVg==
Date: Sat, 19 Sep 2026 23:13:33 +0000
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
Message-ID: <20260919231333-GKB322102@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
 <20260918230107-GKC297024@kernel.org>
 <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
 <20260919095936-GKA322102@kernel.org>
 <8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>

Hi Icenowy,

On 21:56 Sat 19 Sep     , Icenowy Zheng wrote:
> 在 2026-09-19六的 09:59 +0000，Yixun Lan写道：
> > Hi Icenowy,
> > 
> > On 14:57 Sat 19 Sep     , Icenowy Zheng wrote:
> > > 在 2026-09-18五的 23:01 +0000，Yixun Lan写道：
> > > > Hi Icenowy, 
> > > > 
> > > > On 17:00 Fri 18 Sep     , Icenowy Zheng wrote:
> > > > > 在 2026-09-18五的 02:40 +0000，Yixun Lan写道：
> > > > > >   SpacemiT's PMU (Power Management Unit) consist of several
> > > > > > power
> > > > > > domains
> > > > > > which can be managed independently, depending on different
> > > > > > application
> > > > > > scenario, each domain can be powered on/off for saving power.
> > > > > > 
> > > > > >   The driver is implemented based on Linux Generic PM Domain
> > > > > > framework.
> > > > > > From a hardware perspective, either of two distinct power-on
> > > > > > sequences
> > > > > > are supported, in software mode (SW mode), the driver is
> > > > > > responsible
> > > > > > for
> > > > > > controlling the states of bits such as sleep1, sleep2,
> > > > > > isolation
> > > > > > and
> > > > > > pwr_state, while in hardware mode (HW mode), the PMU hardware
> > > > > > will
> > > > > > complete
> > > > > > the sequence automatically without requiring software
> > > > > > intervention.
> > > > > 
> > > > > I think there also exists solutions for K3 that uses RPMI power
> > > > > domains, and let their ESOS firmware to access the hardware.
> > > > > 
> > > > Yes, I'm aware of that
> > > > 
> > > > > What's the relationship of this implementation with the ESOS
> > > > > implementation? Should the ESOS part be disabled to use this
> > > > > implementation?
> > > > > 
> > > > I should say, it's a mutually exclusive solution, so yes, the
> > > > ESOS
> > > > part
> > > > should be disabled in order to use this version
> > > > 
> > > > The motivation of this patch is trying to support drm/display
> > > > driver's
> > > > PM requirement, while avoid going with vendor's complicated RPMI
> > > > solution
> > > > which isn't mainline ready
> > > 
> > > Is this a long-term solution, or a temporary one?
> > > 
> > For upstream, I'd say we probably will stick to this solution for
> > long time, won't say it 'forever', see comment below..
> > 
> > > If it's a temporary conflicting one, I don't think it's worth
> > > picking
> > > at all.
> > > 
> > Well, checked current Linux kernel status, there is no RPMI PM
> > solution 
> > implemented although there is documentation in riscv-rpmi spec[1]
> 
> I have seen pending patch for it with multiple revisions [1], the dt
> binding is even already ACKed by Conor, so I think it's not a big
> problem here.
> 
That's exactly what I said - it's not mature, not saying it's pending
patch for review, but for whole solution that involve Linux driver,
opensbi and underlying fimware (ESOS) - which not upstream-ed..

To make it clear, I'm not going to pursue the RPMI solution, but if
someone insist and willing to spend the effort, please feel free to push

-- 
Yixun Lan (dlan)
