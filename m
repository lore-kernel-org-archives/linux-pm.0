Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990374;
	b=TAsDWp7UrXl0W/+rSg0G9LfA0XT2/w2TrsozZ6ckRfzxZM3LGZeeLVFtWzNCEtozHLV3
	 jxj7AjI5pi4ZAqCANQmdYlGrjLP349Ndmn4YE20LtPvi7/3WrYW8EAzCqubrp+NUj1HBi
	 cSYzBA/rYUDXFxd+2LVRuniiXSkeytfVwPF69lbbrh1WUFKwOIxufInHUHeZlMUKIEHJ+
	 C29OlUF/aksEjS2KOKx6qKU8t3tyW63wqoHwY7bhgjCWcB3/vg0wiRMIrZ4E/Yv3LdB+S
	 gdQJ2Xt/yfEGrDYZL/gCkYogyj5PiMyUq1t2jq/ORGhBAMtaMnzQCaFLQMwxRsHBjCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
	b=R9Z9FHchkkZbGE4k8OLOq6y0vfACH6vxHv43GnQto28hLKQr8FXTv+6p9xL4wTyxyadV
	 jXg7NQ51K+oTrHNQ/hdkuMwDlp+a8l8DhYnzKH8nL+549c9MfYB3HdKS5VA20mBl+KIpd
	 prKpfKWzeDiBVZbWG852aPjl1+3Rkv0AaK7RGWQ+Lmzuj0Ee9mED9u3uNyN+lW15v+NFM
	 1dzM0WPe2umghzk2nFTFl1fZUFrYJ7gVFV5mYO1s+paFNbRnbNQxz8Qnj3bHIXkXjJNzi
	 5hd4KL4iqk+8VFpx2XmJ7l/IdMc7okBApiTSzRP6fjlT4uwKTJKU6O3jhPqw5H3l74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tN2ltPKz;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10756606A32D
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 18:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10756606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tN2ltPKz
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a610c7e61cso675225e9.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990371; x=1794595171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
        b=tN2ltPKzR2Z1JRfPyYauSTPlV3eJeerY4K9aVMlRbW24glYzYkMMPHCOXFG7NV7g38
         OYl/se9BorEGj0ykocHcjmvQddONJjpdmQ+8x3squcv2FKwnd7KGQV9J5Xreznu0ikWy
         8swdkv6ZYPpCfpq4iAeDG+tWGO6COV2v6feJObwpKdEqmW/YyHKUdg2669ClmQVrMTxt
         b7N+huwnpqpnrkPeMpJHAjQP+4sFm9RUlbE6WN5cQm2Z2L817m6l7Tc0uQk0EkJAgyNN
         QakNzJdw6g+i1egEIy7c8djK8pR09egrN7lAkcheS956aO5WBhTVov08XV8Oc4WBxoQd
         duOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990371; x=1794595171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIwS4OC7s3U8Z4r3z87plyGX8aJlDTv0Ul5Ftw3BSuw=;
        b=WOJk8XGj+N5vc4hEWp0prPEBQwnQ8aJr2df1DIArITdVmxlXBi9LG5jkFGLPT58O08
         shgxigzOC3IKuIkentfGgUpiKTnk04H2FGpQR600z4iQrzQnMmzNm0jNzkFU8ajeS9h6
         xuBdNRgZc81mhXR37Z3zvRj/qaKUNnE7dsJUocROL7iUfyWiPAIJPR0g4bNnMgfRiDT7
         1dCyzfIB9lNyrU8F7S8uXNv4EtIN/AcII3Y1rGt00RYDIJBD5lu9sN5m3+4pLpPnlt9P
         6IYgUgKpa8htkK7Qw8fi6PFv6BYUoi/G4me+rJI8SyXytjA5gAd330CLYyLIbM0awWMz
         eboQ==
X-Forwarded-Encrypted: i=1; AKwUvBxps1t+mHrreGahzIIK0RDJbPtWMdqsXmYqv1Kl4Ac4QWs2ganWxGG9FHj8MNOC4yCZbtqAv5SmFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/JYx20A12hASDr3LHSdxXLQ1exUSMhFDhnzwOHBMoTtB9Dj3R9
	+fMUTBnJblOIfLne6vyZcH6WK8iIlS6dr3vHUa4qUOUz9J0yNwDGnP9V
X-Gm-Gg: AYBFou2Y9SWvIAlVliLYtpLRMvh0UeBP9GW+MGxM6LCKDmgMiFZtP/NhgLFxJgzY/BL
	8qbDo3AnTXNdn6lXPnzmKPTtI8bl5Zp14FoO7Dc5MAZqM7IzmRsRz+BrRFJymYq9DkAZRkhJN4v
	RpUZakZi6CRDB5lT8E+UfDCLny5o92geN5c1I8nTbYj/Xyaz5d00ATIzjJFWcPBNVcQA4c+d1aR
	2I3dMuW9TN5aqeK0XOXFqlDWWEIMRhtltKBULXIcq+CYX0Yo79pmWziVJpxvp5RdJ0ryvXTsE1x
	YsMFIqjOXMVXf3+sveHdsOuuzS6EjHTUQBGEnX5G4SpcJ+khbT0Meh3BnkhWyqp093V3i2Ue+k+
	DWtlEbB4xY23N/f7d43bRTIfDV2Id8PSy/04tXEGbx5PvxZB5T0dmAYymsZCRIYrL+q9AnevXkt
	d02JWfJrtOdvDc0knMrHlRJE2NPd5bMS/iFyksk9yoA8WYSR3fv1+iadc/2tlzMwwz9wh0dV2GI
	R2YZxXrVB5F1iDn92oXIkmUDlP3A24fUSHaKGPQRO6W3doi35uXJSndw7unYdpCFtGZ3OJa5YMr
	DEZYEAsUyfPKkGW6q0VvplaBbxfSoezItDrGMMrJi5GPsq2dHUddn7M=
X-Received: by 2002:a05:600c:c111:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4b6dcf861ebmr44070765e9.1.1793990371217;
        Fri, 06 Nov 2026 10:39:31 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795038782sm4128115e9.3.2026.11.06.10.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:39:30 -0800 (PST)
Date: Fri, 6 Nov 2026 21:39:26 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 04/20 v3] sched/eevdf: Reset lag when waking up on idle
 cpu
Message-ID: <au4dOi6ASp5OnBWc@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-5-vincent.guittot@linaro.org>
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
In-Reply-To: <20261106151947.3991524-5-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:31PM +0100, Vincent Guittot wrote:
> When several tasks wake up simultaneously on an idle CPU but their prev
> CPUs were not idle, their final vlag will depend on the enqueue ordering
> as the first one will lose its lag but not the next ones.
> 
> Reset the lag during the enqueue if no fair task has already been picked
> and set as the running task.
> 
> As a typical example:
> - CPU0 is idle
> - TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
> 
> Depending which task grabs the lock 1st, the behavior will be different:
>  - If TA is enqueued 1st, TB will be enqueued with a positive lag and will
> be picked 1st.
>  - If TB is enqueued 1st, it will lose its positive vlag and both TA and
> TB will have 0 vlag when eevdf picks next task.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945de0215abb..6ce4162a7703 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -967,6 +967,14 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  	if (vlag <= 0)
>  		return;
>  
> +	rq = rq_of(cfs_rq);
> +
> +	/* You can't claim any lag when waking on idle CPU */
> +	if (rq->curr == rq->idle) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
>  	/* No fast access to prev rq task clock */
>  	if (flags & ENQUEUE_MIGRATED)
>  		return;
> @@ -977,8 +985,6 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>  		return;
>  	}
>  
> -	rq = rq_of(cfs_rq);
> -
>  	/* Compute sleep time */
>  	delta_exec = rq_clock_task(rq) - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
> -- 
> 2.53.0
> 


LGTM.

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>


Cheers,

Kayra
