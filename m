Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CE479886;
	Mon,  7 Sep 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778528; cv=none; b=jRh6uZLFu9IB+f0+ezqglKW5Hi2ShMNCAGsQd2tXI1KlgxuQ4pXt5X3R+cvCFrs0KBp8OsJiGox5HidM8y0UC1xXZakLBzqDoRk6Vq3VZayBu2VGMAiopsxOUd8AmvUdqDP9QPhDFX9Pux1tg637eh8PctydjS7J+XXShvOSNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778528; c=relaxed/simple;
	bh=Hb5yzSlRTI8HDlYvKMUtaP489fAvwXAQ+ZlCpNxyp/s=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=cNxKUjbsN8sIVAXWFavDGtdjP3rprjq8cd9NOEwXNfet7E/59CY6oaaCjM1Yz/yTZjN7Qi4dne2ull19up2qZmI7pWGqXoEv1j2i4Bo2JZDHLZ/c+8dGlcec3coDIlOzdJbXkDoVXzonrGz1mLYAvzo8WaGH3BlgBYzH+RZcphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hdkVx4jj5z8Xrrb;
	Mon, 07 Sep 2026 18:55:21 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 687AtETb003212;
	Mon, 7 Sep 2026 18:55:14 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 7 Sep 2026 18:55:17 +0800 (CST)
X-Zmail-TransId: 2afc6a9e9815098-e7c3b
X-Mailer: Zmail v1.0
Message-ID: <20260907185517424rOcCTgNPmgf1i0mLqlxWN@zte.com.cn>
In-Reply-To: <f0b59964-081c-4547-8251-3e3134c4942f@oss.qualcomm.com>
References: 2026090215474182681fN7LLOSpqIc3s3OqJaW@zte.com.cn,f0b59964-081c-4547-8251-3e3134c4942f@oss.qualcomm.com
Date: Mon, 7 Sep 2026 18:55:17 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <zhongqiu.han@oss.qualcomm.com>
Cc: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luo.haiyang@zte.com.cn>,
        <zhang.run@zte.com.cn>, <zhongqiu.han@oss.qualcomm.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gY3B1ZnJlcTogY29uc2VydmF0aXZlOiBJZ25vcmUgaWRsZSBwZXJpb2RzIHdoZW4gYSBwb2xpY3kgQ1BVIGlzIGJ1c3k=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 687AtETb003212
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 07 Sep 2026 18:55:21 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A9E9819.001/4hdkVx4jj5z8Xrrb

Zhongqiu wrote:
> Hi Shengming,
> Thanks for the patch.

Hi Zhongqiu,
Thanks for the review!

> On 9/2/2026 3:47 PM, hu.shengming@zte.com.cn wrote:
> > From: Shengming Hu <hu.shengming@zte.com.cn>
> > 
> > For a shared cpufreq policy, dbs_update() derives the load from the
> > highest utilization among its CPUs, but it also records deferred idle
> > periods from any CPU whose idle time exceeds two sampling intervals.
> > 
> > This lets a single update report both a high load (from a busy CPU)
> > and several deferred idle periods (from an idle sibling). Since
> > conservative applies the deferred down steps before the up step
> > triggered by the high load, the down steps can outweigh the single
> > up step.
> > 
> > The issue reproduces on a policy shared by CPUs 2 and 3: a CPU-bound
> > SCHED_EXT task keeps CPU 2 at 100% utilization while CPU 3 stays
> > idle. On this system SCHED_EXT generates update-util callbacks less
> > frequently than CFS, so DBS updates are sparse, tracing shows:
> > 
> >   load=100 idle_periods=7 interval=59 ms
> >   load=100 idle_periods=4 interval=39 ms
> >   load=100 idle_periods=2 interval=19 ms
> >   load=100 idle_periods=7 interval=59 ms
> > 
> > With the default 5% step and a 2.6 GHz ceiling, conservative first
> > removes seven 130 MHz steps and then adds only one. Repeating this
> > sequence keeps the policy near 530 MHz despite CPU 2 being fully busy.
> > 
> > Only retain deferred idle periods when every CPU in the policy meets
> > the long-idle condition. This keeps the existing behavior for
> > single-CPU and fully idle shared policies, while preventing an idle
> > sibling from downscaling a policy that contains a busy CPU.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
> > Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> > Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
> > Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> > ---
> >   drivers/cpufreq/cpufreq_governor.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index 710d93ec89b5..64eb6b5f08a4 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
> >       unsigned int ignore_nice = dbs_data->ignore_nice_load;
> >       unsigned int max_load = 0, idle_periods = UINT_MAX;
> >       unsigned int sampling_rate, io_busy, j;
> > +    bool all_cpus_idle = true;
> >       u64 cur_nice;
> > 
> >       /*
> > @@ -233,13 +234,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
> > 
> >               if (periods < idle_periods)
> >                   idle_periods = periods;
> > +        } else {
> > +            all_cpus_idle = false;
> 
> The problem is real, but I don't think this condition is the right one.
> idle_time > 2 * sampling_rate tells us how many sampling periods were
> deferred for that CPU, so its negation means "this CPU was sampled on
> time", not "this CPU is busy".
> 
> Since all_cpus_idle is per-policy, one such CPU is enough to discard the
> deferred periods for the whole policy, and in a shared policy it is
> possible. That effectively disables the optimization from 00bfe05889e9
> for shared policies, which is the opposite of what we want for power.

Agreed that not meeting the long-idle condition does not necessarily
mean that the CPU was busy. The condition is based on accumulated idle
time, so it is not a reliable indication of whether that CPU should
prevent deferred downscaling.

> What matters is whether the CPU was busy over the sample, that is,
> whether the skipped sampling periods would have led to a frequency
> reduction at all. It seems more appropriate to key that off the load
> measured over the sample (kept separate from the possibly inherited one)
> against up_threshold, so an idle-but-punctually-sampled sibling does not

Thanks for the suggestion. I agree that the load actually measured over
the current sample should be kept separate from the load that may inherit
prev_load. However, I don't think up_threshold is the appropriate
boundary for deciding whether deferred down steps should be applied.

For example, suppose CPU A has been idle for several sampling periods
while CPU B has a sustained load of 75%, with up_threshold at 80 and
down_threshold at 20. The policy is then in conservative's hold region,
so the load itself would trigger neither an increase nor a decrease.
If deferred downscaling is gated only by up_threshold, CPU B would
not block it, so CPU A's deferred idle periods could still reduce
the policy frequency.

I think deferred down steps should instead be applied only when the
maximum load actually measured across the policy is below
down_threshold. To keep this independent of the load returned by
dbs_update(), which may inherit prev_load, we could record the maximum
measured load separately in struct policy_dbs_info, for example as
max_sample_load.

The conservative governor could then gate the deferred reductions with
something like:

    if (policy_dbs->max_sample_load < cs_tuners->down_threshold &&
        policy_dbs->idle_periods < UINT_MAX) {
        ...
    }

This preserves deferred downscaling when the measured policy load is
below down_threshold, while avoiding deferred reductions when any CPU
is in either the hold or upscale region.

> May I know could you comment and try this patch on your scenario?  Once 
> everyone agrees I can send this formally:

I'll rework the patch along these lines, keeping the measured load
separate from the inherited load and using down_threshold for the
deferred-downscale condition. 

I'll send a v2, with a Suggested-by tag for your suggestion.

--
With Best Regards,
Shengming
