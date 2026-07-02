Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D810785
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018093; cv=none; b=ZTGZ1ApXBnffUXXiZRV+3bB+DN6LKEPJ76/AiR2MA5ojuc8sISdeYhSshLBxTJDv0t/bW3TZnbeU+tZ69SFHjHq9xf+M1/FANFk63UoiNZO88BRuwiHg96Q8pf+jojNg/Vf9HR2lmhRCRbcLhLVdbFtR3gvZkzOBNfM8R6ngz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018093; c=relaxed/simple;
	bh=raUo+CGpWrD67s/afmyf9SkDsqorM7yqCwPQdnHoa6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpogKDbV2JWbMDRNOOmktN85HZVcLzI6p394TBgI9Z8Uf3wirjtpyBs31dc2Nas06YerQKL1NS/u1wt2Zt4D1P8G4lvz1i52jp8zOwbU2EFJtmfody4QPDDc5LXubrElggtejwPgLNELdXJIdKpSPVHvr6DW5ZAAzBqibYZf2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgf4F1rX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgf4F1rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266AD1F01558
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783018092;
	bh=BOSDrMobB0ZVHldvBgJMtIG2Yo9lUzWbeajnzMUjwWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jgf4F1rXBmXB3IlDNjmjHmBkJnalYubKskpOuxf7GVMIP7kub2x/LHPZNXSv4hKQV
	 LYPCW/IWn9aZy1QDlvux0AG/JuZUYSgu3hnDDPMGBHdiXdSfZfhh+6eGegrZ9u2d96
	 //hH5t7KUZjGeq/IxDQGHJFyJFklo36H0QvmlkJv8MI44lmnMpVxtJ/C7xEhvFTcnU
	 ZjOO2b/G1MGbS68Lg9AValFwpRcKFZODFpXgMrj5BrC5GtN9Qg1tpG8tNaN9QBaY2H
	 S3z1R8RHmp/hwC0QwqfOipA/mydQzJnL2MT35lpjru19g7B1uJ6Z6VxhzQqPzBVUzs
	 MRkehqNfbKjRQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec5675c46so2191073e87.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 11:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqlFzCKgx7qB8ONkELOn624pfIHAIGXajiGddZCJkeBY9C+/6FLGNcY/vkeOdXOCyuPnLJfxX4Y9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqe98RgAJktIggifJbQo5INnUYrXrPJhENI+LXJwqnnqdor89D
	Fp0D4ryCyE8kXHltjBSekFwjX2gVj91/R8FjbVU0y/ijQ37OKto2agETcGBsM5eS1f3qQcdVaYX
	JxuidBdY1A0PYEZgNuSdGF4Jp4rkkrd8=
X-Received: by 2002:a05:6512:290a:b0:5ae:b887:19a with SMTP id
 2adb3069b0e04-5aec7435728mr1365955e87.64.1783018090521; Thu, 02 Jul 2026
 11:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
In-Reply-To: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 20:47:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
X-Gm-Features: AVVi8CedlYXA0cjFr29OOGiAldizVnflJnoGqgjlKD8GSDj2RqBcLRpqvDs1bNk
Message-ID: <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after f4c31b07b136
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	christian.loehle@arm.com, frederic@kernel.org, linux-pm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 2, 2026 at 6:30=E2=80=AFPM Joseph Salisbury
<joseph.salisbury@oracle.com> wrote:
>
> Hi Rafael,
>
> We are seeing a reproducible MySQL Sysbench threads regression.  A
> bisect indicated the following commit as the first bad commit:
> f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases=
")
>
> The regression was found in Oracle kernel performance testing on OCI VM
> shapes:
>
> VM Details:
> * VM.Standard2.1:
>        x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB RAM
>
>   * VM.Standard.A1.Flex.2:
>        Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 GB RAM
>
>
> The ResultsDB runs show the regression in the Sysbench threads metric:
>
>    - VM.Standard2.1:       333 -> 236  (-29.1%)
>    - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)
>
> A test kernel was built with f4c31b07b136 reverted and the performance
> regression was recovered.
>
>  From the code, it is possible the regression is due to the new
> previous-wakeup heuristic in the special idle cases.  Before the commit:
>
>    - no cpuidle driver:
>        tick_nohz_idle_stop_tick()
>        default_idle_call()
>
>    - one idle state:
>        tick_nohz_idle_retain_tick()
>        cpuidle state 0

I think that this is your case and the tick stops for you sometimes
now while it had never stopped before.

Can you confirm?

Overall, it would be good to know the idle state lists for both the VM
and the host.

> After the commit, both paths use:
>
>    idle_call_stop_or_retain_tick(got_tick)
>
> Here, got_tick is true if the CPU was woken from the previous idle-loop
> iteration by the scheduler tick, and false otherwise. On this
> workload/platform combination, using that previous wakeup source to
> decide whether to stop or retain the tick appears to change NOHZ
> behavior enough to regress this wakeup-heavy threaded workload.
>
> Do you have any thoughts on whether this is an expected tradeoff of the
> new heuristic,

For the second case, yes.  It is expected that stopping the tick more
often may cause performance to drop.

> or whether the special cases need a narrower condition?

Let's first identify the case this happens in.

> For our stable kernels, the immediate candidate fix is to revert the
> backport, but before doing that I wanted to ask whether upstream would
> prefer a targeted adjustment.
>
> I can collect additional data if useful, for example cpuidle
> driver/state information, timer interrupt counts, idle residency, perf
> stat, or scheduler trace data from the affected OCI shapes.

So instead of reverting the commit, please try the appended change
(modulo gmail-induced whitespace breakage).

---
 kernel/sched/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -250,7 +250,7 @@ static void cpuidle_idle_call(bool stop_
          */
         cpuidle_reflect(dev, entered_state);
     } else {
-        idle_call_stop_or_retain_tick(stop_tick);
+        idle_call_stop_or_retain_tick(false);

         /*
          * If there is only a single idle state (or none), there is
