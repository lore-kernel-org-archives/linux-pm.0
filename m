Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC4E73DC
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657719; cv=pass; b=RikVdA+SqNSbVvZP9pbAVKXmzvzRMKV4kC5HjOOcHscY7Nl6qNST/IAputdpACMq151vna9GP/qAEqL+IYh8CPcsxe5I9Pbqorwpq2SzfwGCobuI5fGbFtK28K1dtmf/nA0ifUWN+7m9EBtWazj82Aj++B+2g8AAZM7Luko36Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657719; c=relaxed/simple;
	bh=w+7+J7eoxN0duh2hWV+22S5S3+5YdCbqPocAFCKgN+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiu0PxtO1mgUrkLyFA+SqKN4fDNHSpHcTAU5w3PKZketn0X1PXLgPctdrxscNkcxxbXr1RV7nN//eVNmL9zeQklpV4q0/FXw5ahEJTwEf9ZWVrVsI6DSTDKAratU4hY4X0C9WkfpUU3a7pF2SkmG4+LgRcZ1e0vLJyikQ7nuWPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hL0egtNn; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL0egtNn"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso164919666b.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789657707; cv=none;
        d=google.com; s=arc-20260327;
        b=Az38K5dA6OI/KYQbR/+icaxGM9dYWcPsmpRLlc2jhtDEfvlRGTsb+BUh4unmmUZqqe
         ANDgWARc6Arsu4QkuyI0iRUZc7Lx9WDjWJonIkN4CsS/ZT+4Toje1dupvf3XNQtnEccd
         x8OMo65y8yJqV+g+OJoPUkJFg4ULH7JTDZ1RP3aNu+k1h0yrwmkTjpcRPZIJQGhWRaGk
         VmJHBQYeA+3dwSTWKUasRXG0OqczYc8wbsTnH70wNd35wtcgDBtyjr7VCWnnAMXA7qhe
         YDqv6gWIdt0kANA5fG70QXBZvyMn/3peLppMwfzwSiwDHKRYRmw+ETGUvJusk+GJdZWH
         159w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PBwimhxw7BcNYF6pIJGNqZmsQ73mi3G/bxEaGRjaqjU=;
        fh=ekoNgDLIecYIObb7h/n+1M88ZT5CcHgdYpSpadmv8pI=;
        b=LB936KD3gQaEoBnaHtlo6bszRFLBBMFJvgVATaoV/NYavlZE66vi2HGCt9kiaD91N4
         Bg+qr9Z1WJFmckOxO46RnN+wRXEereKjh60RcQZac0wTmeuZgIU4ofoLdZQ2EG7xZYlj
         V5TG8t1kDaWSSJ2EhTsmanEJSq5EP+9Azzbd+vPPopX6A/NArmHxIzV3ikbyDsuxRdjj
         Gk3T9Qfre/ZgeoeTO22zjhpfTYAWx1wVBQvcgUw6EsTa2kYp+bjLwt1q5wXBAgKz1peP
         yKeEC77XdWK73mjZdRKfXR3bWTIJKUCa8VEzS/71fVkH4QsTKDN4r28WCzEyZCeliKUV
         ZlQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789657707; x=1790262507; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBwimhxw7BcNYF6pIJGNqZmsQ73mi3G/bxEaGRjaqjU=;
        b=hL0egtNn1+npbrnJsshXZ7qaURN6+lioNzlSxdWUW6r8tOryNBcBAzwaLZ3/qM7X8P
         y5G/vs/oN0fbJfjSv8djmQRw5y82Xna1qedfj0UpSNMyFLBrzkP3p42Zlt7IgWl7Zner
         85VrBjdRR+9UKoC7qefdiH+QpupAYwDwSENHezXK+OtELsn8edRFv/qWJ/msaxspYgNv
         9mmOv7B17lIDjAS3P5hbj3K+2ICkoF8RQ8qAQqckGk5Uwotrc8cnnjMomGpQpf+6oplm
         SYUQX+fowDeY29fJ1Q3uzECvXOVRvnm89mmMDKp7Wl0sWNflC5GSsUAvrzb47cnZ5MYo
         ZLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657707; x=1790262507;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PBwimhxw7BcNYF6pIJGNqZmsQ73mi3G/bxEaGRjaqjU=;
        b=r/444HDgbmg4arMF7idnT5AdkIF5LeWom7Bgm5L4nl7SjQxUk1SdxwsKo3ifE4UQFD
         fsIjLgxlOIIhGd9eKfPO6DJazvdZoieWOlL5nuezXq2kXjWp666GLVtyDIP247wXqaeR
         eogjYSGuJ606eS9BZWcgeCpMGbWlWoaa/MSGDU623h7GY5brcFZpMTq2v2CzmeECDmSa
         PxYUmemDxdy1iwk5vssZ8fPwFs25LgfaN8w2dZSjBmQggWmOZj0Ul1ng5PVgj9Mynfgr
         YolwcW5OlOIv5fNAYY9MD4XPm7ICvw1MdpcxXVW5ruHO3NtJZLT+dMVgM0pM9Fy+bshL
         u/3w==
X-Forwarded-Encrypted: i=1; AKwUvBwOgd1BC0cqaTRSMlee3zDr0Mgc+suhxnM7SBUgbJrjw9u7G9M2ke9pgQkWOV4voKiEoiCFImZSTg==@vger.kernel.org
X-Gm-Message-State: AFuF++ldwwnU9tOL91s3SdqO0iSlNjb2hIc2Utqhu0meDA65xJevNj/L
	DFZMQO2Ul4tfiEh5rUlbPrVy6pyw9X3leVWNQDbBrt8/kD7W6eM8PxWZLjtgNA9liEptCYgwz61
	/Jr4eZDpT9NOp41YBaasv0fTrn5ByY6L/DmpKTlmObA==
X-Gm-Gg: AYBFou1aLzIpN1MOrgYprG3AZXWX1bOHqtVVZuEsXOn1YlM4wPZ4JaAv/RwCyTDwAV6
	5N1fI8XrWnq/pk4KekUdCMClEpu+OTDHvLuIqZBpbUv7uBAJAX79edEGOljMDgz/oCyatmZFxJp
	JJ2lHa4WAVkzREoBUJXh5uQ6BTMg/C+l6c1RKz5QNZ3PA/xX/G9nAvqyVG8KphUiyJJrC7n1xn0
	1aa3qqYXW6QEv3wYPnEUxBl503YFPWI952bqhNgiAwJyafUi3r8yihIC9xIfEKN2b5DuezOl3Nl
	GLWL9pfXRTHUpYtcEPnoizJebuvqhx+saqx19kBjfdOULVY6ASC2bHNVeuv1ncnP7mIXnjM7JJ6
	RS2u/ff8mmAb3
X-Received: by 2002:a17:907:3cd4:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c29e51cc690mr486783666b.3.1789657706744; Thu, 17 Sep 2026
 08:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916100116.701206-1-christian.loehle@arm.com>
 <20260916100116.701206-3-christian.loehle@arm.com> <CAKfTPtCAaACP8A=AKGO3PdhZtA9SRM6e3ym+5d=Qfp-VpDa38g@mail.gmail.com>
 <f3912746-90f8-46de-a690-a840afa4a1d1@arm.com>
In-Reply-To: <f3912746-90f8-46de-a690-a840afa4a1d1@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 Sep 2026 17:08:15 +0200
X-Gm-Features: AcwNN1UepS9H8J-Bx__-3vHGPLcD0Z6dVcwXht08n9bPIhFs2o7jwKFujrXfDt0
Message-ID: <CAKfTPtAexsLhEb3hEnWvhFo3Z0+CsN41WQ8gfW+waLvxJQrb+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path candidates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Beata Michalska <beata.michalska@arm.com>, 
	Elif Topuz <elif.topuz@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik <sh@gentwo.org>, 
	Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 16:22, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/17/26 15:08, Vincent Guittot wrote:
> > On Wed, 16 Sept 2026 at 12:01, Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> >> slow-path selectors can choose the same CPU before either task is enqueued.
> >>
> >> Use reservoir sampling in the tie branch, resetting the candidate count
> >> when a lower advertised exit latency is found. Use the per-CPU scheduler
> >> PRNG and reciprocal_scale() to avoid variable division or a second scan.
> >>
> >> This reduces deterministic convergence without reserving the chosen CPU.
> >>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ff5793bddc35..6836a8364440 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -24,6 +24,7 @@
> >>  #include <linux/mmap_lock.h>
> >>  #include <linux/hugetlb_inline.h>
> >>  #include <linux/jiffies.h>
> >> +#include <linux/math.h>
> >>  #include <linux/mm_api.h>
> >>  #include <linux/highmem.h>
> >>  #include <linux/hrtimer.h>
> >> @@ -8459,6 +8460,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
> >>  {
> >>         unsigned long load, min_load = ULONG_MAX;
> >>         unsigned int min_exit_latency = UINT_MAX;
> >> +       unsigned int nr_candidates = 0;
> >>         int least_loaded_cpu = this_cpu;
> >>         int shallowest_idle_cpu = -1;
> >>         int i;
> >> @@ -8482,9 +8484,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
> >>                         if (idle && idle->exit_latency < min_exit_latency) {
> >>                                 min_exit_latency = idle->exit_latency;
> >>                                 shallowest_idle_cpu = i;
> >> +                               nr_candidates = 1;
> >
> > You clear the number of candidate when you find a lower exit_latency
> > but !idle CPUs that have already been checked will be cleared whereas
> > they still get a chance if they are checked later.
> That is correct. Is this a problem?

I would say we should try to be consistent

> (Again, mirroring what upstream currently does, let's say exit_latency(CPU0)=100, exit_latency(CPU2)=1
> !idle at CPU3 trumps CPU2 (assuming recent idle_stamp), !idle at CPU1 doesn't trump CPU2, i.e.
> the inconsistency around !idle is already there?)

Fair enough but the idle_stamp was also in the party

> And I'm assuming we really don't wanna keep a cpumask of !idle CPUs, if anything we may just ignore
> them completely, given how unlikely it they are to be observed.

We must keep them when there is no cpuidle driver, i.e. until we find
a CPU with an idle state
