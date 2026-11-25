Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595172;
	b=lHaf/+tzT6Sk6RaMFUjMa0Q6kEbRH83OaBxsESjKvJ3nMVQDS2y/0NgXTr1L0p5GNHgA
	 JUGzojcAkhqXGjpiGvmw76TfnLJrG8muTb5yshjeoV/10nw/nUQbJ0PNYE3tEDyd5kjoh
	 TIrGuZObbsnTb8c2fo7rgph+nQ02if0hwxbLaNmuP8oQTx4ImKhqBaRplkp1c/L9KDS+Q
	 vMx5gp7d7pkZjjh3031FJpxcsfiD+X3ssFTDVsOD9y+GwMcTkOcxFxHcRlE9lkcvHMGD8
	 DP8yzwK8bx+CQ6J0xs40vmJcwOo+AmU+K1anEB2z8gm7YtymhdFzelxGYow89IMUSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595172;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JkhOqWjoE3Q+BjDXMq8ste1yWf8Gndm7wkosFGmn9TY=;
	b=xVtG2z6k/4/687Zp3PL8qhfehSJIqfufSH+IvYbU058lnruGbWUTBhLn4EutwdytASFq
	 ZGsh+gztZW51If3CjqimQHZ9eDFajNV8FimoQJMq0TJk0ZuakS0pc54rEBt6U/Yr9QgpE
	 XmEi+S6/vo8iPJvvNduai4OkFcLjy63BBE9lERZ1LtO2UGraKjRuBXaIfODRIZO2rCOFr
	 s9Tq0uI9kbH6hu0+5EHwiItQ6XOGuayYrVx7RHXDI17aYCdCLpLN35PL2Ty4ZqPa5LE9F
	 mwTZa15UiVsXfeRkOcjKP36Mg8KIT7EsttTOnFrG57IevZYvNlBUCERfHcjQYxJ/PRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i0Iy827z;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB1606A326;
	Wed, 25 Nov 2026 08:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3FB1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i0Iy827z
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD71D14BF;
	Wed, 25 Nov 2026 00:26:07 -0800 (PST)
Received: from [10.57.72.178] (unknown [10.57.72.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB62F3F86C;
	Wed, 25 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795595170; bh=2sushVC0kbf5QBS5mCE2ZCkoDnbD9EMcF9gJb4NY3vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i0Iy827zQElVSRE1WZTvCP7nzk37SNygK4WpEPMEM5vWV00cZVz3RXAx5KrFPNDtg
	 KDCY749HPcsEm2N2iAB09/n17iF+twdpfqsa5lriKibhXdk2bBKbkO/eE9rfbPNyr8
	 HLccYr3CS2ExnkOLz1QNKqb4a53Yokss+m4A6qv8=
Message-ID: <86b5a9f8-70f3-4a5f-b023-c9fb1a2faf83@arm.com>
Date: Wed, 25 Nov 2026 08:26:04 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on
 PREEMPT_RT
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 08:06, Zhongqiu Han wrote:
> On PREEMPT_RT, an irq_work not marked IRQ_WORK_HARD_IRQ runs in the
> per-CPU irq_work/N thread at SCHED_FIFO priority 1. The schedutil slow
> path queues its irq_work on the local CPU, so the wakeup of the
> SCHED_DEADLINE sugov thread is delayed until no other RT or DL task is
> runnable on that CPU.
> 
> Meanwhile work_in_progress stays set, so no new frequency update is
> queued for any CPU of the policy: one busy RT task can freeze the
> frequency of its whole policy.
> 
> sugov_irq_work() only calls kthread_queue_work(), which only takes raw
> spinlocks and is safe in hard interrupt context on PREEMPT_RT, so mark
> the irq_work IRQ_WORK_HARD_IRQ, as commit f8d958880933 ("srcu: Use
> IRQ_WORK_INIT_HARD for srcu's irq_work") did for srcu.
> 
> Tested on a Qualcomm SM8850 board running PREEMPT_RT, with SCMI cpufreq
> forced into the slow path. With a SCHED_FIFO 10 stress-ng worker on CPU1
> (30% load, 50 ms slices, 15 runs of 5 s each), sugov_irq_work() now runs
> within 15 us of irq_work_queue() instead of waiting for the RT burst to
> end (up to 212 ms), and the policy frequency is no longer frozen. The
> irq_work latency below is measured from irq_work_queue() to the entry of
> sugov_irq_work(). The cost is that the kthread wakeup now runs in the
> irq_work IPI handler, as it does on !PREEMPT_RT. In a separate cpufreq
> stress test with cyclictest (SCHED_FIFO 90) on all CPUs, this raises the
> average IRQ work IPI time from ~0.5 us to ~1.3 us, with no change in the
> number of IPIs, and the cyclictest per-CPU worst case by ~2 us.
> 
>   PREEMPT_RT                           before              after
>   ---------------------------------    -------------       ----------
>   irq_work latency on CPU1, max        130 - 212 ms        <= 14.5 us
>   policy0 frozen, total per 5 s run    0.57 - 1.25 s       none
>   cyclictest max, CPU1-5               13 - 16 us          14 - 18 us
> 
> On !PREEMPT_RT, cyclictest and IRQ work IPI duration are unchanged. No
> lockdep or DEBUG_ATOMIC_SLEEP splat on either PREEMPT_RT or !PREEMPT_RT.
> 
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Missing a fixes tag then?
FWIW
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 14405a614991..b2e9ac7e3517 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  	else
>  		kthread_bind_mask(thread, policy->related_cpus);
>  
> -	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
> +	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
>  
>  	wake_up_process(thread);

