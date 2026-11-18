Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014177;
	b=bClQQqxLWWGGj44XRXxi5o/esRhWu5knOd48Dgm7uSbcJrRfjrZUW/zZarviBjYV4BNE
	 pPmdweHyLxHv2/cS/bss7ZQ1T2T3RtBamg6/gxPl5ZdDQndkCqZWYczSoS5ZAKWoQLAiS
	 uWIkLO6YOmLL51sVrbwZU3F+ny9aBKVZf+z7f5hTrUPuU9jOOTrl0/6Qhbb51hGuJ80pE
	 Ua1ed7968942kDNBBAbrXtlE2fPhrWiwNtZQzJ3JTChHHZEdBuBQq1LVeDulflvsFKZwO
	 fMXdgIunZCzenDBTxXBq7w73Mo93swRduMcMO1Tm+Ha1gRGEqzazUba6wWUwgG+auTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014177;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XO0aAzWDhIW2AbP/uOOiKlVOm5Pa+x2D19tm3r0Y5QQ=;
	b=dmZaJkvibheL93SBSWx3XSmAxYu3ZpcrO+TXOKsbl/qvt64uFXwHaevTBCzazbZGgMM9
	 BwH7YF6AQ2nGs/20B72LS0qGNinXg3h+5VjxNyrBukX/UNTURwWczRis6yjZz06j/sEN+
	 5vTKs40N9zIznOiWsRHW4/3ItMWaln7pf7/lrds5gcawnoWD929t7RW47zAxk5neXq+zK
	 GrXk//+Np3z1AUfi7TfxBIPddmX7MUo2Fb7WK7un3Mge8vwjkQMe0J0PhGsPCud2llIXf
	 qLM0/L1VQqnoYQeNRgarRYricBMyRqw+sdpifncbnkarw2ALslsliYiPAGAgX7NVL2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d05aBcLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90E606A32C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d05aBcLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8571F000C9
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014176;
	bh=XO0aAzWDhIW2AbP/uOOiKlVOm5Pa+x2D19tm3r0Y5QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d05aBcLC09Vd6WvveW9lAuA+CRjxYxy86N92Fb2Ghd+Gj20hlPVtHb24o0MAwz2T7
	 8zu5pudyn9wY0iOx4iii5Gq1Ps34LJQP5jdkSzpfHxDl4V8U4LDrgmu4LJlcK++2uI
	 ojhT/iIFDMGboJ8c5hIM281Hz4uoQPyJWhSHrW90bAOyDtwr3uL9XQzdtyAddYrHvv
	 tRzxnKAl5ITfw33UL37gXJ093uXi5mMQKW9eoaP8Rr1BnKmI3k0rnCmaiL1TYRd2tW
	 hiXMGGpfHhXNVvzV5ht58IwXZM6/pAg4Inw1RWYPJRciaO6+1el+f8pg3D7baDexmg
	 CVdnVOGSr4p9w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso721962e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:02:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGvNkvfxnncZgVgJ1QhpxZm3mJhErGW6jEgnZzeDnSoU/g4u1Dgyl7JsZjNLs8JA1/lp3HDVNfjHw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pJ7Tta3mTdxC61NO+Q8jxXtYR2QB+ZzGzSJk3I9ecGuQGYCoD
	p8/S1usjE9uyEgfdHq0n9oIpAbflg3YcHU1sJ1GUk+piNp95lB24FG4wCOxj0ctrFIEem3AMo5b
	KscOqH4e553k+7nyUqmcjS2VOnZtQouo=
X-Received: by 2002:a05:6512:8346:b0:5c1:acf1:337c with SMTP id
 2adb3069b0e04-5c1acf13427mr571815e87.36.1795014175093; Wed, 18 Nov 2026
 07:02:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6065833.DvuYhMxLoT@rafael.j.wysocki> <4796894.LvFx2qVVIh@rafael.j.wysocki>
 <efcb1647-46fd-442a-bbda-283560d9df53@intel.com>
In-Reply-To: <efcb1647-46fd-442a-bbda-283560d9df53@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 18 Nov 2026 16:02:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htcKjiWbDW-Oxn1qXAYX8myfyWFxkaxnMTaS0hYC4CCQ@mail.gmail.com>
X-Gm-Features: AclHuK-pkj8aiMuk8sSym9Lz5BFHtcdWaN92Z8KsI9AbvHIcSFTU3URo6er5lpw
Message-ID: <CAJZ5v0htcKjiWbDW-Oxn1qXAYX8myfyWFxkaxnMTaS0hYC4CCQ@mail.gmail.com>
Subject: Re: [REGRESSION: [PATCH v2 1/3] cpufreq: Improve suspend-resume synchronization
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, ravitejax.veesam@intel.com
Content-Type: multipart/mixed; boundary="00000000000046276706608e4ee7"

--00000000000046276706608e4ee7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:05=E2=80=AFPM Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
>
> Hello Rafael,
>
> On 11/4/2026 1:15 AM, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The suspend-resume synchronization in the cpufreq core is not perfect
> > because the global cpufreq_suspended variable is set at the end of
> > cpufreq_suspend() after stopping governors for all of the active
> > policies, so the governor .limits() callback may run via
> > cpufreq_governor_limits() after stopping the governor and before
> > setting cpufreq_suspended which is questionable.  Likewise, the
> > governor .limits() callback may run between clearing cpufreq_suspended
> > in cpufreq_resume() and starting the governor.
> >
> > Address this by adding a per-policy "suspended" flag that is always
> > read under the policy rwsem and is updated under it when the governor
> > is stopped in cpufreq_suspend() and when the governor is restarted in
> > cpufreq_resume().
> >
> > Also make cpufreq_resume() use the cpus_read_lock guard to reflect
> > what is done in cpufreq_suspend() and call cpufreq_exit_governor() for
> > policies that were suspended during a system suspend transition and
> > are inactive during the subsequent system resume (to avoid leaking an
> > inactive policy with a stopped governor that has not exited yet).
> >
>
> This seems to be causing regression in our CI [1] (affecting dg1 and
> dg2). We could not revert the patch cleanly but resetting to its parent
> heals the issue.
>
> <4> [510.751891] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4> [510.751907] WARNING: possible circular locking dependency detected
> <4> [510.751925] 7.4.0-rc3-CI_DRM_19546-gfb078d17b966+ #1 Tainted: G S
> U       L
> <4> [510.751946] ------------------------------------------------------
> <4> [510.751962] rtcwake/4256 is trying to acquire lock:
> <4> [510.751977] ffffffff83ce0f40
> (intel_pstate_driver_lock){+.+.}-{3:3}, at: set_power_ctl_ee_state+0x1a/0=
x90
> <4> [510.752022]
> but task is already holding lock:
> <4> [510.752038] ffffffff83886890 (cpu_hotplug_lock){++++}-{0:0}, at:
> cpufreq_resume+0x23/0x250
> <4> [510.752074]
> which lock already depends on the new lock.
> <4> [510.752094]
> the existing dependency chain (in reverse order) is:
> <4> [510.752112]
> -> #1 (cpu_hotplug_lock){++++}-{0:0}:
> <4> [510.752137]        cpus_read_lock+0x3c/0x100
> <4> [510.752157]        cpufreq_register_driver+0xca/0x380
> <4> [510.752175]        intel_pstate_register_driver+0x9e/0x1d0
> <4> [510.752192]        intel_pstate_init+0x3e3/0xb30
> <4> [510.752211]        do_one_initcall+0x59/0x3d0
> <4> [510.752229]        kernel_init_freeable+0x3dc/0x6b0
> <4> [510.752249]        kernel_init+0x20/0x210
> <4> [510.752264]        ret_from_fork+0x3bf/0x470
> <4> [510.752282]        ret_from_fork_asm+0x1a/0x30
> <4> [510.752299]
> -> #0 (intel_pstate_driver_lock){+.+.}-{3:3}:
> <4> [510.752325]        __lock_acquire+0x1700/0x29c0
> <4> [510.752341]        lock_acquire+0xd9/0x2f0
> <4> [510.752355]        __mutex_lock+0xae/0x1030
> <4> [510.752372]        mutex_lock_nested+0x1b/0x30
> <4> [510.752390]        set_power_ctl_ee_state+0x1a/0x90
> <4> [510.752409]        intel_pstate_resume+0x109/0x110
> <4> [510.752428]        cpufreq_resume+0x153/0x250
> <4> [510.752445]        dpm_resume+0x1f1/0x390
> <4> [510.752459]        dpm_resume_end+0x11/0x30
> <4> [510.752474]        suspend_devices_and_enter+0x372/0xcb0
> <4> [510.752491]        pm_suspend+0x372/0x840
> <4> [510.752506]        state_store+0x6e/0xe0
> <4> [510.752523]        kobj_attr_store+0x12/0x40
> <4> [510.752541]        sysfs_kf_write+0x4d/0x80
> <4> [510.752559]        kernfs_fop_write_iter+0x193/0x240
> <4> [510.752576]        vfs_write+0x285/0x530
> <4> [510.752591]        ksys_write+0x6f/0xf0
> <4> [510.752606]        __x64_sys_write+0x19/0x30
> <4> [510.752622]        x64_sys_call+0x1285/0x27e0
> <4> [510.752637]        do_syscall_64+0xec/0x680
> <4> [510.752654]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Could you please check why the patch causes this regression and provide
> a fix if necessary?

That's because set_power_ctl_ee_state() acquires
intel_pstate_driver_lock which is held around cpu_hotplug_lock during
driver mode changes, so adding cpu_hotplug_lock around
intel_pstate_resume(), which calls set_power_ctl_ee_state(), causes
lockdep to complain.  Note that the deadlock is not real, but
set_power_ctl_ee_state() need not use that particular lock either
AFAICS.

The attached patch should address this.

> [1]
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_19546/shard-dg1-14/igt@i9=
15_suspend@basic-s2idle-without-i915.html
>
> --Bisect Logs--
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [cfe67bbcfc37474cbb4482d750d4fba34bbc5a24] drm-tip:
> 2026y-11m-17d-05h-12m-00s UTC integration manifest
> git bisect bad cfe67bbcfc37474cbb4482d750d4fba34bbc5a24
> # status: waiting for good commit(s), bad commit known
> # good: [39e407b553ec15d4a233b651531ad431ed7542be] drm/sun4i: dw-hdmi:
> Deinit PHY in bind error path
> git bisect good 39e407b553ec15d4a233b651531ad431ed7542be
> # bad: [715f145f6204363a50853eb15719dc860db0bc01] drm/i915/dsb: Realign
> GOSUB only for QW slots 6 and 7
> git bisect bad 715f145f6204363a50853eb15719dc860db0bc01
> # bad: [7e1392a42ea288d70a266f6553fe06f57f8647ea] Merge tag
> 'net-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect bad 7e1392a42ea288d70a266f6553fe06f57f8647ea
> # good: [0359338fd8cf1a2dc001d0cd69c331c17decee88] af_unix: Inherit
> SO_INQ in unix_stream_connect()
> git bisect good 0359338fd8cf1a2dc001d0cd69c331c17decee88
> # good: [79eb6679ef6a0d5ea68da53a8321fb1dc72299b9] Merge tag
> 'loongarch-fixes-7.4-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> git bisect good 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
> # bad: [baa6744dc939a927e2c94e5f20aff01ac538aef1] Merge tag
> 'acpi-7.4-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad baa6744dc939a927e2c94e5f20aff01ac538aef1
> # good: [2cca8a6f6ae690755862f5b633125119dcf6bd0c] Merge patch series
> "ns: fixes identifier fixes"
> git bisect good 2cca8a6f6ae690755862f5b633125119dcf6bd0c
> # bad: [df42809bd599109660bd3f95e2e22330c80993df] Merge branches
> 'pm-cpufreq' and 'pm-runtime'
> git bisect bad df42809bd599109660bd3f95e2e22330c80993df
> # bad: [6bc092a0fc4d331a4adbbb664078af149c580834] cpufreq: acpi-cpufreq:
> fix P-state index mismatch in extract_io()
> git bisect bad 6bc092a0fc4d331a4adbbb664078af149c580834
> # bad: [02e77af824d5be3a94fdd885835a352f90d24c5c] cpufreq: intel_pstate:
> Clear last written P-state value on suspend
> git bisect bad 02e77af824d5be3a94fdd885835a352f90d24c5c
> # bad: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq: Improve
> suspend-resume synchronization
> git bisect bad eee2a44e4e2b41c0699919a550d41cc38daa4f42
> # good: [e6f50e602e373583423654ec000cad8b8d08f7bc] cpufreq: Hold the
> policy write lock when changing boost state
> git bisect good e6f50e602e373583423654ec000cad8b8d08f7bc
> # first bad commit: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq:
> Improve suspend-resume synchronization
>
> > Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pst=
ate")
> > Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stoppin=
g governors")
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >     * Retain all of the cpufreq_suspended checks to avoid carrying out
> >       governor operations after suspending cpufreq during system
> >       shutdown and during hibernation resume on systems with SMT (Sashi=
ko)
> >
> >     * Rearrange cpufreq_resume() to walk all cpufreq policies and call
> >       cpufreq_resume_policy() for all of them
> >
> >     * Call cpufreq_exit_governor() in cpufreq_resume_policy() for
> >       policies that were suspended during a system suspend transition a=
nd
> >       are inactive during the subsequent system resume (Sashiko)
> >
> >     * Update cpufreq_suspended under cpus_read_lock in cpufreq_resume()
> >       for more symmetry with cpufreq_suspend()
> >
> >     * Update changelog
> >
> > ---
> >   drivers/cpufreq/cpufreq.c |   86 +++++++++++++++++++++++++++++++++---=
----------
> >   include/linux/cpufreq.h   |    3 +
> >   2 files changed, 66 insertions(+), 23 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -35,6 +35,9 @@
> >   static LIST_HEAD(cpufreq_policy_list);
> >
> >   /* Macros to iterate over CPU policies */
> > +#define for_each_policy(__policy)    \
> > +     list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
> > +
> >   #define for_each_suitable_policy(__policy, __active)                 =
        \
> >       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) =
\
> >               if ((__active) =3D=3D !policy_is_inactive(__policy))
> > @@ -1956,6 +1959,14 @@ int cpufreq_generic_suspend(struct cpufr
> >   }
> >   EXPORT_SYMBOL(cpufreq_generic_suspend);
> >
> > +static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
> > +{
> > +     guard(cpufreq_policy_write)(policy);
> > +
> > +     cpufreq_stop_governor(policy);
> > +     policy->suspended =3D true;
> > +}
> > +
> >   /**
> >    * cpufreq_suspend() - Suspend CPUFreq governors.
> >    *
> > @@ -1978,11 +1989,8 @@ void cpufreq_suspend(void)
> >       pr_debug("%s: Suspending Governors\n", __func__);
> >
> >       for_each_active_policy(policy) {
> > -             if (has_target()) {
> > -                     scoped_guard(cpufreq_policy_write, policy) {
> > -                             cpufreq_stop_governor(policy);
> > -                     }
> > -             }
> > +             if (has_target())
> > +                     cpufreq_suspend_policy(policy);
> >
> >               if (cpufreq_driver->suspend && cpufreq_driver->suspend(po=
licy))
> >                       pr_err("%s: Failed to suspend driver: %s\n", __fu=
nc__,
> > @@ -1994,6 +2002,32 @@ suspend:
> >       cpus_read_unlock();
> >   }
> >
> > +static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool =
start)
> > +{
> > +     guard(cpufreq_policy_write)(policy);
> > +
> > +     if (!policy->suspended)
> > +             return;
> > +
> > +     policy->suspended =3D false;
> > +
> > +     if (policy_is_inactive(policy)) {
> > +             /*
> > +              * The policy was active when it was suspended, so its go=
vernor
> > +              * is still there.  Let the governor go.
> > +              */
> > +             cpufreq_exit_governor(policy);
> > +             return;
> > +     }
> > +
> > +     if (!start)
> > +             return;
> > +
> > +     if (cpufreq_start_governor(policy))
> > +             pr_err("%s: Failed to start governor for CPU%u's policy\n=
",
> > +                    __func__, policy->cpu);
> > +}
> > +
> >   /**
> >    * cpufreq_resume() - Resume CPUFreq governors.
> >    *
> > @@ -2003,11 +2037,12 @@ suspend:
> >   void cpufreq_resume(void)
> >   {
> >       struct cpufreq_policy *policy;
> > -     int ret;
> >
> >       if (!cpufreq_driver)
> >               return;
> >
> > +     guard(cpus_read_lock)();
> > +
> >       if (unlikely(!cpufreq_suspended))
> >               return;
> >
> > @@ -2018,19 +2053,18 @@ void cpufreq_resume(void)
> >
> >       pr_debug("%s: Resuming Governors\n", __func__);
> >
> > -     for_each_active_policy(policy) {
> > -             if (cpufreq_driver->resume && cpufreq_driver->resume(poli=
cy)) {
> > -                     pr_err("%s: Failed to resume driver: %s\n", __fun=
c__,
> > -                             cpufreq_driver->name);
> > -             } else if (has_target()) {
> > -                     scoped_guard(cpufreq_policy_write, policy) {
> > -                             ret =3D cpufreq_start_governor(policy);
> > -                     }
> > +     for_each_policy(policy) {
> > +             int ret =3D 0;
> >
> > +             if (cpufreq_driver->resume && !policy_is_inactive(policy)=
) {
> > +                     ret =3D cpufreq_driver->resume(policy);
> >                       if (ret)
> > -                             pr_err("%s: Failed to start governor for =
CPU%u's policy\n",
> > -                                    __func__, policy->cpu);
> > +                             pr_err("%s: Failed to resume driver: %s\n=
", __func__,
> > +                                    cpufreq_driver->name);
> >               }
> > +
> > +             if (has_target())
> > +                     cpufreq_resume_policy(policy, ret =3D=3D 0);
> >       }
> >   }
> >
> > @@ -2412,12 +2446,17 @@ __weak struct cpufreq_governor *cpufreq_
> >       return NULL;
> >   }
> >
> > +static bool cpufreq_is_suspended(struct cpufreq_policy *policy)
> > +{
> > +     return cpufreq_suspended || policy->suspended;
> > +}
> > +
> >   static int cpufreq_init_governor(struct cpufreq_policy *policy)
> >   {
> >       int ret;
> >
> > -     /* Don't start any governor operations if we are entering suspend=
 */
> > -     if (cpufreq_suspended)
> > +     /* Don't start any governor operations for suspended policies. */
> > +     if (cpufreq_is_suspended(policy))
> >               return 0;
> >       /*
> >        * Governor might not be initiated here if ACPI _PPC changed
> > @@ -2460,7 +2499,7 @@ static int cpufreq_init_governor(struct
> >
> >   static void cpufreq_exit_governor(struct cpufreq_policy *policy)
> >   {
> > -     if (cpufreq_suspended || !policy->governor)
> > +     if (cpufreq_is_suspended(policy) || !policy->governor)
> >               return;
> >
> >       pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> > @@ -2475,7 +2514,7 @@ int cpufreq_start_governor(struct cpufre
> >   {
> >       int ret;
> >
> > -     if (cpufreq_suspended)
> > +     if (cpufreq_is_suspended(policy))
> >               return 0;
> >
> >       if (!policy->governor)
> > @@ -2499,7 +2538,7 @@ int cpufreq_start_governor(struct cpufre
> >
> >   void cpufreq_stop_governor(struct cpufreq_policy *policy)
> >   {
> > -     if (cpufreq_suspended || !policy->governor)
> > +     if (cpufreq_is_suspended(policy) || !policy->governor)
> >               return;
> >
> >       pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> > @@ -2510,7 +2549,7 @@ void cpufreq_stop_governor(struct cpufre
> >
> >   static void cpufreq_governor_limits(struct cpufreq_policy *policy)
> >   {
> > -     if (cpufreq_suspended || !policy->governor)
> > +     if (cpufreq_is_suspended(policy) || !policy->governor)
> >               return;
> >
> >       pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> > @@ -2747,7 +2786,8 @@ static void cpufreq_policy_refresh(struc
> >        * -> ask driver for current freq and notify governors about a ch=
ange
> >        */
> >       if (cpufreq_driver->get && has_target() &&
> > -         (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(po=
licy, false))))
> > +         (cpufreq_is_suspended(policy) ||
> > +          WARN_ON(!cpufreq_verify_current_freq(policy, false))))
> >               return;
> >
> >       refresh_frequency_limits(policy);
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -149,6 +149,9 @@ struct cpufreq_policy {
> >       /* Pending policy->min/max update for the driver */
> >       bool                    update_limits;
> >
> > +     /* The policy has been suspended. */
> > +     bool                    suspended;
> > +
> >        /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
> >       unsigned int cached_target_freq;
> >       unsigned int cached_resolved_idx;
>
>

--00000000000046276706608e4ee7
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_pstate-power-ctl-ee-state.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-power-ctl-ee-state.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwm9242f0>
X-Attachment-Id: f_mwm9242f0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDI0ICsrKysrKysrKysrKysr
KystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pCgotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKKysrIGIvZHJpdmVycy9j
cHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0xMzUyLDEzICsxMzUyLDEyIEBAIHN0YXRpYyB2b2lk
IGludGVsX3BzdGF0ZV9od3Bfb2ZmbGluZShzdHIKICNkZWZpbmUgUE9XRVJfQ1RMX0RFQ19FTkFC
TEUJMjcKIAogc3RhdGljIGludCBwb3dlcl9jdGxfZWVfc3RhdGU7CitzdGF0aWMgREVGSU5FX01V
VEVYKHBvd2VyX2N0bF9lZV9zdGF0ZV9sb2NrKTsKIAotc3RhdGljIHZvaWQgc2V0X3Bvd2VyX2N0
bF9lZV9zdGF0ZShib29sIGlucHV0KQorc3RhdGljIHZvaWQgX19zZXRfcG93ZXJfY3RsX2VlX3N0
YXRlKGJvb2wgaW5wdXQpCiB7CiAJdTY0IHBvd2VyX2N0bDsKIAotCWd1YXJkKG11dGV4KSgmaW50
ZWxfcHN0YXRlX2RyaXZlcl9sb2NrKTsKLQogCXJkbXNycShNU1JfSUEzMl9QT1dFUl9DVEwsIHBv
d2VyX2N0bCk7CiAJaWYgKGlucHV0KSB7CiAJCXBvd2VyX2N0bCAmPSB+QklUKE1TUl9JQTMyX1BP
V0VSX0NUTF9CSVRfRUUpOwpAQCAtMTM3MCw2ICsxMzY5LDEzIEBAIHN0YXRpYyB2b2lkIHNldF9w
b3dlcl9jdGxfZWVfc3RhdGUoYm9vbAogCXdybXNycShNU1JfSUEzMl9QT1dFUl9DVEwsIHBvd2Vy
X2N0bCk7CiB9CiAKK3N0YXRpYyB2b2lkIHNldF9wb3dlcl9jdGxfZWVfc3RhdGUoYm9vbCBlbmFi
bGUpCit7CisJZ3VhcmQobXV0ZXgpKCZwb3dlcl9jdGxfZWVfc3RhdGVfbG9jayk7CisKKwlfX3Nl
dF9wb3dlcl9jdGxfZWVfc3RhdGUoZW5hYmxlKTsKK30KKwogc3RhdGljIHZvaWQgaW50ZWxfcHN0
YXRlX2h3cF9lbmFibGUoc3RydWN0IGNwdWRhdGEgKmNwdWRhdGEpOwogCiBzdGF0aWMgdm9pZCBp
bnRlbF9wc3RhdGVfaHdwX3JlZW5hYmxlKHN0cnVjdCBjcHVkYXRhICpjcHUpCkBAIC0xMzk4LDEx
ICsxNDA0LDEzIEBAIHN0YXRpYyBpbnQgaW50ZWxfcHN0YXRlX3Jlc3VtZShzdHJ1Y3QgY3AKIAog
CXByX2RlYnVnKCJDUFUgJWQgcmVzdW1pbmdcbiIsIGNwdS0+Y3B1KTsKIAotCS8qIE9ubHkgcmVz
dG9yZSBpZiB0aGUgc3lzdGVtIGRlZmF1bHQgaXMgY2hhbmdlZCAqLwotCWlmIChwb3dlcl9jdGxf
ZWVfc3RhdGUgPT0gUE9XRVJfQ1RMX0VFX0VOQUJMRSkKLQkJc2V0X3Bvd2VyX2N0bF9lZV9zdGF0
ZSh0cnVlKTsKLQllbHNlIGlmIChwb3dlcl9jdGxfZWVfc3RhdGUgPT0gUE9XRVJfQ1RMX0VFX0RJ
U0FCTEUpCi0JCXNldF9wb3dlcl9jdGxfZWVfc3RhdGUoZmFsc2UpOworCXNjb3BlZF9ndWFyZCht
dXRleCwgJnBvd2VyX2N0bF9lZV9zdGF0ZV9sb2NrKSB7CisJCS8qIE9ubHkgcmVzdG9yZSBpZiB0
aGUgc3lzdGVtIGRlZmF1bHQgaGFzIGNoYW5nZWQgKi8KKwkJaWYgKHBvd2VyX2N0bF9lZV9zdGF0
ZSA9PSBQT1dFUl9DVExfRUVfRU5BQkxFKQorCQkJX19zZXRfcG93ZXJfY3RsX2VlX3N0YXRlKHRy
dWUpOworCQllbHNlIGlmIChwb3dlcl9jdGxfZWVfc3RhdGUgPT0gUE9XRVJfQ1RMX0VFX0RJU0FC
TEUpCisJCQlfX3NldF9wb3dlcl9jdGxfZWVfc3RhdGUoZmFsc2UpOworCX0KIAogCWlmIChjcHUt
PnN1c3BlbmRlZCAmJiBod3BfYWN0aXZlKSB7CiAJCW11dGV4X2xvY2soJmludGVsX3BzdGF0ZV9s
aW1pdHNfbG9jayk7Cg==
--00000000000046276706608e4ee7--
