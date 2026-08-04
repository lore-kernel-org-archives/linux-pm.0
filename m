Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC38357D0C
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853364; cv=none; b=U3tlTFK2c22tC4vp087Z635HpiqLwjp2h/sXO4zIB77Q7/vDxcsTZN5QeuV8M4NQXBi4W8DZ1XTxpovkcNJl8MVx8CBPvnFCYIy1nkScCHOe8H9bQKLgJJ0mcjsBgM0nBt18Q5aJN39M4EYgIMugceLrt2lFOS5z/hw79gQ2IEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853364; c=relaxed/simple;
	bh=HC6ULGVAcOh0PgF0NQUGIWhQFp9QrLULbRSiMVcSDv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8LjbNffG1x8xMtyePIqwA8zNN5G0gvY01dWdUbF2Qhs2fLlWc1+rXCHscF2WLp5CrftypdKJEv9ehV+brw/rYViyx+otmRqlMwBUl0S4RTilXqaJucsPMAMC9rXsVctOAcnYYcz5WGHjR8ND/4y/9Gd+r9zxrijQXZWbjj8i2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjJsnet4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjJsnet4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB5C1F000E9;
	Tue,  4 Aug 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853342;
	bh=8wK+zLPPHlxxYrRF9lEI5gLDTuFI3C0MtAejxRHV2tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hjJsnet4PNFp7zF+7NYuuB+zX8lsaj7KAPIvn2V34lY4CpRNZxEkEsVlqTy9dvNJd
	 OS0Hsyv6nyZm/APOmHpHIYeqj7NO585OVyyReGnFl1aXNIQsbIeEzUTZV8NEURmlKh
	 PGUb+GZOdEiCazFIYb1wG0Kp9LOq5/Jyke7zZEgJb0cpJpGxfqjE+3mGfphNBNKta7
	 DymEGC5WzF1GHTe+3C6i8+ZbrMGRGW3lirqSUkqAVXwqBv/tyNGYBBLh4bmXocsXXE
	 4QVcqjY2I0BOPC7COH1/Syi/ra73idS9JajFRSLTP3cBAvTBL3VZP1+FD8hNLifwAk
	 iQweqq+HSHCVQ==
Date: Tue, 4 Aug 2026 15:22:18 +0100
From: Will Deacon <will@kernel.org>
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, james.morse@arm.com,
	linux-pm@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH] PM: hibernate: flush icache for restored pages from task
 context
Message-ID: <anH1mvwdiQxjwfw1@willie-the-truck>
References: <20260803055412.63981-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803055412.63981-1-xiongxin@kylinos.cn>

On Mon, Aug 03, 2026 at 01:54:12PM +0800, Xiong Xin wrote:
> When resuming from hibernation with `hibernate=nocompress`, the kernel
> loads the image via load_image(), which submits read bios asynchronously
> and waits on them with hib_wait_io(). The bio completion callback
> hib_end_io() runs from the block IRQ/softirq path.
> 
> Commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
> restored in-place") added a flush_icache_range() call inside hib_end_io()
> (under clean_pages_on_read). On architectures such as ARM64,
> flush_icache_range() ends with kick_all_cpus_sync() -> smp_call_function()
> (wait=1), which contains:
> 
>     WARN_ON_ONCE(!in_task());
> 
> Because hib_end_io() executes in hardirq/softirq context, in_task() is
> always false there, and the WARN fires which happens while the resume
> task is asleep in hib_wait_io() and the CPU is idle, the warning log as
> follows:

Hmm, do we have any secondary CPUs online at this point? I wonder if
either smp_call_function() could push the WARN() down into the branch
where it knows it is going to call remotely or whether we could elide
the call to kick_all_cpus_sync() altogether in that case?

Will
