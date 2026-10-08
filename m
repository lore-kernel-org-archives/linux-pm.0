Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146E3CB8E5;
	Thu,  8 Oct 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791499995; cv=none; b=iRJC9+mbFIZUIYrT3HiEMriJ7Su/3uBRQOXdKYHrI8ZnGZ9Z03lI9zXWyaWetW3fjeRAoZHWOa+I9iF7E9BVlMAkucLlYdVdTjghvDR6OJcIT8pYKvipsK3C8nC8x7uyvbC7d9S7Z0Ys8RPdfvmgkCShI8Nv7smihieab6QwCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791499995; c=relaxed/simple;
	bh=w19qijWatAGy00RLU4Fjp6Ck0KIkM5bUBb4GG829UWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJp5ZTrehLg17Q5p7LHlXZplNhGVc8rju9PTK7CLLJhfV1OL2LmPrRYZbyCQETR3PWExfAYMdSo567z78GGghsQJJ0E/NtqRAeSoBO9NauyR53lxzMxGKNTY2H5oXjnYy+9J7TFL5lhLWARRyO1O7h+G+CqjY8p6dmD/59ebsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwsHGOOv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwsHGOOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791499994; x=1823035994;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w19qijWatAGy00RLU4Fjp6Ck0KIkM5bUBb4GG829UWg=;
  b=dwsHGOOvNiOJRGeATniOsQokB8zF+4ENnfg1YVaiDf+9z8tLtE6atozg
   oKvtWAFCyOAVHoypQ/nqQF8s4f0HmiFo2EDneMbMNhohS4IYrcQmkbbMk
   Yazl56bmxe/w+OKKDxAt9lxClH82D3rAfbZqOtGK6wYB6OuJNVkc0R4T4
   iksZdRz9aSvKaUAb95d/zCs6n4f7DKj3oV/StSqDf6hjnkX7dCo6Z4DhR
   1MdiDxlSvZ0endQRKqwqZaGMRJqNe3qtpLS96A/EVtRp3JsA9mm3rRDCu
   OlNh4rpeHZw5uHC/E1eHZCXjZhzvTFm9I46YhHKwSTbBWjI8ufqpdGhGv
   Q==;
X-CSE-ConnectionGUID: mWhHu/3OSG2GDf84+1wVzw==
X-CSE-MsgGUID: BSQyH+m+RMq7WolFxs8v4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="176394"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="176394"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 15:53:13 -0700
X-CSE-ConnectionGUID: uBz25blqSKOwhlgirliRvQ==
X-CSE-MsgGUID: W+Z+CTP6Q9S5xcV96HjisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="608645"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 15:53:13 -0700
Message-ID: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
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
Date: Thu, 08 Oct 2026 15:53:12 -0700
In-Reply-To: <20261002154415.2270586-19-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
	 <20261002154415.2270586-19-vincent.guittot@linaro.org>
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
> When the cost is the same, take into account the slice of a task to try t=
o
> select a CPU where is will run first.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 94554f165f42..d60bb6db4ce9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9598,8 +9598,17 @@ static int check_cpu_with_task(struct task_struct =
*p, int cpu)
>   */
>  static bool update_best_cpu(struct energy_cpu_stat *target,
>  			    struct energy_cpu_stat *min,
> -			    int prev, struct sched_domain *sd)
> +			    int prev, struct sched_domain *sd,
> +			    struct task_struct *p)
>  {
> +	unsigned long task_slice =3D p->se.slice;
> +
> +	/*  Select the one where you can run first */
> +	if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> +	    task_slice >=3D get_rq_min_slice(cpu_rq(min->cpu)))
> +		return true;
> +
> +	/* Favor previous CPU */
>  	if (target->cpu =3D=3D prev)
>  		return true;

Hi Vincent,

The slice check above comes before "Favor previous CPU", so I read the inte=
nt
as: the CPU where the task can run first wins, even
against prev_cpu. But the slice check can fail for prev CPU
and we can skip to "Favor previous CPU" and pick prev CPU, even
though the task can run on min CPU first but not
necessarily on prev CPU first.

Take an idle CPU X and a busy prev_cpu. Any task can
run first on X, because an empty rq has min_slice =3D=3D ULONG_MAX:

- prev_cpu scanned first: when X is the target, the slice check
  selects X.
- X scanned first: when prev_cpu is the target, the slice check fails,
  and "Favor previous CPU" then selects prev_cpu.

In the second case the task is stacked on the busy prev_cpu even though
it may not run first there.

Perhaps something like the following is better.

---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a47c6521a411..3fe305d690eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9830,11 +9830,15 @@ static bool update_best_cpu(struct energy_cpu_stat =
*target,
                            struct task_struct *p)
 {
        unsigned long task_slice =3D p->se.slice;
+       bool target_first =3D task_slice < get_rq_min_slice(cpu_rq(target->=
cpu));
+       bool min_first =3D task_slice < get_rq_min_slice(cpu_rq(min->cpu));

-       /*  Select the one where you can run first */
-       if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
-           task_slice >=3D get_rq_min_slice(cpu_rq(min->cpu)))
-               return true;
+       /*
+        * Select the one where you can run first. Check both ways, or the
+        * result depends on the order of the CPUs in the PD.
+        */
+       if (target_first !=3D min_first)
+               return target_first;

        /* Favor previous CPU */
        if (target->cpu =3D=3D prev)


Tim

>  	if (min->cpu =3D=3D prev)
> @@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_st=
ruct *p, int prev_cpu)
>  			 */
>  			if (target_perf < min_stat.min_perf)
>  				find_pd_cost(pd->em_pd, target_perf, &target_stat);
> -			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> +			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
>  				continue;
> =20
>  			/* Save the new most efficient CPU of the PD */
