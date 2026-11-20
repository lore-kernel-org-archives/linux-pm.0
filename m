Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198285;
	b=MVHzk9onUU94g46uFEv02HyEsUoRZaCCj+tCQesZXjTvu2afzMneuBgi+6vzU6/zRL1J
	 IoNEuKCS6Aj18UDb8ndOhczrrii7MhCchkuj294EaYut76oPEoA4wPWa1bsPdywaoVJhr
	 Vc/JweiSUzGt9YHuaXBPx2t6EOkcpq5IvDPFfmHmcwspa4U9dsC9mkwtQhdS7NNmIf674
	 Cr2twxahiHCzWKF8TCW1dyi7MaEzhNUI/fy4M/T8TCBvXx674E4sQFNyRaQ1ozuu/G+3i
	 tEM0i7mu+8gWvivZBX72VLpZALzgFnc83Ai2RB8NdT2t6aOp0LUEtaJQTeY9DRoY4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198285;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i8sHlRmLCw9x4WoZ3gUYCUwiZxteiqEBuV7/4Z5ttKw=;
	b=HrrKOU1/uPbHhisCnYEKekE9bMI6ZoYnbViTxnRRook7U085oiLKJvbc4FGsTDQtVmsL
	 1uie0uvgn8Pi4CwlFth4Rg6yg0IzLl2gE7os5E3kqgKN7ITzv6U8uOcrWiRQva/Ycakgr
	 hJp3cfpf0U/F2JRqmWR8Um47KnqPziGQlpjnWyZevBt+O5DmXvulkKL+G4ktM40UQRYLV
	 WW01gw7A6kGqXwJm1q/6uA9ghZKQpYnhJWRLo/pj8FJ8TCLaxGw/AF6VN+fi2lTrBfndj
	 i2imbU//Hrr7ZTRLTCwpDNO0Nh/ctkJ+tnmw98sQ5KkeVcGCu1j4r4lRxAr/4bNIcMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohEkGtAx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81118606BDEF
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohEkGtAx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654DF1F01803
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198285;
	bh=i8sHlRmLCw9x4WoZ3gUYCUwiZxteiqEBuV7/4Z5ttKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ohEkGtAx0gOyl38+5ZG1I+BkNGCr7Jy2YZSmOBeJFbXlHIBuHae9STS1k7CawbTVp
	 biMJDp3XWwxfKXumpdpKad/eaSUm7N2FA7WraEfgN0g443mqmd53v9cXWYNx0EQGXJ
	 oW2Rqt8pB7jfcz0+uRIpoL076crTznSRwuOiH9hEfflsumJZJ2DM+xnClfXJB1/VaT
	 v+7EEiExdHlFVTfqmog7xwqNSSOWdvajsPWrNOVUDKDMHCpqmrJmm9NPfWs0vdmA/b
	 nPWyJDgKSuKA0YPW65X1QdFSNhEDXhjlNIUimWzZI6RqJF7tU0UcFIGTJytSEHQi1y
	 TARvSuuLe3hbg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bccecba199so1150675e87.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEaMcJLZYqLpa/Nxeh2f3LVia0tUSJzPX5mZSGayWp+vrBxnW1O6Nmtm9K7jYdTMCfASfWnLeiOuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z83kmZAHO4bmwi0+gNlPzwCmN8ijdfiuDF2GbMHPjEN2bkoSFT8
	hqDC+BbbzHytAWK7geeK+WL9yRQ4ostevVtEMNEKTNcWePiISLdxL+8n6+pRIGYc/Nn3wOtMjQa
	wzkWthtC+qUBQ/YV8nwuXp/6VB+Gp5nc=
X-Received: by 2002:a05:6512:1153:b0:5ba:3443:aa2e with SMTP id
 2adb3069b0e04-5c1bc7c3484mr1402731e87.21.1795198283827; Fri, 20 Nov 2026
 10:11:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-cpuidle-pause-fix-v1-1-b2789fce4c16@gmail.com>
In-Reply-To: <20261117-cpuidle-pause-fix-v1-1-b2789fce4c16@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 19:11:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gd77wq8EwfpoFaUBYECtscXLaiFjCjTtt0s3EnXPjmgw@mail.gmail.com>
X-Gm-Features: Aa3M54oqxRk2jPVR1pLYKwDFb8DTzssxQAcbD8yfHEbG87CkJ2JyLftSL6-uQ9k
Message-ID: <CAJZ5v0gd77wq8EwfpoFaUBYECtscXLaiFjCjTtt0s3EnXPjmgw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Do not reinstall the idle handler while paused
To: hlibwondertan@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:01=E2=80=AFPM Wondertan via B4 Relay
<devnull+hlibwondertan.gmail.com@kernel.org> wrote:
>
> From: Wondertan <hlibwondertan@gmail.com>
>
> The PM core pauses cpuidle before taking secondary CPUs offline during
> system-wide transitions and resumes it after bringing them back online
> (pm_sleep_disable_secondary_cpus()/pm_sleep_enable_secondary_cpus()), so
> that CPUs do not enter cpuidle-managed idle states in that window.
>
> However, with acpi_idle, acpi_soft_cpu_online() calls
> acpi_processor_hotplug() for every CPU brought back online, and that
> function brackets its update with cpuidle_pause_and_lock() and
> cpuidle_resume_and_unlock().  The latter reinstalls the idle handler
> unconditionally, so cpuidle is effectively resumed as soon as the first
> secondary CPU is back online.  The remaining CPUs are then brought up,
> and cache_aps_init() runs stop_machine(), with idle CPUs entering deep
> ACPI C-states.  cpuidle_register_device() and cpuidle_switch_governor()
> can undo the pause in the same way.
>
> On a Framework Laptop 16 (AMD Ryzen AI 9 HX 370, BIOS 04.01), whose
> _CST exposes C2/C3 with the SystemIO entry method, this intermittently
> hangs hibernation after the image has been created: a CPU idling in
> io_idle() does not respond to an IPI and another CPU soft-locks waiting
> for it, either in smp_call_function_many_cond() (text poking from
> sched_cpu_activate() while an SMT sibling is onlined) or in
> multi_cpu_stop() (the MTRR rendezvous in cache_aps_init()).  The image is
> never written and the next boot reports "PM: Image not found (code -22)":
>
>   watchdog: BUG: soft lockup - CPU#12 stuck for 22s! [cpuhp/12:89]
>   RIP: 0010:smp_call_function_many_cond+0x147/0x520
>    on_each_cpu_cond_mask+0x24/0x40
>    smp_text_poke_batch_finish+0xe2/0x380
>    arch_jump_label_transform_apply+0x1a/0x30
>    static_key_slow_inc_cpuslocked+0x4f/0xa0
>    sched_cpu_activate+0x13c/0x150
>   ...
>    thaw_secondary_cpus.cold+0x5e/0xd2
>    hibernation_snapshot+0x231/0x530
>   NMI backtrace for cpu 0 skipped: idling at io_idle+0x3/0x30
>
>   watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [migration/3:37]
>   Stopper: multi_cpu_stop+0x0/0x140 <- __stop_cpus.constprop.0+0x6d/0xb0
>   (23 CPUs in multi_cpu_stop)
>   NMI backtrace for cpu 2 skipped: idling at io_idle+0x3/0x30
>
> Online CPUs can only be in io_idle() via cpuidle, so cpuidle was not
> paused at that point.  Tracing power:cpu_idle across the transition on
> 6.18.59 confirms it: while CPUs 1-23 were being brought online (between
> the first and the last CPU_ON "end" events, about 35 ms), idle CPUs
> entered C2 263 times and C3 305 times on all 24 CPUs, the first C3 entry
> coming 0.6 ms after CPU1 was onlined.  The failure rate was about one in
> four hibernations, higher on battery; disabling C2/C3 via sysfs around
> hibernation made it go away.
>
> Fix this by recording that cpuidle has been paused by cpuidle_pause()
> and not reinstalling the idle handler until cpuidle_resume() is called.
> All callers of cpuidle_install_idle_handler() hold cpuidle_lock, which
> also protects the new flag.
>
> With this change on top of 6.18.62 and 7.3.4, the same trace across a
> real hibernation and resume with C2/C3 enabled shows no C2/C3 entries
> in that window (only C1), hibernation completes, and C2/C3 are used
> again once the transition is over.
>
> The root cause analysis, the fix, the tracing used to verify it and
> this changelog were produced with an AI coding assistant (Claude Code,
> model claude-opus-5-5), working from pstore dumps, ftrace captures and
> the kernel sources.  All builds and tests were run on the affected
> machine as described above.
>
> Fixes: 8651f97bd951 ("PM / cpuidle: System resume hang fix with cpuidle")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wondertan <hlibwondertan@gmail.com>
> ---
> Tested only on the one affected machine (AMD, acpi_idle, BIOS 04.01
> and 04.02): built and run-tested on 6.18.62 and 7.3.4 (Arch linux-lts
> and linux configs, x86_64).  drivers/cpuidle/cpuidle.c in 7.3.4 is
> identical to mainline apart from this change.  On mainline
> (141b164bbe18) drivers/cpuidle/ was only built (W=3D1, no warnings), not
> booted.  Not tested with intel_idle or other cpuidle drivers.
>
> Earlier report of the hangs, before the root cause was known:
> "[REGRESSION?] hibernation soft lockup in migration/0 after image
> creation", linux-pm, 2026-07-09.
> ---
>  drivers/cpuidle/cpuidle.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 2d2f40a2c..3e26b1760 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -39,6 +39,7 @@ LIST_HEAD(cpuidle_detected_devices);
>  static int enabled_devices;
>  static int off __read_mostly;
>  static int initialized __read_mostly;
> +static bool paused;    /* Protected by cpuidle_lock */
>
>  int cpuidle_disabled(void)
>  {
> @@ -465,7 +466,12 @@ __cpuidle u64 cpuidle_poll_time(struct cpuidle_drive=
r *drv,
>   */
>  void cpuidle_install_idle_handler(void)
>  {
> -       if (enabled_devices) {
> +       /*
> +        * Do not reinstall the idle handler while cpuidle is paused for =
a
> +        * system transition, even if a nested cpuidle_resume_and_unlock(=
)
> +        * (e.g. from the ACPI processor CPU online callback) asks for it=
.
> +        */
> +       if (enabled_devices && !paused) {
>                 /* Make sure all changes finished before we switch to new=
 idle */
>                 smp_wmb();
>                 initialized =3D 1;
> @@ -515,6 +521,7 @@ EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>  void cpuidle_pause(void)
>  {
>         mutex_lock(&cpuidle_lock);
> +       paused =3D true;
>         cpuidle_uninstall_idle_handler();
>         mutex_unlock(&cpuidle_lock);
>  }
> @@ -523,6 +530,7 @@ void cpuidle_pause(void)
>  void cpuidle_resume(void)
>  {
>         mutex_lock(&cpuidle_lock);
> +       paused =3D false;
>         cpuidle_install_idle_handler();
>         mutex_unlock(&cpuidle_lock);
>  }
>
> ---

Applied as 7.5 material, thanks!
