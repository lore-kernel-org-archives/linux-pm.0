Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755336403A;
	Fri,  8 May 2026 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228314; cv=none; b=AqaBLFrGybrnJDj+eSyrJfDL018Y2OrzD/7Bcg8qJt7ODJkATx9Ym/ZTh8TgYBZdREoU79j0Cn4yqdOtuleGRfPRNAq+uhFsKbg49973otx3FHvsxGMI9zm6SSfqnF+jW/RE8AYfmQJdctA5S2YvknLHwmEVQI1PIhtckwsg55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228314; c=relaxed/simple;
	bh=6g5MbNRP3t1zQlq/l7HfE82P0KyWtX/3MC0atpjM8nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba22ULGFZ4s+EaO/pSqdGCAqo1+q2YcTPz8jMj8gdHl4JvCInZL5jApzmcdLQOj047XbZKl+b8FkW+KBL33CGlNobakIQqq2T6pqVMnf20VWm/Igv+q1GrYmb7tiynH1oZFHrjkqxrtPKofmaxZo18Y8spSkoG6e/zDTLAGDoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jEm56S9y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jEm56S9y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nGf/WqSQ3/Zjx2h0MCS70VhsrXikjW8UIPjwUNHeoFw=; b=jEm56S9yeQiHcVoKJlqQlGqbNH
	QMg+C9fTPmKTGc60w68AuWcGGnIvHaXD+S6rbs0KJNAPgiYeQTg8D8YFFPeauj42qXOplA5IPNqMr
	giFeg8MVqLTqb3C6R9Njwa1ZWXu2VDcT3KOESpjaCVfc3X46MuNLX0b7xwH7TNmQrD4qDaMMzBPTw
	QEc09p0xnnlNraynrDcr3vwtaTTl/lrniRufb++QDuDkKKVPxotef/p5XihQwI5swP5PyKA910148
	0t83H0vwyO64B3KSt9HHAW7DNUSLgWfU4vNSqQCBUi7OVjUL4koNzTpnb9uX3lRx6mgFD6NmR1dSY
	Io1Fkrxw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLGPL-0050jK-1G;
	Fri, 08 May 2026 08:18:03 +0000
Date: Fri, 8 May 2026 01:17:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dcostantino@meta.com, pjaroszynski@nvidia.com, Al.Grant@arm.com, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf
 samples
Message-ID: <af2cEiouQbdpoavG@gmail.com>
References: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
 <26deca86-44e3-4fd5-950e-59f913d9ee37@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26deca86-44e3-4fd5-950e-59f913d9ee37@hisilicon.com>
X-Debian-User: leitao

Hello Jie,

On Fri, May 08, 2026 at 11:23:18AM +0800, Jie Zhan wrote:
> On 5/2/2026 12:32 AM, Breno Leitao wrote:
> > cppc_cpufreq_get_rate() derives delivered_perf as:
> > 
> >     delivered_perf = reference_perf * delta_delivered / delta_reference
> > 
> > over a short udelay()-bounded window between two cppc_get_perf_ctrs()
> > calls. Per-read latency jitter on the underlying CPC register access
> > can skew the ratio, occasionally producing delivered_perf >
> > highest_perf. cppc_perf_to_khz() then linearly extrapolates above
> > (nominal_perf, nominal_freq), so the value reported via
> > /sys/.../cpufreq/cpuinfo_cur_freq exceeds cpuinfo_max_freq.
> > 
> > Observed on an arm64 host (governor=performance,
> > cpuinfo_max_freq=3339 MHz): 15 back-to-back reads returned values
> > between 2997 and 4230 MHz.
> Hi Breno,
> 
> Frequency sampling discrepancy through 'cpuinfo_cur_freq' in the
> cppc_cpufreq driver has been an issue discussed for a very long time.

Thanks for the heads-up.

> If the CPPC feedback counters are FFH on your platform, can you have a look
> at [1] and see if that helps?

Have you forgot to get the [1] link here?

Thanks for looking at this,
--breno
