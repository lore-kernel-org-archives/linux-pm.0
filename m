Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A5176FB1;
	Tue,  5 May 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985576; cv=none; b=ZtoKRer/gMHwzOWnGP4zDhmnTjrEIf+ZyAgz4TbgQpmbfP2+FOKz1vL70u4jEKvB1ooCOrDzAGI0NQfqHCskUJdWvdICCmYPsfKdZfzXVpeNcU+gZLf2Ffn+pV46S1L6QAiplA5buNyS1Di3NcQc4NhdseQCTIFOIohnii8zGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985576; c=relaxed/simple;
	bh=VHZTb6n+KvqvYEtebqkQe4HIy4j42NHHqjdkTR0J2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCEWQUb4TIX0ryX12KtfO4O41WPReqtmjBbnpAF+2z1EZ303eVTWzYKrg8IXxu8ps1YNNQW0edd26WXCn95CJE6dxmemX70aRUI2Jy96mww9qZB3uhGVstPd4GRz2EQJsnpnJfLqKLgabh2eHY1Fr6bp/p5rn2KjBS9eXWg6FBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YB6QYryU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YB6QYryU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VHZTb6n+KvqvYEtebqkQe4HIy4j42NHHqjdkTR0J2Hw=; b=YB6QYryUqpX2gSTgIChWdZ9EHo
	oFk0vGvoxBh4K9fqxQibZe09Jg6ig8cOEJ8YXAG/IEuNN9aOmv7H6puIjHOKef3TVW1rbw/TlptZ3
	YBrDC/oGfG5p4i8xACHFqzlAKMN3Wj5JYOuROZVB6vZ95Nvw3mxvy9dC4vxnvwcHlBMM17FHcIjY1
	59UtF2t9VkINctNQkSn5+/x079agbUWZ6itgRyhhu8Gsjoe/SvpncqMqEhL/mEXENweTCTSg8qkTF
	yNnxoGgjsellET6FuLk7DwuHiLodMU33PQsXWEP1zCYHvZhai2tiH1W+BHB6QVu+/vWdR3bmw+3aB
	Io4ybtvw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKFGF-002ouv-03;
	Tue, 05 May 2026 12:52:27 +0000
Date: Tue, 5 May 2026 05:52:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dcostantino@meta.com, pjaroszynski@nvidia.com, Al.Grant@arm.com, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf
 samples
Message-ID: <afnnPRZBdWlriZON@gmail.com>
References: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
 <7e55dd1e-2841-4918-8e3d-82203a70451a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e55dd1e-2841-4918-8e3d-82203a70451a@arm.com>
X-Debian-User: leitao

Hello Jeremy,

On Fri, May 01, 2026 at 12:41:45PM -0500, Jeremy Linton wrote:
> A little jitter over, is probably expected. If that is what is happening
> then clamping to highest_perf makes sense instead.

Based on my analysis of the code, interrupts appear to remain enabled
during the delay, which could introduce significant jitter if an IRQ
fires during that window.

I'd be interested in testing this under an IRQ storm to quantify the
actual impact on the measurements.

> But then, this is really
> a sampling problem so does it go away if you double the udelay slightly.
> Maybe the udelay value should be proportional to the reference_perf value?

That's a reasonable approach. What would you suggest for the
implementation?

I considered making it a kernel or module parameter, but I'm not certain
that's the best solution, since the "user" might not know what to
set/use.

Thanks for your review,
--breno
