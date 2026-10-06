Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1038B133;
	Tue,  6 Oct 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325526; cv=none; b=Td8xtuqmDP8Xf7pkeL0wxb547qy2VsJSjtxNq1ErskFDpxd8+Va/Bq8PCtCTixDMfto8G4Iy4EskI582kmLrFu9JJI3jO3NxKtTigRsFZN/OYAK1H8vZQKnyGEUsFAmNa+GomHrHORn5QDYZN8U36QLYUZsBp19pWrtgjgPWAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325526; c=relaxed/simple;
	bh=MRUNbbGSRipNTyhpQmWoUw4X7Usb36nhRQGhXPen5ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5qLmBRPUWlOECq66qplhWZ+G2KigvWahEyjVfspUIwuBcC76a17ceouvcV6tvEFMh2D2dm7GINqlLTdFiXNYQtCs5aTFueA9TV4AsHr/o/P6ZWKoEhI2wWUN8lkgoyH3OV3VH8fcnJGdMOn6rGZOTSdlsURRR8vbxI3i45522U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCUvc7jF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCUvc7jF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791325524; x=1822861524;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MRUNbbGSRipNTyhpQmWoUw4X7Usb36nhRQGhXPen5ro=;
  b=aCUvc7jFrKdhADwWJSlpJwPYCDSB7NYvESseajenYOR3XoZJk59A2+wU
   pgrCz/s5+GeD5xtzQFaRXquCEX85Rg3XIfQ5ci1ENjQaEqzAkhPAVEEek
   VYXrepj/yWK4ovw8nrD596lyO9R58OjBHJCU0FmUf28Ujt9eili7zWa9I
   PN+fDmlXnNEgNhQUMJ4pFuu9owxZBZnwmpPkMsyipF4dJz5MNL/j1WJ0T
   AteQRfURPa/w19Ov5EqtQnxBXzNCxIAejhZ43uT+JF1/WCGck/CWpHRqO
   FNeblN19+34f9i5BJdx4xTeqRVobnPu82v1zRGgNyhnOsLZi4yAkkmHhl
   g==;
X-CSE-ConnectionGUID: Jt9rCt8xRBq5vIkbNyOuhg==
X-CSE-MsgGUID: AfeYurOmRjWLO/GCohjUpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102609366"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102609366"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:25:23 -0700
X-CSE-ConnectionGUID: D4W+FHbsQv6JOeI0em29Rg==
X-CSE-MsgGUID: kMpCA7U8TuG0ktOv6QJg7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280545973"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:25:24 -0700
Message-ID: <95c9b871ab66588afdf09d6ec9bac577c139b8d8.camel@linux.intel.com>
Subject: Re: [PATCH 06/18 v2] sched/fair: Prepare select_task_rq_fair() to
 be called for new cases
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
Date: Tue, 06 Oct 2026 15:25:23 -0700
In-Reply-To: <20261002154415.2270586-7-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
	 <20261002154415.2270586-7-vincent.guittot@linaro.org>
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
> Update select_task_rq_fair() to be called out of the 3 current cases whic=
h
> are :
> - wake up
> - exec
> - fork
>=20
> We wants to select a rq in some new cases like pushing a runnable task on=
 a
> better CPU than the local one. In such case, it's not a wakeup , nor an
> exec nor a fork. We make sure to not distrub these cases but still
> go through EAS and fast-path.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c |  2 +-
>  kernel/sched/fair.c | 57 ++++++++++++++++++++++++++-------------------
>  2 files changed, 34 insertions(+), 25 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f38cf5a37a8a..837dc74c9a8d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3618,7 +3618,7 @@ static int select_fallback_rq(int cpu, struct task_=
struct *p)
>  }
> =20
>  /*
> - * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
> + * The caller (fork, wakeup, push) owns p->pi_lock, ->cpus_ptr is stable=
.
>   */
>  static inline
>  int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19a0e67827f7..f12678850ce2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9800,46 +9800,55 @@ static int find_energy_efficient_cpu(struct task_=
struct *p, int prev_cpu)
>  }
> =20
>  /*
> - * select_task_rq_fair: Select target runqueue for the waking task in do=
mains
> - * that have the relevant SD flag set. In practice, this is SD_BALANCE_W=
AKE,
> - * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
> + * select_task_rq_fair: Select a target runqueue for the task.
> + * There are 2 ways to select the target runqueue:
> + * - The fast path which only looks for an idle CPU in the LLC or the sm=
allest
> + *   asymmetric domain (i.e. the lowest domain with all compute capaciti=
es).
> + * - The slow path which looks for the idlest CPU in the highest domain =
with
> + *   the relevant SD flag set.
>   *
> - * Balances load by selecting the idlest CPU in the idlest group, or und=
er
> - * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFI=
NE set.
> + * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU a=
nd no
> + * flag (Push) uses the fast path.
>   *
> - * Returns the target CPU number.
>   */
>  static int
> -select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flag=
s)
>  {
> -	int sync =3D (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> +	int sync =3D (select_flags & WF_SYNC) && !(current->flags & PF_EXITING)=
;
> +	int want_sibling =3D !(select_flags & (WF_EXEC | WF_FORK));
> +	int new_cpu, cpu =3D smp_processor_id();
>  	struct sched_domain *tmp, *sd =3D NULL;
> -	int cpu =3D smp_processor_id();
> -	int new_cpu =3D prev_cpu;
> -	int want_affine =3D 0;
>  	/* SD_flags and WF_flags share the first nibble */
> -	int sd_flag =3D wake_flags & 0xF;
> +	int sd_flag =3D select_flags & 0xF;
> +	int want_affine =3D 0;
> =20
>  	/*
> -	 * required for stable ->cpus_allowed
> +	 * Required for stable ->cpus_allowed
>  	 */
>  	lockdep_assert_held(&p->pi_lock);
> -	if (wake_flags & WF_TTWU) {
> +
> +	if (select_flags & WF_TTWU) {
>  		record_wakee(p);
> =20
> -		if ((wake_flags & WF_CURRENT_CPU) &&
> +		if ((select_flags & WF_CURRENT_CPU) &&
>  		    cpumask_test_cpu(cpu, p->cpus_ptr))
>  			return cpu;
> +	}
> =20
> -		if (!is_rd_overutilized(this_rq()->rd)) {
> -			new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
> -			if (new_cpu >=3D 0)
> -				return new_cpu;
> -			new_cpu =3D prev_cpu;
> -		}
> +	/*
> +	 * We don't want EAS to be called for exec or fork but it should be
> +	 * called for any other case such as wake up or push callback.
> +	 */
> +	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
> +		new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
> +		if (new_cpu >=3D 0)
> +			return new_cpu;
> +	}
> =20
> +	if (select_flags & WF_TTWU)
>  		want_affine =3D !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> -	}
> +
> +	new_cpu =3D prev_cpu;
> =20
>  	for_each_domain(cpu, tmp) {
>  		/*
> @@ -9871,8 +9880,8 @@ select_task_rq_fair(struct task_struct *p, int prev=
_cpu, int wake_flags)
>  		return sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
> =20
>  	/* Fast path */
> -	if (wake_flags & WF_TTWU)
> -		return select_idle_sibling(p, prev_cpu, new_cpu);
> +	if (want_sibling)
> +		new_cpu =3D select_idle_sibling(p, prev_cpu, new_cpu);

Hi Vincent,

With this change, a push also goes through select_idle_sibling(), and
select_idle_sibling() sets p->recent_used_cpu =3D prev on every call.

For a wakeup, prev is the CPU where the task ran last, and the old
value of the hint becomes a second candidate for the next wakeup. For
a push, prev is the CPU where the task is queued now. If the push
doesn't move the task, the hint becomes the current CPU. When the task
later sleeps and wakes up on this CPU, recent_used_cpu is equal to
prev, so the wakeup has no second candidate. Each push attempt that
fails does this again.

Perhaps something like the following fix below on top of the series. It
passes the select flags to select_idle_sibling() and
updates the hint only for WF_TTWU. When fair_push_task() moves the
task, it saves the source CPU as the hint, which is what the hint
holds after a wakeup migration.

Tim

---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd22731949c5..3eb8a0170902 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1381,7 +1381,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se)

 #include "pelt.h"

-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cp=
u);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cp=
u, int select_flags);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);

@@ -9072,7 +9072,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target=
)
+static int select_idle_sibling(struct task_struct *p, int prev, int target=
, int select_flags)
 {
        bool has_idle_core =3D false;
        struct sched_domain *sd;
@@ -9131,7 +9131,9 @@ static int select_idle_sibling(struct task_struct *p,=
 int prev, int target)

        /* Check a recently used CPU as a potential idle candidate: */
        recent_used_cpu =3D p->recent_used_cpu;
-       p->recent_used_cpu =3D prev;
+       /* A push only updates the hint when it moves the task */
+       if (select_flags & WF_TTWU)
+               p->recent_used_cpu =3D prev;
        if (recent_used_cpu !=3D prev &&
            recent_used_cpu !=3D target &&
            cpus_share_cache(recent_used_cpu, target) &&
@@ -10015,6 +10017,7 @@ static bool fair_push_task(struct rq *rq)

        deactivate_task(rq, next_task, 0);
        set_task_cpu(next_task, new_cpu);
+       next_task->recent_used_cpu =3D prev_cpu;
        raw_spin_rq_unlock(rq);

        raw_spin_rq_lock(new_rq);
@@ -10225,7 +10228,7 @@ select_task_rq_fair(struct task_struct *p, int prev=
_cpu, int select_flags)

        /* Fast path */
        if (want_sibling)
-               new_cpu =3D select_idle_sibling(p, prev_cpu, new_cpu);
+               new_cpu =3D select_idle_sibling(p, prev_cpu, new_cpu, selec=
t_flags);

        return new_cpu;
 }
