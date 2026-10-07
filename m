Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE213BF679;
	Wed,  7 Oct 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395727; cv=none; b=dMQPXH3jy95oPMX5dhRU8Mgyc8usqkN93OzzmJ+bD8GuI6Nv07dUfYwtceNhkp/zg9geGUw5x+6B7pODlclLYEDUmeLG9v1Pp2BjBoPPNOjGodTdswRvtf6J73L9GRFWP61MO0czKZfgdzO2ZBH2dpMaSIScw50dLYjjjsZJeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395727; c=relaxed/simple;
	bh=C9yfwdCFUFaflhWGnqJx++BjuGQaVBswaweZexH+PSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYrWoltCil8zbzP7nCAN4GXgGqX6U3rtNl+q1zJ9XFiKGBCfEZmS/IyDiPNf9clASEpAm5G7/W/1CC1gKv6/DsjVJ0JBYQrjD7Ih0/ZX1iFtKib76Yd9jDxoqVR8HC9g8TeyzBNiu3PGm9CiH9dV3FnSAjAaeU0y6y3ny4kdjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DU1MWTWI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DU1MWTWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791395726; x=1822931726;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=C9yfwdCFUFaflhWGnqJx++BjuGQaVBswaweZexH+PSs=;
  b=DU1MWTWIIxl8q2UDRcOmJZIiLPwkUnKiUg0CPnrQlD69RKXi4NBSKjOF
   wuHVyE1r7fON6yKv70wS6aIEAlM6pBAG/rraNEztaQq50lz7iNbJ565p4
   vlKuP4L3Hbo597ZqABzT+0Kwok1HcXuRgASngZ1N2PrwWJAwtq4AoZVEh
   q1M/auJFvIhmnVrA0+PhvJDl1FEE4qN2eY9NufsULl1E9/LLDfFHHBz63
   UCOWN/FzyOuzz9p//QwZQJ2HVtBAht9NVbhKj2AOMnsXUSXqV3+Gbvfsy
   0dOULaFc3brIEU0hWm7Ly62f8380WXGjMQ9KModjnCI0sBbe4B3vfe2mq
   w==;
X-CSE-ConnectionGUID: XvWPACqERG6Gfovhe7pEww==
X-CSE-MsgGUID: XNkHU5nKRYCcRfFA3PyMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="67305"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="67305"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:55:16 -0700
X-CSE-ConnectionGUID: fMvzl4HuTBa1zKTdtBZMvQ==
X-CSE-MsgGUID: CA2CNo/vT1u4VDB5k2ZQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285591577"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:55:15 -0700
Message-ID: <62547ac28298442a246abe0471647e36518a93cb.camel@linux.intel.com>
Subject: Re: [PATCH 11/18 v2] sched/fair: Support not wakeup case in
 select_idle_sibling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, 	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 lukasz.luba@arm.com, 	rafael@kernel.org, linux-pm@vger.kernel.org,
 tj@kernel.org, void@manifault.com, 	arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com
Date: Wed, 07 Oct 2026 10:55:15 -0700
In-Reply-To: <20261002154415.2270586-12-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
	 <20261002154415.2270586-12-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> With push callback mecanism, select_task_rq_fair can be called for a task
> that is already enqueued. Task into account this case when choosing idle
> CPU.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6ed3e5bb7fd6..38eb80dbd1a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7974,10 +7974,13 @@ static int choose_sched_idle_rq(struct rq *rq, st=
ruct task_struct *p)
>  	return sched_idle_rq(rq) && !task_has_idle_policy(p);
>  }
> =20
> +static int idle_cpu_without(int cpu, struct task_struct *p);
> +
>  static int choose_idle_cpu(int cpu, struct task_struct *p)
>  {
>  	return available_idle_cpu(cpu) ||
> -	       choose_sched_idle_rq(cpu_rq(cpu), p);
> +	       choose_sched_idle_rq(cpu_rq(cpu), p) ||
> +	       idle_cpu_without(cpu, p);
>  }
> =20
>  static void


Hi Vincent,

One concern I have is that many CPUs will try to push
their tasks onto the same idle CPU and causes over stacking.

idle_cpu_without() doesn't check nr_running. Its comment says:

         * rq->nr_running can't be used but an updated version without the
         * impact of p on cpu must be used instead. The updated nr_running
         * be computed and tested before calling idle_cpu_without().

and update_sg_wakeup_stats() does this:

        if (!nr_running && idle_cpu_without(i, p))

choose_idle_cpu() calls it without that test. So a CPU that runs its
idle task but already has a queued task is now idle for every caller:
the target, prev and recent_used_cpu checks, __select_idle_cpu(),
select_idle_smt() and select_idle_capacity(). This affects wakeups
too, not only pushes.

For a wakeup to an idle CPU, the wakelist usually sets ttwu_pending,
which idle_cpu_without() checks. A push enqueues the task directly, so
after a push the destination stays idle for everyone until it
schedules. If it wakes up from a deep idle state, this can take a
while, and other CPUs can push or wake their tasks onto it in the
meantime.

The fixup below removes p from nr_running when p is queued on the CPU,
and calls idle_cpu_without() only when nothing else is queued. The
tick case that this patch is for still works: p is the only task, so
its CPU is still idle without it.

It is build tested only.

Thanks,
Tim

---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3eb8a0170902..cb00f24a58fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7978,9 +7978,16 @@ static int idle_cpu_without(int cpu, struct task_str=
uct *p);

 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
+       struct rq *rq =3D cpu_rq(cpu);
+       unsigned int nr_running =3D rq->nr_running;
+
+       /* idle_cpu_without() needs nr_running without p */
+       if (task_cpu(p) =3D=3D cpu && task_on_rq_queued(p))
+               nr_running--;
+
        return available_idle_cpu(cpu) ||
-              choose_sched_idle_rq(cpu_rq(cpu), p) ||
-              idle_cpu_without(cpu, p);
+              choose_sched_idle_rq(rq, p) ||
+              (!nr_running && idle_cpu_without(cpu, p));
 }

 static void

