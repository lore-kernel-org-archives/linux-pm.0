Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2452848A7
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488892; cv=none; b=puU4BAo5K+PgGS0wyxGlzDeVbFOlC0N4JuXLfD7SG/biVvICOm5BDqWWkVBJXgIWsPIL9YJlzSXmIvCTW+lZKCe9Dk/nc1PBJzy/8EhP4R2AQp14iY4Xby/E63c2VmTU4TD4z7fmBBkPXbG5OfnKDCjEoCQmLbRNi6csz2ki2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488892; c=relaxed/simple;
	bh=lxEtsCn1RkbUwzpAYUKTJr9MsFEuTYx5mL9gnoMcUM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzJrBr7P09edb7ARb5mJIZ48fZHFqRCOi56hpzFo5wuMinnAk+NTuzIqDZ3fUwitL4WF8uJOtR5bXKaZ4GHOfL5EICO32Fa23IphL4jN37SqKd54cZjGnlx0ZJclwis47tLyOfEVJbpF8EQK/rc6YJqx9xpY69WE8mHDLAdl+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvdOH7+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvdOH7+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD80C2BCB0
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488892;
	bh=lxEtsCn1RkbUwzpAYUKTJr9MsFEuTYx5mL9gnoMcUM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TvdOH7+ZZT21WfodjJPM7ASbaKZPvRXTWCSaLrFBIacPXCNHIaJOpC02WcjEc0uDm
	 KUmvqGHbaLi4IDvy8TzWSrShM0tpIadco0iBjNDUiGx2lWcflrk0kPQowQy1tiXHQ5
	 AKzOZMtI0Gss1qrzjx5TqmcNpIVH4NnHwJ6DNUs+WPSES4wYx0f/eUt7k3xQ2vCKEc
	 5GE4ZXpTkXYNQs3MrQescew2Iu4FnL+G4Lua1rjaF5vu8zFisqnjgOoU+8jh0n7To/
	 1398SITOuU4HO6PSmpAV7Q+6UzmUTJD+GFlVYCJCrWe6bZYs9JXmckIndRLgFtXtA9
	 6NrPTJJoFb/4g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-42321c8b8f5so1962789fac.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 08:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDcgur6u/XfkPjYTyTleWqPnn6duwh6GLO683b738xiFB9BMekGDfyyXAwm6C3mTIE2K8iqnMBAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPQLapAkVvX1FdZl75gsfqHcZ+42C/mBR+QdQnIxeS3u+FHot
	OcuVL8TcrLGrvuzfe16FS2KOyPYuQrl6bjuXjj/7x7gNvF+/hG5Lv2kgn6iiIDGpLGIZx4mibjd
	kqw+SvVHCn6vRGJ2Tc7MVjKmoKE6AP2E=
X-Received: by 2002:a05:6870:df43:b0:423:663:d598 with SMTP id
 586e51a60fabf-4230663d80dmr4710128fac.23.1775488891656; Mon, 06 Apr 2026
 08:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 17:21:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7z0oQTDLAA7wtCpF-33ZSw6wxEoL30eohDpBTofAGVw@mail.gmail.com>
X-Gm-Features: AQROBzDkqDRsnlRkVHQSEApLTNTXnXTNOYm8-WadK2SONqbFZRmX1tFShDuwqs0
Message-ID: <CAJZ5v0j7z0oQTDLAA7wtCpF-33ZSw6wxEoL30eohDpBTofAGVw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: governor: Fix race between sysfs store and dbs
 work handler
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, venkatesh.pallipadi@intel.com, 
	davej@redhat.com, trenn@suse.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:01=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> gov_update_cpu_data() resets per-CPU prev_cpu_idle and prev_cpu_nice
> for every CPU in the governed domain. It is called from sysfs store
> callbacks (e.g. ignore_nice_load_store) which run under
> attr_set->update_lock, held by the surrounding governor_store().
>
> Concurrently, dbs_work_handler() calls gov->gov_dbs_update() (which
> calls dbs_update()) under policy_dbs->update_mutex. dbs_update() both
> reads and writes the same prev_cpu_idle / prev_cpu_nice fields. The
> potential race path is:
>
> Path A (sysfs write, holds attr_set->update_lock only):
>
>   governor_store()
>     mutex_lock(&attr_set->update_lock)
>     ignore_nice_load_store()
>       dbs_data->ignore_nice_load =3D input
>       gov_update_cpu_data(dbs_data)
>         list_for_each_entry(policy_dbs, ...)
>           for_each_cpu(j, ...)
>             j_cdbs->prev_cpu_idle =3D get_cpu_idle_time(...)  /* write */
>             j_cdbs->prev_cpu_nice =3D kcpustat_field(...)     /* write */
>     mutex_unlock(&attr_set->update_lock)
>
> Path B (work queue, holds policy_dbs->update_mutex only):
>
>   dbs_work_handler()
>     mutex_lock(&policy_dbs->update_mutex)
>     gov->gov_dbs_update(policy)
>       dbs_update()
>         for_each_cpu(j, policy->cpus)
>           idle_time =3D cur - j_cdbs->prev_cpu_idle           /* read  */
>           j_cdbs->prev_cpu_idle =3D cur_idle_time             /* write */
>           idle_time +=3D cur_nice - j_cdbs->prev_cpu_nice     /* read  */
>           j_cdbs->prev_cpu_nice =3D cur_nice                  /* write */
>     mutex_unlock(&policy_dbs->update_mutex)
>
> Because attr_set->update_lock and policy_dbs->update_mutex are two
> completely independent locks, the two paths are not mutually exclusive.
> This results in a data race on cpu_dbs_info.prev_cpu_idle and
> cpu_dbs_info.prev_cpu_nice.
>
> Fix this by also acquiring policy_dbs->update_mutex in
> gov_update_cpu_data() for each policy, so that path A participates in
> the mutual exclusion already established by dbs_work_handler(). Also
> update the function comment to accurately reflect the two-level locking
> contract.
>
> The root of this race dates back to the original ondemand/conservative
> governors. Before commit ee88415caf73 ("[CPUFREQ] Cleanup locking in
> conservative governor") and commit 5a75c82828e7 ("[CPUFREQ] Cleanup
> locking in ondemand governor"), all accesses to prev_cpu_idle and
> prev_cpu_nice in cpufreq_governor_dbs() (path X), store_ignore_nice_load(=
)
> (path Y), and do_dbs_timer() (path Z) were serialised by the same
> dbs_mutex, so no race existed. Those two commits switched do_dbs_timer()
> from dbs_mutex to a per-policy/per-cpu timer_mutex to reduce lock
> contention, but left store_ignore_nice_load() still holding dbs_mutex.
> As a result, path Y (store) and path Z (do_dbs_timer) no longer shared a
> common lock, introducing a potential race on prev_cpu_idle/prev_cpu_nice
> between store_ignore_nice_load() and dbs_check_cpu().
>
> Commit 326c86deaed54a ("[CPUFREQ] Remove unneeded locks") then removed
> dbs_mutex from store_ignore_nice_load() entirely, introducing an
> additional potential race between store_ignore_nice_load() (path Y, now
> lockless) and cpufreq_governor_dbs() (path X, still holding dbs_mutex),
> while the race between path Y and path Z remained.
>
> Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governo=
r")
> Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
> Fixes: 326c86deaed54a ("[CPUFREQ] Remove unneeded locks")
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index 86f35e451914..56ef793362db 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -90,7 +90,8 @@ EXPORT_SYMBOL_GPL(sampling_rate_store);
>   * (that may be a single policy or a bunch of them if governor tunables =
are
>   * system-wide).
>   *
> - * Call under the @dbs_data mutex.
> + * Call under the @dbs_data->attr_set.update_lock. The per-policy
> + * update_mutex is acquired and released internally for each policy.
>   */
>  void gov_update_cpu_data(struct dbs_data *dbs_data)
>  {
> @@ -99,6 +100,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
>         list_for_each_entry(policy_dbs, &dbs_data->attr_set.policy_list, =
list) {
>                 unsigned int j;
>
> +               mutex_lock(&policy_dbs->update_mutex);
>                 for_each_cpu(j, policy_dbs->policy->cpus) {
>                         struct cpu_dbs_info *j_cdbs =3D &per_cpu(cpu_dbs,=
 j);
>
> @@ -107,6 +109,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
>                         if (dbs_data->ignore_nice_load)
>                                 j_cdbs->prev_cpu_nice =3D kcpustat_field(=
&kcpustat_cpu(j), CPUTIME_NICE, j);
>                 }
> +               mutex_unlock(&policy_dbs->update_mutex);
>         }
>  }
>  EXPORT_SYMBOL_GPL(gov_update_cpu_data);
> --

Please have a look at

https://sashiko.dev/#/patchset/20260406110113.3475920-1-zhongqiu.han%40oss.=
qualcomm.com

and let me know what you think.

Thanks!
