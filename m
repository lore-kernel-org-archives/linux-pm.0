Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107F49DB89
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529408; cv=none; b=PCRaROiSkFGIIKls0NdNnFjoa1dXHmH8w3SF4dg+6MZSJ2LwfblToDQ7sLn9YYn8oOcXzDv8kPS6CpqIuQYl2PRHE5snF51czGTAKP5StbIAo2O07ZYdc/YD+Hww/MjlJ2aYiz3/Xc99MG2r5vFU6sFSkoEflELwoHLmM6S0tFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529408; c=relaxed/simple;
	bh=W4Ndzilstd5/JnbceWDOOcQC3jDZWB6r3+ivWid2mSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USbMPy1yWW3VYafUScHQr/uCYcmQkKGYcLgZAjtHuy68bL0CY5wTjH4ggnuI8UWggpfmHwFwnpGkQ66vONuN9vuj6N29pC2f77Xfly0PaXfW+fTpR0oQD59Oet4vugNQVsvtdg48zrpysKNaKDlxelat9A/mGabD0I9HyXAgYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT5SIBY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT5SIBY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B311F00AC4
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529405;
	bh=GHhD0o6c57P19uLDETL/4WoApO08CmyDzLq8rF2xBIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BT5SIBY9m3pTFcStDXHpLvEc2Jwn5mO+yp0+x+Go0aaL1D2MOcqcsmbpi+jZ1M6iU
	 BNXLFnsYkiG1zhGFm36n2Xlt5/IWJZxKzYjxd+5Q7+XaglC7R8XXvtQ3ctYIn4KQK0
	 7bGhUK60az7/5jk67Jg0zX7MO0TAgQ0G1ke579g1jyLBXatjVa7lvtOFivHqblfnE0
	 rXfOqOzSA8mqcrLT66eDUDFjcc8XzylvXOTSeynvUOHbrHzg6SBa605S7HCsDciBKP
	 YdcGTT2f62yb/1Yd0kjh1HmbTfPGdCTEc7y6LolsamCo0wggSuC4vFeer1t40iHSJ5
	 uuQ1zSv6YSO1w==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39ca300db70so9785071fa.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 06:43:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfxFnOqGvjTOTznjMHfadzecQLWEeYyG5Q/wqSIOhNLz9laZwdwY/0Fv7qF3CtlFIoXyztcY2sog==@vger.kernel.org
X-Gm-Message-State: AFuF++nJIUc+NJGbEfGGIDADvP/SP9vgquLQ10DqyHTwPgrBZp6NCxIF
	0WVXY9Z6YMGctwvv0KhbEqmC83R+dLtD+EZhvbXxnVjnM3MDVEl6soozNjN22ypZ9MKdhzVwAfx
	MAScfyqGd/g4o/TMEenY2dypwVJ9lQkA=
X-Received: by 2002:a05:651c:1986:b0:3a1:f4e7:a813 with SMTP id
 38308e7fff4ca-3a37194ab55mr7963991fa.0.1788529404056; Fri, 04 Sep 2026
 06:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829164313.20905-1-sumeet4linux@gmail.com>
In-Reply-To: <20260829164313.20905-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:42:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iG_uL=QB2UC74KMwp4T4L8qLfp50JWQKO5B6Fpqy93yw@mail.gmail.com>
X-Gm-Features: AcwNN1XV9s7Rd3JIzHFLdAkEkYW2fcWV8nVNLs9Hmn8ueL86f8op-i7yeAdgByc
Message-ID: <CAJZ5v0iG_uL=QB2UC74KMwp4T4L8qLfp50JWQKO5B6Fpqy93yw@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix rapl_packages list corruption
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,

Can you please have a look at the patch below and let me know what you thin=
k?

On Sat, Aug 29, 2026 at 6:43=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> The rapl_packages list was previously documented as being guarded by the
> CPU hotplug lock (cpus_read_lock()). However, cpus_read_lock() is a
> reader-writer semaphore taken for shared read access. This provides zero
> mutual exclusion between multiple concurrent callers.
>
> Because auxiliary device probes (such as intel_rapl_tpmi_probe) can
> execute concurrently on different CPUs, multiple packages can race on
> list operations (list_add and list_del) inside
> rapl_add_package_cpuslocked() and rapl_remove_package_cpuslocked(),
> leading to list corruption.
>
> Introduce a dedicated rapl_packages_lock mutex to protect all additions,
> removals and iterations of the rapl_packages list.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 29 ++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 70cab5f08bc6..e544629dbe30 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -175,7 +175,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd,
>                            enum unit_type type, u64 value, int to_raw);
>  static void package_power_limit_irq_save(struct rapl_package *rp);
>
> -static LIST_HEAD(rapl_packages);       /* guarded by CPU hotplug lock */
> +static DEFINE_MUTEX(rapl_packages_lock);
> +static LIST_HEAD(rapl_packages);       /* guarded by rapl_packages_lock =
*/
>
>  static const char *const rapl_domain_names[] =3D {
>         "package",
> @@ -1360,12 +1361,14 @@ static int rapl_pmu_event_init(struct perf_event =
*event)
>                 return -EINVAL;
>
>         /* Find out which Package the event belongs to */
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(pos, &rapl_packages, plist) {
>                 if (is_rp_pmu_cpu(pos, event->cpu)) {
>                         rp =3D pos;
>                         break;
>                 }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         if (!rp)
>                 return -ENODEV;
>
> @@ -1445,9 +1448,11 @@ static ssize_t cpumask_show(struct device *dev,
>         cpumask_clear(cpu_mask);
>
>         /* Choose a cpu for each RAPL Package */
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 set_pmu_cpumask(rp, cpu_mask);
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>
>         ret =3D sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
> @@ -1655,11 +1660,15 @@ void rapl_package_remove_pmu_locked(struct rapl_p=
ackage *rp)
>         if (!rp->has_pmu)
>                 return;
>
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(pos, &rapl_packages, plist) {
>                 /* PMU is still needed */
> -               if (pos->has_pmu && pos !=3D rp)
> +               if (pos->has_pmu && pos !=3D rp) {
> +                       mutex_unlock(&rapl_packages_lock);
>                         return;
> +               }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>
>         if (rapl_pmu.registered)
>                 perf_pmu_unregister(&rapl_pmu.pmu);
> @@ -1704,7 +1713,9 @@ void rapl_remove_package_cpuslocked(struct rapl_pac=
kage *rp)
>         /* do parent zone last */
>         powercap_unregister_zone(rp->priv->control_type,
>                                  &rd_package->power_zone);
> +       mutex_lock(&rapl_packages_lock);
>         list_del(&rp->plist);
> +       mutex_unlock(&rapl_packages_lock);
>         kfree(rp);
>  }
>  EXPORT_SYMBOL_NS_GPL(rapl_remove_package_cpuslocked, "INTEL_RAPL");
> @@ -1749,11 +1760,15 @@ struct rapl_package *rapl_find_package_domain_cpu=
slocked(int id, struct rapl_if_
>         else
>                 uid =3D id;
>
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
> -               if (rp->id =3D=3D uid
> -                   && rp->priv->control_type =3D=3D priv->control_type)
> +               if (rp->id =3D=3D uid &&
> +                   rp->priv->control_type =3D=3D priv->control_type) {
> +                       mutex_unlock(&rapl_packages_lock);
>                         return rp;
> +               }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>
>         return NULL;
>  }
> @@ -1810,7 +1825,9 @@ struct rapl_package *rapl_add_package_cpuslocked(in=
t id, struct rapl_if_priv *pr
>         ret =3D rapl_package_register_powercap(rp);
>         if (!ret) {
>                 INIT_LIST_HEAD(&rp->plist);
> +               mutex_lock(&rapl_packages_lock);
>                 list_add(&rp->plist, &rapl_packages);
> +               mutex_unlock(&rapl_packages_lock);
>                 return rp;
>         }
>
> @@ -1835,6 +1852,7 @@ static void power_limit_state_save(void)
>         int ret, i;
>
>         cpus_read_lock();
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1846,6 +1864,7 @@ static void power_limit_state_save(void)
>                                 rd->rpl[i].last_power_limit =3D 0;
>                 }
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>  }
>
> @@ -1856,6 +1875,7 @@ static void power_limit_state_restore(void)
>         int i;
>
>         cpus_read_lock();
> +       mutex_lock(&rapl_packages_lock);
>         list_for_each_entry(rp, &rapl_packages, plist) {
>                 if (!rp->power_zone)
>                         continue;
> @@ -1865,6 +1885,7 @@ static void power_limit_state_restore(void)
>                                 rapl_write_pl_data(rd, i, PL_LIMIT,
>                                                rd->rpl[i].last_power_limi=
t);
>         }
> +       mutex_unlock(&rapl_packages_lock);
>         cpus_read_unlock();
>  }
>
> --
> 2.43.0
>
