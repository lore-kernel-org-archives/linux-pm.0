Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482969;
	b=LHUfFq/v7zIOfKPCyZYQuHPhRL3qZ9n9TO2q3jc/dAI6NJRHI3r63rKqvwQiNm7Yz7At
	 DhaiLUas1UjS2wBzzW9ANrdAFlml/yjXreMJEnBNWerqpVEzUkenVeWDAev7MlCg3Vbot
	 /Zd9jgZChgNoxQYctZwJ/UNiw1Sf9TaSvNh/vWOtHb7ZTVBUZ9b6gACD0UT/So4tnerFJ
	 BhIUXowVD3sejSuKzOvsCoLRMkFoyIa6vnkeg9oFhZ1MQUbyHodAuXt2BnaSQjKi5D5eD
	 T7rPDpfqy9GVOB+T9RlFd9LsR5n9uZrqa0oOn7wD3WlAhLhpp9IR8jCgKTsgtYZvaug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
	b=tqdkm+HFQkHGesS3h1/+LwD1rVFr1GLd4q87ZQ9oTVjnHoN8vzUj9dBpUWMQ1KwbkRJy
	 MhKvLYAPSeprB305fTNMMOZZlikwu2pKB5qEKSlSAW/31DQbduAk62bIRiumzpm4JwcBK
	 DwNb1otGUBx18L3jS0ajTGSTwoJZseXgKeVu5Z7XdQ2B9aO/WhCG1VkN2cO5lRcdnatdp
	 w0p9f9UlbV47VYnZ/fdaf1u/jGtepExZy0bbsUPBgkpneQBNuon2jQAG3ez3efi+ipyi/
	 ljyaulk8Okff85VBuKq35MI5EZ+ZqPMM51PXqIFURD4RynUv1nphRZbgdPRvXyCTnfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WBJlqcez;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93A606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C93A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WBJlqcez
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so4146442a12.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794482967; cv=none;
        d=google.com; s=arc-20260327;
        b=e22/0dvbjJDzNwrGp70IRagC7AkLBSg+EebnpUfcceWQYOTogbknM0qclqloJD5d+V
         +Ly5xs9Ro/sqW3d9yvQ/JT4HNgVCFHBkK0YnWu9JBl1VDJ+bx0zWCvK/R2eksiFHXEdS
         XXkABlXC14Vwvj1ZcDZWcjgu96QjWM0rT6YRcY/dFMW7viBXXWPCehTDO4CDFVpcmsEQ
         YBZdEO7LxI1/3VUTcje31HYBE/JfemgG2YJOypV7q2AFZqezQda8YZjepK3H1lfRBrjE
         Hj2AceGeDc47gvTdmZ+UAInSJrNmw4wiPEYcqy7hCI5JY0pLG6FuoqDzbFv9Ltbdh1lp
         12nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        fh=Kus3OJv6thuWzpaHNFAowSC8/ZtJzx182Tz7YWkPsTM=;
        b=DIh2WVlnFNIxlfSui5aV7I5+wMEbt7kg6QP44B3389Rkvt/1QbTW/V9wMJgvVXUaQ5
         5F1fYS3cPpxuog0F3D5XqBYbSLlmDmHUIUKDmMEipUTSAh33z2BakBNj4NG9kCrTXKBL
         QaJgw7RkotIZIFNN43HzCahfeEX89819viL3CEMme6C/29iX9JgE5ohXkNduJ5bD4DEj
         o7sOCpBWgQrbZqOICw7XsQ3Tpvtxa4xAV+I+j9W2MOjvgQksvTLzJEa7Ib9i3n/JkqkU
         SoEGw/ExeOgGRA4t8pr62lW8JTUE+OqLQWebxoG6IMZiQMzOnMY4iRgA6ZdqRx4P72fb
         HCTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794482967; x=1795087767; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        b=WBJlqcezkcWmxn7fvS11nhNKAXjApPC2+byoUyVx3RlagWMOV1Cyxhu+NSHqqTZg+S
         GQbGpn5HC/WaAlQALYu+kiqDcgHIbPuFSyjGlg+UnxEHyqXTDWgKwoA0Ht2r9XA34vKd
         2/ZSKRb3gxzGN98tdR5/kJQMY1didACcvYbKgE0P/0QJmFCu+A4rN16UyP9fbNxJOvHt
         9uaVBUGCwpmEJDxTCbHYSPQKMC4eyNTdB6JQUA21wGUfOEvrFLVTlgVVHESdutLx1rnS
         lc3Jo+QKt+I0H3XrhbfKF8OqFxPWOg1fqJCjH6DRF3bn0JqAWFrdaagmL7GYN5YKWFKU
         4cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482967; x=1795087767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        b=2oUTGBrSKeHcrSVBSn1fw/QYO/+vYglEcSTqEi25Yo0J3qvv0tBiIe9YYWeuhzimF8
         Rm4q4uphwgRawRZDhbNTAOJKzP3ToHnxMWn2lSjCkN6AzUfTpkLggdYoRKxRu+HtdHy1
         SOlXDuyHlAd3eW6ma3li8gpvpQTSAlI8QbbWsz1npEwtVq6iTsaEsqsS8d/GMaufd3Qu
         qw2C3C7mvL6/1RIWNCtdsRiM/hCgGr9rltiYX1eGsN23N1Tx8qcUzmGWEE1tqMwMuWbi
         No5JyRFZW7YgvJ2QWNo9W3vzv28xNkTqPjdzT2SxxfdZPq1SHHBfrj2BPu2QrY/VqjeG
         f7jA==
X-Forwarded-Encrypted: i=1; AL+hErEXQoC4pgaVdAxyRsC+pTGDnnnYavdERu+72F4SPjSPAHZuMeQYNmOZ/Th8TVpYw6XE9+3PBhzpFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+J+9p9I0iVMdOk3b8xoFxXUpa/JpgLY5mpP1C4GRovh+Lk0czb
	pPBNesNUbX+gbo2jKDxz6UlFSqlCBQEy9ewPkNLPr+hN5IxT9lZRhd+/vVEnfE3/5HN0LoanPWu
	My9+W5hmQz9hRduEMbRofMwarvTek6yVmMSBQcwMIBQ==
X-Gm-Gg: AYBFou1V8YrjZHLxO+l3YTosR8ligPBVe9wXKIogs7Up4r+NReDlc5CW5+a1ZHKnoXU
	dKWVX0XZbKC3KQ9u/pJaolHEOYHjPDadCqQX7Gmx2nprUex8aHyougpg/yx1h3qMmFGdDvfB2vg
	P1q22L1XEzk6wLM1zlIZLei9KPzbMleXGW9CU2N2aF5cy37AVBUyBBnU73FhxEX3vqpzyCRH0c9
	4i5Ey5OWibla7JBAXVen2S7lqPQqk9lQTL6gw3MXxDyFa3oCNauNltQuhjOn1jkwm+ueWXeId3V
	GkRUeVzbylSE95qJyrnnlexumLt6vwKEgeDGgJmP7u/xVq3LZCOJgjpGn7B7jrLjHMO3lbJrtdH
	wT1lYfmkTl3ffCTzkIqm0Hl1vFHJHI4JaW5b8QQI7HdRIHAYGBSmeTqeOB3TzHiosy7BK4w==
X-Received: by 2002:a05:6402:1d51:b0:6b4:16be:4fa with SMTP id
 4fb4d7f45d1cf-6b7773edeeamr4079109a12.15.1794482966709; Thu, 12 Nov 2026
 03:29:26 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com> <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
In-Reply-To: <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 12:29:14 +0100
X-Gm-Features: AclHuK8GqM8XGi-ga2efC_FAPlazK7Ox3_1G0kC0seKYatyPLvqoUsk26qpWqiE
Message-ID: <CAKfTPtBNx9Dpe4zBAzJU1iabp6riGAN8v-GP9bc5fh8NZq57hQ@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 10:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 12, 2026 at 08:01:17AM +0100, Vincent Guittot wrote:
>
> > I don't want to take any random task from the rq but only one that is
> > meaningful. Why do you think having a dedicated pushable list like rt
> > and deadline isn't worthwhile?
>
> Well, effectively cfs_tasks *is* the pushable list. The below patch
> makes no effective difference, and can be argued to be an optimization.
> Currently every consumer of cfs_tasks goes through can_migrate_task()
> and every task that has nr_cpus_allowed == 1, will fail that function.
>
> The thing seems to be that you want additional constraints on your list;
> like dropping tasks after one push attempt. The other classes don't do
> that, they do the same thing cfs_tasks does and keep all runnable tasks
> that can migrate on the list.
>
> I'm not against adding another list per-se, I'm just struggling to
> understand your extra semantics, because its not _just_ another pushable
> list, it has some extra flavour.

The main case is to periodically look for another CPU when a task is
put back in the runnable list. I also have other cases like patch 20
where several short tasks end up selecting the same CPU or when the
short task finally can run 1st and should look for another CPU.
Because anything can happen between wakeup preempt and pick_task_fair
I don't know if the 1st item is the one that might to be pushed or how
much requested it

>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0552eaf64e95..8c81d236b24d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4693,7 +4693,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>                 account_numa_enqueue(rq, p);
>                 account_llc_enqueue(rq, p);
> -               list_add(&se->group_node, &rq->cfs_tasks);
> +               if (p->nr_cpus_allowed > 1)
> +                       list_add(&se->group_node, &rq->cfs_tasks);
>         }
>         cfs_rq->nr_queued++;
>  }
> @@ -4709,7 +4710,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>                 account_numa_dequeue(rq, p);
>                 account_llc_dequeue(rq, p);
> -               list_del_init(&se->group_node);
> +               if (p->nr_cpus_allowed > 1)
> +                       list_del_init(&se->group_node);
>         }
>         cfs_rq->nr_queued--;
>  }
> @@ -15620,7 +15622,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
>                         set_protect_slice(cfs_rq, se);
>         }
>
> -       if (task_on_rq_queued(p)) {
> +       if (task_on_rq_queued(p) && p->nr_cpus_allowed > 1) {
>                 /*
>                  * Move the next running task to the front of the list, so our
>                  * cfs_tasks list becomes MRU one.
>
