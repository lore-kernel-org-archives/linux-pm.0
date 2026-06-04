Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5937BE74;
	Thu,  4 Jun 2026 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560738; cv=none; b=Dq/f6iaXoVSoS1QLeoUo4Y8VbFZH6ysmSa1sz6z0OnfCWPBxG8tHGIgwfywiD3waJpYQ+e5hx280E4QXM9A1iO15OA9A+1SWvZtPpsT9o3qJP8pcaSiqiZjGw5Pu5S4zQeDgh/CznQxpa9rDos2rzfaTaCANdCH9C/ikriMMI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560738; c=relaxed/simple;
	bh=IfhSRvg9gHIBCIdcOECjVdlxFvOYhDT+lpZnsT1YbC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqB4WHVooACsLmPWGYD4Pq07z4jLuPP97DipkUEk0z/oHdbicfxlWTVRtxDn8T0OREUE3qOt6Pyll0UWgBScueJR/2KstCB1TkRXmSNVc+PwOKCcg63hapg5FnF0eYvUfuSdZpoKk05W028FTznBrweJwJq8PBJoQroyDcglOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZeoqmCaD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZeoqmCaD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dCvgJapqvoZXROAkXz9CfDS9knNia5wvrN+Zhl+enP8=; b=ZeoqmCaD8XzKJkPxdaInK9hvYt
	Rjlm+4m4IEhWbvxOOLcTl2Q4a7Sc2iCxArhYegu4BcI2d/oFCzEVZgH74qu3OMFIyU8yRr2Eyqt8D
	r81vXLtJgaV+aXX3mwrJQG0aY0ouuxltA0ktnbA2JJFX5THrqqVQ9XVELULR+nCPvK7Ny8KEaf2+X
	3/kwu5dFdx/LFubv3vsPtcKK6fv28KuABnhXKF7fKjj8vAt8SWGA/8psFOyvXG/T/hkfLA4P3B+QM
	DdQXj66Zw3+cfpbnjxv1+BnBT41MfDR5Bjgr7bwZAirLan1sdlokPWX+mmVFP0UzR1tus3pWkwiW7
	e37DX+qQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV3BQ-004NUY-1U;
	Thu, 04 Jun 2026 08:12:08 +0000
Date: Thu, 4 Jun 2026 01:12:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-pm@vger.kernel.org, sumitg@nvidia.com, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, viresh.kumar@linaro.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
Message-ID: <aiCI__XLprPPZ14D@gmail.com>
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
 <aiAGtKDKTVy2e4ds@gmail.com>
 <f047de36-5d0a-489e-84ee-4bab0a1fd8d4@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f047de36-5d0a-489e-84ee-4bab0a1fd8d4@arm.com>
X-Debian-User: leitao

On Wed, Jun 03, 2026 at 11:46:51AM -0500, Jeremy Linton wrote:
> Hi,
> 
> Thanks for looking at this.
> 
> On 6/3/26 5:54 AM, Breno Leitao wrote:
> > On Tue, Jun 02, 2026 at 04:20:52PM -0500, Jeremy Linton wrote:
> > > CPPC uses a pair of registers cycling at different frequencies to
> > > determine an accumulated performance level. For userspace reporting we
> > > want to convert this to an instantaneous CPU frequency, but over short
> > > time periods small errors caused by CPPC counter reads can cause
> > > fairly significant reported frequency variations even when the core
> > > CPU clock isn't changing.
> > > 
> > > Reduce this by keeping a start sample fixed and retrying the end
> > > sample until the counter deltas are large enough to reduce short
> > > window error, or until adjacent delivered performance estimates are
> > > within the CPU's observed CPPC read noise floor.
> > > 
> > > To begin, resample the initial pair a small fixed number of times
> > > looking for matching delivered performance deltas.  This reduces the
> > > chance that a disturbed start sample anchors the rest of the
> > > calculation.
> > > 
> > > Then look for an end sample while updating the noise floor from the
> > > best error seen between samples.  The floor remains zero on systems
> > > with stable feedback reads, but lets noisy systems stop early once
> > > another retry is unlikely to improve the result.  The retry loop is
> > > capped at 200 iterations, giving an ~20 usec explicit delay budget
> > > derived from ndelay(100).
> > > 
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > ---
> > >   drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
> > >   1 file changed, 61 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > index 7e7f9dfb7a24..362c08def420 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -50,7 +50,7 @@ struct cppc_freq_invariance {
> > >   static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
> > >   static struct kthread_worker *kworker_fie;
> > > -static int cppc_perf_from_fbctrs(u64 reference_perf,
> > > +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
> > >   				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> > >   				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
> > > @@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
> > >   	return (u32)t1 - (u32)t0;
> > >   }
> > > -static int cppc_perf_from_fbctrs(u64 reference_perf,
> > > +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
> > >   				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> > >   				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
> > >   {
> > > @@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
> > >   	return (reference_perf * delta_delivered) / delta_reference;
> > >   }
> > > -static int cppc_get_perf_ctrs_sample(int cpu,
> > > +/* CPPC read noise floor for early retry exit. */
> > > +static DEFINE_PER_CPU(u64, err_floor);
> > > +
> > > +#define CPPC_SAMPLE_MAX_RETRIES	200
> > 
> > Could the remaining tuning literals get the same treatment?
> > Specifically:
> > 
> > - the 10 initial-resample iteration count
> > - the 2000 multiplier in ref * 2000
> > - the 100 ns in ndelay(100)
> 
> Sure. A few of these were personal judgment from the platforms I tried it
> on. I had some instrumentation at the bottom which was printing loop counts
> and error values and largely I picked those values based on how they were
> behaving, or back of the evelope estimates. For example, that 200 is afaik
> overkill, its usually settles down around 20 or less, which makes this
> faster than the old method on at least one platform I tried it on. And they
> are all intended to be "upper bound" exit the loop because something isn't
> working right values.
> 
> 
> I'm interested in whether this patch stabilizes the frequency reporting in
> some of the cases I've heard people talking about.

Ack. I will try to get this tested tomorrow, and report it back in here.

Thanks
--breno
