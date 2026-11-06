Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988345;
	b=pl/VjuVMWDBvUdy8Yltr5BbAA/bGjbLz+S0sLsioEcCCcDvWUx438zzIfTt0VPjbrfMf
	 7bdTEuOwt0QB+nXesvU5a25TisNXNONNv1xSl9wid7oMWgn4DcD6GjqfPop7BSfARHEPA
	 S0FQ7efONuRu/xBe8qLkdlUt1J9YCzwL6tpcSZFaCUms1KV+07Uq1cVHA6jLR2YFjO5tU
	 bOeZm/CCxrm6oCtYc/vyt7aobR58EJyaDLu+fH7AZxpzQ01+jHm4sGEony2OemLAFHpAY
	 bJ0dNGQyK5mgj+oJNV9btPeBY6VpGF4kR9d5a44R3gcOHHhpAFXa6EjIPksl2KbJCUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
	b=gq5ODtFs7YeuuIr7NA9qslx4vhzeBJNO05lKX3urTiyZ3kl1AmQLaIhAkBnrmVSfgxHV
	 sy3TaZtlpDeDcY39NnJmv6eV2Wf1XgdbtuNuY1pCPu89Ztt4ui5R+BdphLNCj3PyBfMSC
	 QzWwDv+syedo0Cpz/T0ufdsxMPFVh+3BSOGDtzWJHgGJMRPLpTmirchLFMmYihjSSQfd1
	 17GNjmTcnBhvwYe3EJTYcRTh6nRctytFDicCURMV09+fzRM/kfPmmEaj5iJ9pgbOyFd+3
	 dASInmFovQxH/ReUEcEz2YPB33jhgSeXnk13oyDjbZDQdBbJ3Mv6Hfm+ub6644RmX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDX+Zd25;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC74606A32C
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 18:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC74606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDX+Zd25
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4ae34ad9bb6so836605e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988343; x=1794593143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
        b=pDX+Zd251WQpm6lKliRaHGDE4tv6knRdEQFWJ0njTlCFH7tbNH7FFpgqz4w+S5kCbh
         XOyWNB0UYTht3IXJnX5mbkTHDDIyCWwByjYpQmtKDL9+svTxEg4o+IX5+KkhgM64obXh
         UM5pISQPtE+WC0a5DdXCim1A5jM/VPccMkCO+XtXYIOJdGG93TZg37uvMUK1FMRmSEwp
         mj9Cfco4P7QxGVTa3Al8cKsk08PWurzasTwZVqHTMXrUYL7c+4AWn+vyxiKJxsiGrPQm
         H/HxnJQMY8KWM3IfJly/NCNUhV/sPKs6ORlE0E0J4TfY1T22Bh4XemX6QCS7eUYBGKPH
         epnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988343; x=1794593143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SJCRFOyyzqNtQQYZheoRjYTqtXjqo/uUdL5tCibwPE=;
        b=dTKWWGjdaptBCsOZapkGDKVZXmqr9e7X/rQ3ErfA2mXW10PzKuUPHg3Gox7U9U6RLX
         MmnQtwqxgJx47hK8ZiT7e4giT6HOC/++1wFFuEaF0HCzx3iFFcyx6AOrPL1uJpsprUw7
         wOvWxdAwCRfnd5awn0KBUUKbNT64D2Bt17t6hQipd8HAlMD7mMLAtkzHqW1t1lpJoXy9
         ajpEO64YCB+JAPx6ju15xSF9outgFI9AK2hJQVWvgVJsOR1AOMLT4NLrLgHr3P1YrOVU
         //FT02SKMqa5AtyPxOMENYaQTmNksWcK9OON9GmgIUFz2nIWBCQJXSMcw6IVeRahhZUq
         tI+g==
X-Forwarded-Encrypted: i=1; AKwUvByPcUUiMKTzZ2biJLAj9zIbnfERIDhIOuNfGJNSX0fNHRsCorMJzA4FFFYWrAZYibAkkmQQNwomGg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ScxMZhPGl+WVsuZ7saTMQk1IfXGYwKD8CgiSw0Nc3c9QBRQ82
	WMbSeb0ZxZvt83ijuZKMASPogrk5hgd6wbTXp5VkrxJ92Qio6wI9aq+SJj+Riw==
X-Gm-Gg: AYBFou0PqbyIub7x/pX2SmLD6hHLrt3iQaMEN+CVS2ROdI47lk3X140+w8RNYoN6Hwa
	jTjdsek5kYe2OJU3nVlx1gFwDZlfARCbjMCQNGVbhEh/EonFcp8hnaxKN69iKs5JwlRTpdH83KZ
	G0z5czVcgiPAIobISUGjhKOzN5kAc+XgIC/GvyIt9MqMyf09UfggioWrFY+XHWMkMF+5417mOsc
	jaNddPj5Gpzj+Qijrhl60hx/euEzl6RPtGZwwMCB0D9lzS6LRxOW9MGqSldQScuOhh4ujnRuPnk
	uqwvwpAUsS4OdrGoSHR7Lw6AI3BvZMUkq+YlXmSK4+lAa9oTaHa0npMmv1wAyaPjEumgh6zWqlF
	xYmNg2+zehRReHyX5PH14YhipJf/8mQbhjPz4zh+Vj49/sX4nonk5wP8O/NuSaOFUyYW6nGOQjU
	aelBXfT5+8NoZTqbf/caD0E+yI4OQP2J1fLUOVHo5Fh6Hj4qHwDmRFoIt2ozMkIGbzlIT5a4025
	dqOk7ZXE0Uoo9/Q3kuh7xWiRDL8ElAOyv7ZGoB+jWTfEhWJG6VaEUug/T3SqaHHYYxMoK0Xb/+M
	tVxQR5Bn2pKOEVdx4MPyFWifbVXCVTqic7X5bHoelJJKz2k7RVumra3gNn2T0OKsD5BHiO75Hw4
	r
X-Received: by 2002:a05:600c:8590:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4b6dcd99da1mr43174545e9.1.1793988343041;
        Fri, 06 Nov 2026 10:05:43 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572caf48bsm171361085e9.11.2026.11.06.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:05:42 -0800 (PST)
Date: Fri, 6 Nov 2026 21:05:38 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 03/20 v3] sched/eevdf: Reset lag at wakeup when migrating
 and prev has been idle
Message-ID: <au3_SlJ-5Hh98m8Q@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-4-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-4-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:30PM +0100, Vincent Guittot wrote:
> When prev CPU entered idle while a task was sleeping, we assume that the
> latter received enough running time and the lag can be cleared similarly to
> what happens for a negative lag.
> While migrating the waking task to a new cpu, Check if prev CPU entered
> idle in the meantime.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 79f53811274e..945de0215abb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -932,6 +932,27 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
>  static unsigned long task_h_load(struct task_struct *p);
>  
> +static __always_inline
> +void entity_clear_lag(struct task_struct *p)
> +{
> +	struct sched_entity *se;
> +	struct cfs_rq *cfs_rq;
> +
> +	if (READ_ONCE(p->__state) != TASK_WAKING)
> +		return;
> +
> +	se = &p->se;
> +	/* Negative lag implies delayed dequeue */
> +	if (se->vlag <= 0)
> +		return;
> +
> +	cfs_rq = &task_rq(p)->cfs;
> +
> +	/* CPU has been idle in between so the lag has been removed */
> +	if (se->vlag_seq != READ_ONCE(cfs_rq->idle_seq))
> +		se->vlag = 0;
> +}
> +
>  static __always_inline
>  void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  {
> @@ -10049,6 +10070,12 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	struct sched_entity *se = &p->se;
>  
>  	if (!task_on_rq_migrating(p)) {
> +		/*
> +		 * Clear the positive lag of a waking task before migrating to
> +		 * the new cpu.
> +		 */
> +		entity_clear_lag(p);
> +
>  		remove_entity_load_avg(se);
>  
>  		/*
> -- 
> 2.53.0
> 

Yeah well looks good. I need to test this on my head tho:

CPU1:    CPU2:
TA       TD
TB
TC

Let's say TA sleeps and has 12 lags. And while its sleeping TB and
TC leaves:

CPU1:
TA (Sleeping)

Then some new tasks come:

CPU1:
TA (Sleeping)
TW
TR

Now TA wakes up, we enter try_to_wake_up(), from there we pick CPU2 and
enter set_task_cpu(), from there migrate_task_rq_fair(), and to
entity_clear_lag().

And from there this just works correctly.


Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>



Cheers,

Kayra





