Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AE576EAF
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654154; cv=pass; b=IKGFShf0UMno/f41Q4/wbwLIeEE27970aIBgqPHB4ToDGVbTYXWw66dgyVTfNbiYhgDBmJuagwb1vS/zzO272fWE9i2HfS6kE/0v2SvoQKhhGS15G6z6hB0vfLoJY4s19fwvIzRQjL56VnD9jZyd/QCE35D6KoHzMPdNCTannC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654154; c=relaxed/simple;
	bh=0I6B89QE1lGTpfyUcvsPV7lAaYiJyveAKjUIGfshr3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZz8b4VLR9xkSi8BM5g8/hvMukYKHdriur1ma4+u8/6h2QL8hjJyw7XeXbcj2wNWQ5PlvolpriCMViyS/4FUgfROuN9JhGJaT0gjGpKHq1uuIO/4CQnFz0qGfoqM5I/vyO7mqh3yNV+B3W912DgY2xCmKQZwpgXT7FeILn1hcWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2BjDnJ7; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2BjDnJ7"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so127085666b.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 07:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789654139; cv=none;
        d=google.com; s=arc-20260327;
        b=ZuGKZsuevmqddevYlqV7vy1MEckDoJfWkuBm38Kj4kNwPkUTDdRq/q3cTdF9vT6w7v
         Z+chQcvDren0mDSiumzmb9xNVxc/a5ejukTgKpX6ujbW5b89IPrjnN9s7UKnXE3QpouJ
         WGNZlyZlcmeNJXerWtjVt3xiaOhaupeoD5lmbSLPTt+p2VBPodlqKn4IakGbYkrF2hWW
         R55ydm953tYOV8tCAAsksuu3TQMOoHP8SjpNCvveU1vv1U9ScQk7riWCAxKTsvfAa4c2
         /FI/lpW7txI+uYQWGi2OBvFG25cs1uqAvZyvP+bO6ajq3W7gr57WglAJPTIZNBLzPmTp
         90pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fuwZyOKS0xThCnh60yYa8+8i54h/f9HpMrDJGJMC0k8=;
        fh=q8zDGIyVjZj1gzXKl7j1oRFuXm6xbh6CgkkKQtCfTaA=;
        b=Vc9oo9v1O6+yUaXvFpvOuxtiao+6xP3GKKq/cADnojlx7hII16I3ppwjjmLsn8x71G
         cT/2FB9OjNVCnJZGBiZdwz3kCKFBwifApX5l7Nne0L20MzqAxRMUAuQNTEzNsEEBRORj
         WosdEqOiLM0tQ1KnQ2eW6o77rumOxrzEXsvANt7iSuvNu3aI38grIpybxSTSGlw0kFZZ
         Zpa+lReh8+yNpKurUAHkwLrlieM3WRx94sXQMtvtom/0Sk/Ij4eMWfQurp955IuxLPoC
         yHl6Z3gaB4bFKIa+yg1m/ncO+889ygpK8DMTbX9xxZgymsT5/7JYom4+ROdKBB4SoLfQ
         HQiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789654139; x=1790258939; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuwZyOKS0xThCnh60yYa8+8i54h/f9HpMrDJGJMC0k8=;
        b=L2BjDnJ7n95gtV6N+Ez7SMF7P5x39VkS4bHgtkcD61mp3Ull7zsGFCkl7Kbvm3Pdhl
         nyht6CEaml4C45xmBIOep508uSnuVzkGBAuCArXNePSxfTAXwvRZPYPM0qzO56cnK1+H
         CoRFLUMd3AG3MKsTQ/2Vj/AqqweZThpBqaLyA4Zkr4kWMoy6VlULSv0GV7o9i4NyG78z
         qLBYhEcHMhHIwpShnQ8+GGNDmn6ToZMC4azyY9aA3gZ28PoM5LPhQQFGU31fSuRSXAos
         ZzUr3BINoWJfn8OsdvH5l/VDOdKpPexcJoGvPnQ07NVpInZuXloFwJVrc8OYNBZdGLM/
         uhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789654139; x=1790258939;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fuwZyOKS0xThCnh60yYa8+8i54h/f9HpMrDJGJMC0k8=;
        b=pY52kdhk6c2e3f3rvs0D6QsoUTbRKIIxZcuGauSPZeaxnhAtpJcBsixdNRgM3OcR8t
         B+ktzm9big8qm76MUarKJDBE+2RhvydqwLafjxONqc4vlGGuGLqADNPdqKyQRiX6+b/M
         tP/fqDHvnAZAibVuYH73ZpoFZl2bWTx8Mij4NNUTZFTwZhZBJ2cdcqOhGcOKImmUSoXi
         zuBJAU2vaPVKcC4SvMn4q/Q3ZD4soWxxWjtwh3cMSwDnshlkdQjAgvUQ73jPDXMLXEPX
         FzoSrYdfF/mY/lM3kukq/HffLiVnoMnptnW3ZRLRDmSnBz7mQsVDpkfRgQYHF9M/AItQ
         ylVw==
X-Forwarded-Encrypted: i=1; AKwUvBxrtsc2kmD26aq1+vj7FzZ1t8LRnHJnOSDvdkVAklGlpNKnXaT+ph3Mnl0VYa2LUtnmKL6Bv281zw==@vger.kernel.org
X-Gm-Message-State: AFuF++kvZ8vvzLXoAvWd5uNGUzT3e9dluxEIXtENpUQs2zmGZZwenT1Q
	U/G1NKQQTcNYvwCipo/UjKkNcGzgtbNtO+YptTTnGGThzGzlTgUhAy4iT4Js7P+/IiaAMXuH35w
	3mS7RM96MpY257JONWk6b85I8/0nnL5SLpyEI/bimXA==
X-Gm-Gg: AYBFou0mCQdNJLbtl4I0dwQYBH8aKKwOQlMgLDKlELn8vhJwy4vaOlRbcrrmXxr0BIP
	GEjI/OAgq8tJFBTonhsfMxH0+eJnV0QRRaTNGdHj17oiTSDyjrb55UASYLsPzcSvD0IJFVs1UNS
	dzBMQvAyaVNYLLO+2E/yGhhIQOV+mRnxYgubL0YT1DcyeYo/i0/v3o7gxBCILD1Gmy9V/efeIV8
	1zxKbwClK41ikLetPfnCYklaSiR+k0P7/5QZUhha289c5NNgdvOFuEazjdHNu5QLRCLLTx/UXUs
	GJUCfvKcQMb59bSxTXceoXPfmnH1330AzlyBLvaFfpmtmiZpMbVzZWhjCWF5bOjHNOYYSWsOCSY
	A+ZTedz2GHNMg
X-Received: by 2002:a17:907:5c3:b0:c29:f5d5:5aa2 with SMTP id
 a640c23a62f3a-c29f5d56248mr258521666b.44.1789654138594; Thu, 17 Sep 2026
 07:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916100116.701206-1-christian.loehle@arm.com> <20260916100116.701206-3-christian.loehle@arm.com>
In-Reply-To: <20260916100116.701206-3-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 Sep 2026 16:08:47 +0200
X-Gm-Features: AcwNN1UJjmtR15ewJ-APy9nZbXkhGXHb95ciuePXHxxAELF263ovQ5vbCxkkXy4
Message-ID: <CAKfTPtCAaACP8A=AKGO3PdhZtA9SRM6e3ym+5d=Qfp-VpDa38g@mail.gmail.com>
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

On Wed, 16 Sept 2026 at 12:01, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> slow-path selectors can choose the same CPU before either task is enqueued.
>
> Use reservoir sampling in the tie branch, resetting the candidate count
> when a lower advertised exit latency is found. Use the per-CPU scheduler
> PRNG and reciprocal_scale() to avoid variable division or a second scan.
>
> This reduces deterministic convergence without reserving the chosen CPU.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/fair.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff5793bddc35..6836a8364440 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -24,6 +24,7 @@
>  #include <linux/mmap_lock.h>
>  #include <linux/hugetlb_inline.h>
>  #include <linux/jiffies.h>
> +#include <linux/math.h>
>  #include <linux/mm_api.h>
>  #include <linux/highmem.h>
>  #include <linux/hrtimer.h>
> @@ -8459,6 +8460,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>  {
>         unsigned long load, min_load = ULONG_MAX;
>         unsigned int min_exit_latency = UINT_MAX;
> +       unsigned int nr_candidates = 0;
>         int least_loaded_cpu = this_cpu;
>         int shallowest_idle_cpu = -1;
>         int i;
> @@ -8482,9 +8484,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                         if (idle && idle->exit_latency < min_exit_latency) {
>                                 min_exit_latency = idle->exit_latency;
>                                 shallowest_idle_cpu = i;
> +                               nr_candidates = 1;

You clear the number of candidate when you find a lower exit_latency
but !idle CPUs that have already been checked will be cleared whereas
they still get a chance if they are checked later.

> -                       } else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -                                  shallowest_idle_cpu == -1) {
> -                               shallowest_idle_cpu = i;
> +                       } else if (!idle || idle->exit_latency == min_exit_latency) {
> +                               nr_candidates++;
> +                               if (nr_candidates == 1 ||
> +                                   !reciprocal_scale(sched_rng(), nr_candidates))
> +                                       shallowest_idle_cpu = i;
>                         }
>                 } else if (shallowest_idle_cpu == -1) {
>                         load = cpu_load(cpu_rq(i));
> --
> 2.34.1
