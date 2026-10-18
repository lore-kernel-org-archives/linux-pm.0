Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496702ECD32
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306685; cv=none; b=B/wK5c9LfLMYGGSVMyFznWZC/Z65H/c90Hisp+HXdG1gLajF5URnRhULX/2tT/4v12/3txepAsJqzxay8aoPWcwnR2Mq4GNo9uH5lrOwWVE5SOmpo1N1kZmavBVFrBpFJj7jjW+4rWZ/7DEaHnIQe3/1gQvLMdo6YAVYh+VpfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306685; c=relaxed/simple;
	bh=n8drFyWUqlZVAL8+M5tEtJElOJELGas4rwhBBwINCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbhmWXdzQHWVXIw/Ib3YrWZuMpwj5M0WLwghEOB4tjm1wy0X6RcnB6zCkc8qS8eOzP7EKrFkApZ9R0hPgbfBMKun1g0mlgJJxOb8bxAVgc/J0kljAwwych3OdmWc+vSqnvF+F9TaDG6ktrYJGMPv3l8m87SqyeJl+61c2Lgejv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSms8ek1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSms8ek1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16d39964bso850765e9.0
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792306681; x=1792911481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HwdW3HA63E3gYfbgiIewlrhU22u3aiecjGG8syRP8fE=;
        b=eSms8ek10e1ts2UMABu16BnWjGJQ8utmiRRW93n/jY25Vx03qJ8EHqvMfsJEDy7urr
         KN/Gja38Idv5A4NzoyXPBRwvcmV85egLD2eVpC1RcZXIL6NIGRStMD5a6jBn6yemTuCk
         ZF6HTwNQcjGnLCjeiTSOeo8BO11gBnehZgTeM7vdi1Vbv7Iqb5cnL81iN11vw4GMSGci
         Zlxdm+x/SMk8Ks3wPp6FYoD72L+ixXWFnGWvAPiCXLUN9HZoZMeVIuuaRkKD0/T42bCP
         75nypM7wffTg7wU3gttJNZaw93/oCVyZncvycqYQ//MM5pK3oU+EkQS1KcfSMxe2v4cU
         m4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792306681; x=1792911481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwdW3HA63E3gYfbgiIewlrhU22u3aiecjGG8syRP8fE=;
        b=HVEHqYcAuScl1QxY+Pey9mdVEF5ZC1srsSZzYTSwcdZl+bFbeec7pYpfcGwPJfj7Kw
         zcNk7lyQH+pGsz+H69KYKrFyPfpiIJ3PETFinyVl/blOn9MELlcQ1hNyoDHiNzvJExLa
         VnTMCWx6g/CzAUBe7Pquwr0u8nVrz/NrEP02HCLdaKBwuKo3tUHCybntN7ak6KqUdCPS
         iC5FUaPyN6zBKXR1ZdwTCEpJDEtrkqjPFhrPYkQ2FYUR6BmZ8wguftejQoLKnpd7wOJi
         pUYKf3twE/6PkurXiunqU7CsezB2MCgGVuiIESS3LxhUnPeL3UsKEZzuuWF7Q/44VNTR
         pi0w==
X-Forwarded-Encrypted: i=1; AKwUvBxD5j4GUnp72U3DCPQifJaulzfaCRs/guU5nn3Futy7dvzjCuNCBEYXGGGK/UO5H0ifr1vXpWBJiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBaewoAi7wDde69tfhjSj1WDPB4DtZj6RhiSuKJt9/rALPkZmp
	bt8SNBa8BmHyV4ZJdd/wZuQGfWcx6X+SNQmqVM/EGkp3ysxZ7YnSjn+b
X-Gm-Gg: AYBFou0mdxkdhmkWoHznh1sNOM8teZco8/ibzxZwdaVcBFQa071T7/FRHg1hv0RdYgh
	5nXEVMKXQI3hE2EHPnXN+Lriw63w5EczrM30pqrbWUSyp0sdpmdyPbmBuQc5ks+jigf1mAj1x8R
	CM2K1Cxse2/DWA67JJpa0JqA93TtptZtSB7t7cE0vmNVN41E6Cvibynez57FiQCcbB0gvNeBCnh
	Dni11tlQwYw8XuXMAPltnIHTqQ5mTL9sCf3ZisR8eA3jqTM9SASyDd7J8MPtmN0IWXqnLlk8C3n
	GV0BtJXqqyrYJCpjewBlAW4GAMW+UtF/A+u10vuATAl2Gui28h+9Ivf3lMKuwnVc72rSn1GjXPp
	QT4kkHZKUeykc7IVSwwsChthHmx31xwOai9PTKoDCQuT87CI/cK3XvDi0mY/fNwHCF2K2t+a9px
	yFcg6OC3w922cDvs5oxV0unl6aE8W4Bo1KH+9SUahuqvPB/WaBw3LdTwxItSiTWOV7EppvBlhaB
	R8tZ1sV9ywaFG620CEwzbTofw==
X-Received: by 2002:a05:6000:2882:b0:48a:f5c5:d077 with SMTP id ffacd0b85a97d-48e07b9ca18mr8627716f8f.2.1792306681279;
        Sat, 17 Oct 2026 23:58:01 -0700 (PDT)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm22345732f8f.16.2026.10.17.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:58:00 -0700 (PDT)
Date: Sun, 18 Oct 2026 09:57:57 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Message-ID: <atRseHwvpRJGtjIy@scheduler.schedules>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002154415.2270586-8-vincent.guittot@linaro.org>

On Fri, Oct 02, 2026 at 05:44:04PM +0200, Vincent Guittot wrote:
> +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +	plist_node_init(&p->pushable_tasks, p->prio);
> +	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
> +{
> +	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> +		__fair_add_pushable_task(rq, prev);
> +}
> +
>  /*
>   * select_task_rq_fair: Select a target runqueue for the task.
>   * There are 2 ways to select the target runqueue:
> @@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>  	cfs_rq->curr = NULL;
>  	if (se->on_rq)
>  		__enqueue_entity(cfs_rq, se);
> +
> +	/*
> +	 * The previous task might be eligible for being pushed on another cpu
> +	 * if it is still active.
> +	 */
> +	fair_add_pushable_prev(rq, prev, next);
>  }
>  
>  /*



Re-reviewed this :-)

On our rq, we have a fair task TA that holds M mutex. we have a RT task TB blocked on M. 
we enter __schedule() and from there pick_next_task(). it chooses TB as next, but it adds 
TA to the pushable task list. then we enter the proxy exec path. 
donor is set to TB. but when we enter find_proxy_task(), next is changed to
TA. so right now, TA is on the push list even if its still curr.

(With the whole series applied.)

Am I missing something? Should curr not be pushed?

Thanks,


Kayra
