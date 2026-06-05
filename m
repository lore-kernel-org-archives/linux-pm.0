Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50240DFD0
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642054; cv=pass; b=CHw293Wsihi3BlupuAVLfrnMffOoRY2lNe3f5KIq9yBKVd4vJzGhlH/kpyZpPkM54vB2+IbW9N1/0r0xTYYP8gVePRwIkgKv/q5V/3ZSMxtk+OrdNKxr/wXV99fplc1DR2tCreH0GSseIRkdNUimZ/3yUMJk59prwLvLjh8PXmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642054; c=relaxed/simple;
	bh=PTEwJ0DtnZOeXUKkGq5UzZ386jxzKOZc6pgVirNjTDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIFVbqvzzNlh4qlnxtqU/4Zu9aM4tDngVXjNHeATT7cAdz63Q5z+w/lHjbfl20BtFVYnVOhJcMkJYP/kY+WUvZfvictNlC0ItaWtCC5uneknzNibczdtBUJKYr2PMF9oHgCOcQ6D86COQJtxTwH+B4ZTUst60iuQU0E4SmhepZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWV+z4ux; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWV+z4ux"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso2165054a12.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 23:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780642051; cv=none;
        d=google.com; s=arc-20240605;
        b=h8NcI20LPBmCFbMWs9bV33ela0yfhFeXlHoXDIDwaJeyD7vgKmU0aH7ZGSbxpHoFeD
         UFyTszfnrE3AA1goGrS5Jy9M6Ne8JdPjlLBTDKn8iORRTCZrgjVmN+QB3pt5olxkvsaM
         Ao+nBXrZIFVGUnblmb8ID5s+I+kPAg5tyYM4bxR5o6VLtJRHK7eTZw0BEAk/nMAxgRFM
         dzW1sBJLWIoCixLA3D6cv8qLL/Bj2Hs/LUqFIVu9KLk1PUqpKN6jBPQ03pkG+lUdkTo7
         ymU8EQAJqldTD7r00OBpPGOMBa1jWK//MU95cOJx6jLJbq1mBW22++i1ExjWA07i+IFd
         cATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WQi8IwfiIKApJdZfzNmLE90nXMQkjob7SDDIsKZCGcA=;
        fh=BS8Y/fwnAGMQJZjsi8uBcRTGg7gmh0SmWICyylq/AcI=;
        b=kUaHRC1t0TaBEMoZsqNjzJRB/o23xuwWTlmEeSQsdPq+A+0j2kFLmR7RG27R3SVAGA
         ErpNd7dYyJsUdoC7+O6Q8vQEujn3/DQVwbUuGe4jIYiywefuGeY0E/aXOb3W2wvJ06Zk
         Qov9hl/FSFw1eKtkg9Eylksrxz7h6M2qlBscxnIiECquVwGNB54dKsfHQbTpkhUV+QXo
         yogU3v9ji11HPSd+5I1VyuxBax7zrk508J2ASwIxRImsQRGEVwC0PFu75g7AEaCNYLTj
         9qsztcMMJwept7o/mwv9WG17kMT55DuqsZadphFsJ+dxa0NFC8QcZqdsDSGjdYNMCWYK
         oi3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780642051; x=1781246851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQi8IwfiIKApJdZfzNmLE90nXMQkjob7SDDIsKZCGcA=;
        b=nWV+z4uxPLSx3Z6UrP/eFOB1M+CnUvoxpYgLGW5iQ1/RrBQRs2h7WaWCEkolTUM0Bz
         YDrz3SU0s42RNPoffcMfQupgO+tGG6mk1KlU99tm9KwsQj7GDmN7lwRn+9Lu7+g9iG1W
         qfPRc1u0NWOwICqplMqz0ZLnOD2R8VK7l9LhMFEHMnXmX9iE+jXhjCXpbbLgX/ZAW9ce
         l1ZeVO7bcQ6UVyH9lMsU9/6Xffe19y3ZxUqP9CggL4dHZn+jKcE3g2RG2dWeWJcRmKEI
         1y29vk3QsV0PTObS4HqtOuVdo1P7F5tezP85Bs9kZv/GKoekHxI7T77UKygfQirlM9nV
         w3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780642051; x=1781246851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQi8IwfiIKApJdZfzNmLE90nXMQkjob7SDDIsKZCGcA=;
        b=gomzMYQ4xI4NZ0jP01RHnP/da87Zsz4eynf14Z23iBVwOx4OqYZzSu/35U/7kOVakS
         eabHhmk78zf8FlsdiXHgqjaS9tifLY2+NeaYHJJ9bmppOv9KrUKJsELASbyNvU+Y1fCS
         ApYCa4lR4Abe85fjESnIxLLhceCM/vsrtTROYWu7TZHxu+O5Qh9/3LLuCD31VXU6od3b
         gxGVisWsZNop9SQZ9/KvRBMfG3gIKI0f5BWztLmyoiot3+EFB2gRoDg3mhCAu1FYPK3V
         bp0M2TUnuFVfyR+/1uQ7DeNhD2v6DD0bAkpakccGAZKXmisWIrzcq25KxpQEHGDBTK55
         Iszg==
X-Forwarded-Encrypted: i=1; AFNElJ8Cb7nJYsWvMds6cNbeZ7aQwd1YsUrsSw2TmWe0DG50/a5mDvAgFxemQq4jP1b8zHET0JF6CtgRQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmpAgPrHmpADRLwR6XK4qiZS8On8iWeDA6btIAffJQRPuWwvy
	5LpBdLcxAPQeqwWiWEfNNpdvWtbxW9f/rSknkUmB1ZXsfWYOGOrCL8fgrxb18D7y+vs6YbEq6Py
	JHfPQ2f3inrD1bSU7WF4sXnDHHBM0FmMUN/Do3qPTmw==
X-Gm-Gg: Acq92OEIBtY6xMuxhwnOKkBzoXQTac6auQVhdfrQgId1QVkL2vc7N3sqySG4VXmeYZX
	7AC1l6zqzeBoflVs/4rabpe/y51FZkTIzbMwwTT7UDvtYsdJGanDPifThBL0vaG7G8Slwk+C01a
	6Vk7FBZFwzG6WW9kpZ1B3YFww76c31Q7DTTNkf2cS2KXlggmKa6xoR2eoCROnFsCrBEE40HFUgB
	77XCcJa3qOEdTp3sPQMGbVPecy6chDrOEB8V1IS3kCp3sQfyrbTeuSLdKstxZ88KuDS3IlB8v+a
	hvjMZA+Zaqjc849KRvx9oLmE8EvVzgErQrDPbsMZOs1t0+I=
X-Received: by 2002:a05:6402:43c6:b0:674:1fe8:407b with SMTP id
 4fb4d7f45d1cf-68fa4c26784mr1002229a12.9.1780642050758; Thu, 04 Jun 2026
 23:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
 <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com>
 <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com> <CAKfTPtBJOtgMJLm1PhiLPFup9OWYLPCChumy5EKuLuEEbu2gYg@mail.gmail.com>
 <2886fddf-8f58-491c-ac27-e4d9b34b66ad@transsion.com> <8f5f944e-b150-47a3-b1e4-bcaac6151b7b@arm.com>
 <4adbab4d-f9e4-4354-aa1e-48f11b1fd208@transsion.com>
In-Reply-To: <4adbab4d-f9e4-4354-aa1e-48f11b1fd208@transsion.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 5 Jun 2026 08:47:17 +0200
X-Gm-Features: AVHnY4JGOHLcWAIunDhvMEeenAfc0LL3LD0aFl9A0oVU_dHA7uBecfLiQw-d4L0
Message-ID: <CAKfTPtDykqU9ABQMrX0r77dH3UCS_6tKWKeNfH+LiKLMjrUOhQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Revert boost in cpu_util()
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Pu Hu <hupu@transsion.com>, 
	Jiazi Li <jiazi.li@transsion.com>, 
	"christian.loehle@arm.com" <christian.loehle@arm.com>, "qyousef@layalina.io" <qyousef@layalina.io>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 04:49, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>
> Hi Vincent,
>
> Should we fix the runnable_avg calculation first? We only take
> max(runnable_avg, util_avg) after all calculations are done. Diff:

Yes. Please submit a proper patch for the below
With a Fixes: tag

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69361c63353a..050bce06efea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8231,25 +8231,31 @@ static int select_idle_sibling(struct
> task_struct *p, int prev, int target)
>   static unsigned long
>   cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>   {
> +       bool add_task = p && task_cpu(p) != cpu && dst_cpu == cpu;
> +       bool sub_task = p && task_cpu(p) == cpu && dst_cpu != cpu;
>         struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>         unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
>         unsigned long runnable;
>
> -       if (boost) {
> -               runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> -               util = max(util, runnable);
> -       }
> -
>         /*
>          * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
>          * contribution. If @p migrates from another CPU to @cpu add its
>          * contribution. In all the other cases @cpu is not impacted by the
>          * migration so its util_avg is already correct.
>          */
> -       if (p && task_cpu(p) == cpu && dst_cpu != cpu)
> -               lsub_positive(&util, task_util(p));
> -       else if (p && task_cpu(p) != cpu && dst_cpu == cpu)
> +       if (add_task)
>                 util += task_util(p);
> +       else if (sub_task)
> +               lsub_positive(&util, task_util(p));
> +
> +       if (boost) {
> +               runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> +               if (add_task)
> +                       runnable += task_runnable(p);
> +               else if (sub_task)
> +                       lsub_positive(&runnable, task_runnable(p));
> +               util = max(util, runnable);
> +       }
>
>         if (sched_feat(UTIL_EST)) {
>                 unsigned long util_est;
>
> Hi Dietmar,
>
> On 6/4/2026 9:21 PM, Dietmar Eggemann wrote:
> > On 04.06.26 11:21, Hongyan Xia wrote:
> >> On 6/4/2026 4:48 PM, Vincent Guittot wrote:
> >>> On Thu, 4 Jun 2026 at 10:21, Hongyan Xia <hongyan.xia@transsion.com> wrote:
> >>>>
> >>>> On 6/4/2026 3:42 PM, Vincent Guittot wrote:
> >>>>> On Thu, 28 May 2026 at 04:36, Hongyan Xia <hongyan.xia@transsion.com> wrote:
> >>>>>>
> >>>>>> From: Hongyan Xia <hongyan.xia@transsion.com>
> >
> > [...]
> >
> >>>>>> Analysis:
> >>>>>>
> >>>>>> We found several problems that result in the power spike:
> >>>>>>
> >>>>>> 1. Arithmetic should not happen between util_avg and runnable_avg:
> >>>>>>
> >>>>>> After util = max(util, runnable) which potentially picks runnable value
> >>>>>> in cpu_util(), we then add or subtract task util values from it. This
> >>>>>> produces a value that is half-runnable-half-util which is ill-defined.
> >>>>>> This alone should be a warning sign. This breaks EAS calculations in
> >>>>>> many cases, leading to sub-optimal task placements.
> >>>>>
> >>>>> This can be easily fixed
> >>>>
> >>>> I thought about adding or subtracting runnable_avg instead, but that is
> >>>> still wrong. Given three tasks each with 100 util, if they wake up at
> >>>> the same time and running on the same rq, their util is 100, 100, 100,
> >>>> rq total util is 300. Their runnable_avg is 100, 200, 300, rq total
> >>>> runnable_avg is 600. If the 1st task leaves the rq, the remaining two
> >>>> task runnable_avg will then become 100, 200, giving a total rq
> >>>> runnable_avg of 300. However, subtracting the runnable_avg of the 1st
> >>>> task gives 600 - 100 = 500, which is very wrong.
> >>>
> >>> Substracting/adding se.avg.runnable_avg is still the right solution
> >>> because this is what will happen if the task migrate
> >>
> >> One difference is that before runnable boost, runnable_avg really
> >> doesn't affect EAS and CPUFreq much. Runnable boost is the first
> >> instance where we directly use raw runnable_avg values in EAS and
> >> frequency selection, and this value is often too high to be reasonable.
> >> I'm mostly arguing that we should use it in proper places (like the one
> >> in util_est_update()) and not here.
> >>
> >> Actually this is the very first fix we tried internally. There is minor
> >> improvement in EAS spreading out tasks, but energy regression is pretty
> >> much the same, and Youtube is still at 20% regression.
> >
> > I thought the issue was that, in your low-power test cases, most of the
> > tasks involved in these contention scenarios are raising CPU frequency,
> > but they are not directly contributing to the workload (including
> > Android Graphics Pipeline (AGP) progress). If that's the case, the
> > additional power consumption is essentially wasted.
> >
> > Could you collect some information about these contention events and
> > identify the tasks involved?
>
> Our profiling shows that there is a very typical scenario in these
> energy regressions, which is IPC.
>
> Quite a lot of apps have per-CPU worker threads taking data from
> producers. When a producer sends the first piece of data (mostly using
> wake_up_sync()), a worker thread on the same CPU gets woken up, but that
> worker is not immediately switched to, which is right because you want
> the producer to finish producing data. But, because that worker thread
> is already runnable, it starts to shoot up its runnable_avg and the rq
> runnable_avg. When the producer is done and we finally context switch to
> the worker, the frequency is already super high and it takes time for
> the frequency to decay.
>
> Two problems with this:
>
> 1. In this common scenario, the producer and per-CPU consumer threads
> are not really 'contending'. They are accomplishing the same job but
> just split into multiple stages. The 'contention' here should be much
> smaller than two independent threads doing two separate jobs.
>
> 2. When we finally context switch to the worker thread, the frequency is
> already very high. However, the performance is already dominated by how
> much data the producer has produced, and the high frequency here is
> useless most of the time. Of course a fast consumer helps in some cases,
> but in these IPC scenarios it's mostly data-limited.
>
> Actually even without this scenario, the frequency driven by
> runnable_avg is still too high, but the above case is where things are
> pretty bad.
> > By the way, I still assume that all per-task ADPF boosting (including
> > AGP boosting) is disabled on your system. I also assume that the number
> > of janky frames is negligible, since you're only showing FPS data.
>
> Yep, your assumption is right indeed.
>
> > [...]
>
