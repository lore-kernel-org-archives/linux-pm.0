Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC012442FA3
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014807; cv=none; b=NXvS+Un3bVs7zdoaFqitJt8MIi/CVAm9rtXWgiwA6GK1foxqpzrfb7D6xTg1t/GpvKVZMu3SlGyRRIi0ij4LXUiCJJFAwuNqCbmaNqjxrxSX/aUg11EpbJgJmW8EBw2nTmsA7XI2a1gaoDDh/3oaiNyTxSZSFcwbLEqhTucxvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014807; c=relaxed/simple;
	bh=VfQn1+i/SGityT/ulOmD2nheVy60uiFAC7g4sB2KAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRBkusr4FXom7AdOvzkYFKHZo2yUdD3DIwVREETNr0XV01URPEBYGTZy+2oOlR7rL+0iyX9J7qrcgkaB9nBCYStmkGQKafFe1HxEWmW6+RwD3YumTwkFfqdreYXpJ3xLtOCOLM/S/YKjSAXkhvzWKgWVXu/UohOKzTSkMxosgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aczsL+Kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aczsL+Kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A3C1F000E9;
	Thu,  6 Aug 2026 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786014798;
	bh=W05TLGpsC8Ce7/O43srEVZWkxOE/9Y9JAInK2o1zpUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aczsL+Kp4bwjRNB2s9/tzSHAj+nB9uCgyLwC6y03HxwBHxpp+V9mcTGjJgk1KJP0N
	 DZlZNb2JoJZBH3UbAPy0wUR9scu1DvrC18RZW/+VWQSelomZzqDlVdsXC5Vo+A4urZ
	 vW7SNTwMlonAWQU0UtRtbXU4pD433OKvTLh5wUwDjsRZvLGpBBrnMs4KrXu3kpDY9T
	 fFoyDAVPtIpQP/VsWGEsmuYtkQZR6lq3DVT0GNV0AbZPdgAmyVEGFnj1AkIgiVrrVU
	 DayqvP24nDFDF1RXKfPWzrXnncnXqZ/h53EW8hgzCZGq+/WNouImiQ30bIhQ8JoP9z
	 W7BOzyLWA6Uww==
Date: Thu, 6 Aug 2026 12:13:13 +0100
From: Will Deacon <will@kernel.org>
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, james.morse@arm.com,
	linux-pm@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH] PM: hibernate: flush icache for restored pages from task
 context
Message-ID: <anRsSeUlxP0-I3tG@willie-the-truck>
References: <20260803055412.63981-1-xiongxin@kylinos.cn>
 <anH1mvwdiQxjwfw1@willie-the-truck>
 <65192d9f-a60c-42cf-9ff5-59f52377c9d4@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65192d9f-a60c-42cf-9ff5-59f52377c9d4@kylinos.cn>

On Thu, Aug 06, 2026 at 08:56:18AM +0800, Xiong Xin wrote:
> > On Mon, Aug 03, 2026 at 01:54:12PM +0800, Xiong Xin wrote:
> > > When resuming from hibernation with `hibernate=nocompress`, the kernel
> > > loads the image via load_image(), which submits read bios asynchronously
> > > and waits on them with hib_wait_io(). The bio completion callback
> > > hib_end_io() runs from the block IRQ/softirq path.
> > > 
> > > Commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
> > > restored in-place") added a flush_icache_range() call inside hib_end_io()
> > > (under clean_pages_on_read). On architectures such as ARM64,
> > > flush_icache_range() ends with kick_all_cpus_sync() -> smp_call_function()
> > > (wait=1), which contains:
> > > 
> > >      WARN_ON_ONCE(!in_task());
> > > 
> > > Because hib_end_io() executes in hardirq/softirq context, in_task() is
> > > always false there, and the WARN fires which happens while the resume
> > > task is asleep in hib_wait_io() and the CPU is idle, the warning log as
> > > follows:
> > 
> > Hmm, do we have any secondary CPUs online at this point? I wonder if
> > either smp_call_function() could push the WARN() down into the branch
> > where it knows it is going to call remotely or whether we could elide
> > the call to kick_all_cpus_sync() altogether in that case?
> 
> Thanks for the review.
> 
> Q1: Do we have any secondary CPUs online at this point?
> 
> Yes, the secondary CPUs are online, but they are all (almost) in the idle
> loop state. 

Ah, nevermind then. I don't think we can elide the cross-call in the
low-level code in that case. Sorry for the bad suggestion!

Will
