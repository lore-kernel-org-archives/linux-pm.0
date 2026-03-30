Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458C1FF1C7
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872396; cv=none; b=GYPmHwb8b11w6oJNaGxk9FjMTRbYCDdTRgbs3SROj3hFRlZnxh6JT+tDehHR8/sYpzXbM0yKn9/f7Hrji80EBCj3x0b76o3U6r1Bho2XZWR8fn/3z75n2YuSjf7n+Ea40SWt/6QVuZMfR1MzgNhxmEUjbc5zxpDkJ4oVvho45yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872396; c=relaxed/simple;
	bh=EJBKkZCO8MPILnI/4UqblC0w07xQhU9DuYoFlAM97jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7dikadzAFrRpgmK7CTAauFm++8gjMMd2ig1a7eQOhKhI1fGAoMdjLE6zO9/GSdkMw6m7exc75BmJ4z8agGsekD06wUjKBpMmA8X+8xaDwkag2j+0YKqHIdYL8qUmdngrb8tL+lL7oSExDw/kYrvXJ7T1wxfBBs7ifiT9JuyofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4mnksjf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4mnksjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76CBC4CEF7
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774872395;
	bh=EJBKkZCO8MPILnI/4UqblC0w07xQhU9DuYoFlAM97jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q4mnksjf+cMTUmubzG6mpb2GMqeo1aKoAOUuSzBlUH0bYncSayQaFz8EopIpxVW2L
	 uVbZVL0XMZv+hspDmzcGlRnA5BFkzYv5E5VQ2NzbzMuNr7TmrtIvERFNvHK4n/N1Yb
	 Ph5pF4GBT2S3DSp7XOWilKreEBLqNy61kx9LEleDdDVizQIrMJwNxPLDBaN+L3ZQim
	 VgbuXBVRh2uhwwFrYtHEKOqT8ETZGWmDq5KIHVqYolullVW7A3k4kvroY1h5QygJqm
	 CSmMwqgKxnfC7iRZoxhSWD4rE18CRPoES6qA6h2yWOGoBiUD5ZPIWkGP4b5EzE+/RD
	 ijopdhNMAGh6w==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-467161c4b7aso1583188b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 05:06:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbYkNqRH2lQoqBtYwph5CYx6esH+FM0sUFEhYL/BLb+rkG5q8YI8/19U3UiydTKsvv4NKlQgtjXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6fb1db6X1ybCvCMclqbpC6iuaoq/pnnkt8AMVTib7Lrjvf11z
	r4Bn9U264Lm+hvCRk+k3AVT9KDro/B5V1F14av+qJTwF5j8gyK43qR3uPZUcKwwlaB5BUod8aZe
	6/gEHJy6gtg1ckAYT7xwkJZjwQi/LaqI=
X-Received: by 2002:a05:6808:5294:b0:467:ebc8:6b3b with SMTP id
 5614622812f47-46a8a3f2e8dmr6352590b6e.4.1774872394832; Mon, 30 Mar 2026
 05:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603300921.b5dc709c-lkp@intel.com>
In-Reply-To: <202603300921.b5dc709c-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Mar 2026 14:06:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4h7zgcgY0Rc1jrrnn1pyUR0xX_CT7Gjig-ofWBDUVZg@mail.gmail.com>
X-Gm-Features: AQROBzBwJUAbyb1q1HOEedtbEvQO7fzIiE_yCPJx-KaXDIXhEIWtrnyod5cWi8U
Message-ID: <CAJZ5v0i4h7zgcgY0Rc1jrrnn1pyUR0xX_CT7Gjig-ofWBDUVZg@mail.gmail.com>
Subject: Re: [linux-next:master] [powercap] 42dde4365f: WARNING:possible_circular_locking_dependency_detected
To: kernel test robot <oliver.sang@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2026 at 9:52=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_d=
etected" on:
>
> commit: 42dde4365f89dce91bdc07fd1bca047d71dd162e ("powercap: intel_rapl: =
Register PM notifier only when RAPL package exists")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 85964cdcad0fac9a0eb7b87a0f9d88cc074b854=
c]
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
> with following parameters:
>
>         group: breakpoints
>
>
>
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 3=
2G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202603300921.b5dc709c-lkp@intel.=
com
>
>
>
> kern  :warn  : [   74.925211] [   T2261] WARNING: possible circular locki=
ng dependency detected
> kern  :warn  : [   74.925213] [   T2261] 7.0.0-rc2-00011-g42dde4365f89 #1=
 Tainted: G S      W
> kern  :err   : [   74.937766] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], go=
t write-back
> kern  :warn  : [   74.939962] [   T2261] --------------------------------=
----------------------
> kern  :warn  : [   74.939963] [   T2261] sh/2261 is trying to acquire loc=
k:
> kern  :warn  : [   74.939964] [   T2261] ffffffff8557ed28
> kern  :err   : [   74.952510] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], go=
t write-back
> kern  :warn  : [   74.959121] [   T2261]  (cpu_add_remove_lock){+.+.}-{4:=
4}, at: cpu_hotplug_pm_callback (kernel/cpu.c:571 kernel/cpu.c:2011)
> kern  :err   : [   74.971676] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], go=
t write-back
> kern  :warn  : [   74.973877] [   T2261]
> but task is already holding lock:
> kern  :warn  : [   74.973878] [   T2261] ffffffff85605e30 ((pm_chain_head=
).rwsem
> kern  :err   : [   74.986428] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], go=
t write-back
> kern  :warn  : [   74.990882] [   T2261] ){++++}-{4:4}, at: blocking_noti=
fier_call_chain_robust (kernel/notifier.c:120 kernel/notifier.c:345 kernel/=
notifier.c:333)
> kern  :err   : [   75.003437] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], go=
t write-back
> kern  :warn  : [   75.008321] [   T2261]
> which lock already depends on the new lock.
>
> kern  :warn  : [   75.008322] [   T2261]
> the existing dependency chain (in reverse order) is:
> kern  :warn  : [   75.008322] [   T2261]
> -> #3
> user  :notice: [   75.017865] [    T418] Created symlink '/etc/systemd/sy=
stem/sockets.target.wants/uuidd.socket' =E2=86=92 '/usr/lib/systemd/system/=
uuidd.socket'.
>
> user  :notice: [   75.018570] [    T418] /usr/sbin/policy-rc.d returned 1=
01, not running 'start uuidd.service uuidd.socket'
>
> kern  :err   : [   75.020879] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], go=
t write-back
> kern  :warn  : [   75.023062] [   T2261]  ((pm_chain_head).rwsem){++++}-{=
4:4}
> kern  :err   : [   75.035631] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], go=
t write-back
> kern  :warn  : [   75.042492] [   T2261] :
> kern  :warn  : [   75.042494] [   T2261]        __lock_acquire (kernel/lo=
cking/lockdep.c:5237 (discriminator 1))
> kern  :err   : [   75.053565] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], go=
t write-back
> kern  :warn  : [   75.057172] [   T2261]        lock_acquire (include/tra=
ce/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (disc=
riminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
> kern  :err   : [   75.069731] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], go=
t write-back
> kern  :warn  : [   75.076607] [   T2261]        down_write (arch/x86/incl=
ude/asm/preempt.h:80 (discriminator 10) kernel/locking/rwsem.c:1315 (discri=
minator 10) kernel/locking/rwsem.c:1326 (discriminator 10) kernel/locking/r=
wsem.c:1591 (discriminator 10))
> kern  :err   : [   75.081798] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], go=
t write-back
> kern  :warn  : [   75.085380] [   T2261]        blocking_notifier_chain_r=
egister (kernel/notifier.c:264 kernel/notifier.c:282)
> kern  :err   : [   75.097937] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], go=
t write-back
> kern  :warn  : [   75.106461] [   T2261] rapl_add_package_cpuslocked (dri=
vers/powercap/intel_rapl_common.c:2267) intel_rapl_common
> kern  :err   : [   75.119046] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], go=
t write-back
> kern  :warn  : [   75.126242] [   T2261] rapl_cpu_online (drivers/powerca=
p/intel_rapl_msr.c:81) intel_rapl_msr
> kern  :err   : [   75.131871] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], go=
t write-back
> kern  :warn  : [   75.144377] [   T2261]        cpuhp_invoke_callback (ke=
rnel/cpu.c:194)
> kern  :err   : [   75.152251] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], go=
t write-back
> kern  :warn  : [   75.164759] [   T2261]        cpuhp_thread_fun (kernel/=
cpu.c:1109 (discriminator 1))
> kern  :warn  : [   75.164762] [   T2261]        smpboot_thread_fn (kernel=
/smpboot.c:160)
> kern  :err   : [   75.175063] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], go=
t write-back
> kern  :warn  : [   75.183928] [   T2261]        kthread (kernel/kthread.c=
:467)
> kern  :err   : [   75.188770] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7bb000-0x3f7bbfff], go=
t write-back
> kern  :warn  : [   75.200932] [   T2261]        ret_from_fork (arch/x86/k=
ernel/process.c:164)
> kern  :err   : [   75.203171] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], go=
t write-back
> kern  :warn  : [   75.212468] [   T2261]        ret_from_fork_asm (arch/x=
86/entry/entry_64.S:255)
> kern  :err   : [   75.214715] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], go=
t write-back
> kern  :warn  : [   75.227219] [   T2261]
> -> #2 (cpuhp_state-up){+.+.}-{0:0}
> kern  :err   : [   75.232580] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], go=
t write-back
> kern  :warn  : [   75.245099] [   T2261] :
> kern  :warn  : [   75.245100] [   T2261]        __lock_acquire (kernel/lo=
cking/lockdep.c:5237 (discriminator 1))
> kern  :err   : [   75.247416] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], go=
t write-back
> kern  :warn  : [   75.252473] [   T2261]        lock_acquire (include/tra=
ce/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (disc=
riminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
> kern  :warn  : [   75.252475] [   T2261]        cpuhp_thread_fun (kernel/=
cpu.c:1088)
> kern  :err   : [   75.265022] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], go=
t write-back
> kern  :warn  : [   75.270422] [   T2261]        smpboot_thread_fn (kernel=
/smpboot.c:160)
> kern  :warn  : [   75.270424] [   T2261]        kthread (kernel/kthread.c=
:467)
> kern  :err   : [   75.282979] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], go=
t write-back
> kern  :warn  : [   75.287599] [   T2261]        ret_from_fork (arch/x86/k=
ernel/process.c:164)
> kern  :warn  : [   75.287602] [   T2261]        ret_from_fork_asm (arch/x=
86/entry/entry_64.S:255)
> kern  :err   : [   75.300163] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], go=
t write-back
> kern  :warn  : [   75.306600] [   T2261]
> -> #1 (cpu_hotplug_lock){++++}-{0:0}
> kern  :err   : [   75.319409] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x4035f000-0x40360fff], go=
t write-back
> kern  :warn  : [   75.327073] [   T2261] :
> kern  :warn  : [   75.327074] [   T2261]        __lock_acquire (kernel/lo=
cking/lockdep.c:5237 (discriminator 1))
> kern  :warn  : [   75.327077] [   T2261]        lock_acquire (include/tra=
ce/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (disc=
riminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
> kern  :err   : [   75.343199] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], go=
t write-back
> kern  :warn  : [   75.346150] [   T2261]        percpu_down_write (kernel=
/locking/percpu-rwsem.c:235)
> kern  :err   : [   75.358708] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], go=
t write-back
> kern  :warn  : [   75.364461] [   T2261]        _cpu_up (include/asm-gene=
ric/bitops/instrumented-non-atomic.h:141 include/linux/cpumask.h:649 includ=
e/linux/cpumask.h:1246 kernel/cpu.c:1624)
> kern  :warn  : [   75.364462] [   T2261]        cpu_up (kernel/cpu.c:1706=
)
> kern  :warn  : [   75.364464] [   T2261]        cpuhp_bringup_mask (kerne=
l/cpu.c:1772 (discriminator 1))
> kern  :err   : [   75.377019] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], go=
t write-back
> kern  :warn  : [   75.382247] [   T2261]        bringup_nonboot_cpus (ker=
nel/cpu.c:1851 kernel/cpu.c:1876)
> kern  :err   : [   75.387605] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], go=
t write-back
> kern  :warn  : [   75.400124] [   T2261]        smp_init (include/linux/b=
itmap.h:461 include/linux/nodemask.h:244 include/linux/nodemask.h:424 kerne=
l/smp.c:1003)
> kern  :err   : [   75.404613] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], go=
t write-back
> kern  :warn  : [   75.417126] [   T2261]        kernel_init_freeable (ini=
t/main.c:1685)
> kern  :err   : [   75.422136] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], go=
t write-back
> kern  :warn  : [   75.434649] [   T2261]        kernel_init (init/main.c:=
1584)
> kern  :warn  : [   75.434652] [   T2261]        ret_from_fork (arch/x86/k=
ernel/process.c:164)
> kern  :err   : [   75.439834] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], go=
t write-back
> kern  :warn  : [   75.452350] [   T2261]        ret_from_fork_asm (arch/x=
86/entry/entry_64.S:255)
> kern  :warn  : [   75.452352] [   T2261]
> -> #0 (
> user  :err   : [   75.458360] [    T420] error: dpkg -i /opt/deb/python3_=
3.13.5-1_amd64.deb failed.
>
> kern  :err   : [   75.459704] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], go=
t write-back
> kern  :warn  : [   75.472214] [   T2261] cpu_add_remove_lock){+.+.}-{4:4}=
:
> kern  :warn  : [   75.472217] [   T2261]        check_prev_add (kernel/lo=
cking/lockdep.c:3166 (discriminator 2))
> kern  :err   : [   75.474541] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7bb000-0x3f7bbfff], go=
t write-back
> kern  :warn  : [   75.479596] [   T2261]        validate_chain (kernel/lo=
cking/lockdep.c:3285 kernel/locking/lockdep.c:3908)
> kern  :warn  : [   75.479598] [   T2261]        __lock_acquire (kernel/lo=
cking/lockdep.c:5237 (discriminator 1))
> kern  :err   : [   75.492148] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], go=
t write-back
> kern  :warn  : [   75.497554] [   T2261]        lock_acquire (include/tra=
ce/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (disc=
riminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
> kern  :warn  : [   75.497556] [   T2261]        __mutex_lock (arch/x86/in=
clude/asm/jump_label.h:37 include/trace/events/lock.h:95 kernel/locking/mut=
ex.c:616 kernel/locking/mutex.c:776)
> kern  :err   : [   75.502747] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], go=
t write-back
> kern  :warn  : [   75.515254] [   T2261]        cpu_hotplug_pm_callback (=
kernel/cpu.c:571 kernel/cpu.c:2011)
> kern  :err   : [   75.520613] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], go=
t write-back
> kern  :warn  : [   75.525062] [   T2261]        notifier_call_chain (kern=
el/notifier.c:87)
> kern  :err   : [   75.537613] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], go=
t write-back
> kern  :warn  : [   75.542580] [   T2261]        blocking_notifier_call_ch=
ain_robust (kernel/notifier.c:121 kernel/notifier.c:345 kernel/notifier.c:3=
33)
> kern  :warn  : [   75.542583] [   T2261]        pm_notifier_call_chain_ro=
bust (include/linux/notifier.h:207 kernel/power/main.c:174)
> kern  :err   : [   75.547762] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], go=
t write-back
> kern  :warn  : [   75.560278] [   T2261]        enter_state (kernel/power=
/suspend.c:381 kernel/power/suspend.c:609)
> kern  :warn  : [   75.560281] [   T2261]        pm_suspend (kernel/power/=
suspend.c:645 kernel/power/suspend.c:636)
> kern  :err   : [   75.567809] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], go=
t write-back
> kern  :warn  : [   75.580320] [   T2261]        state_store (kernel/power=
/main.c:828 (discriminator 1))
> kern  :warn  : [   75.580322] [   T2261]        kernfs_fop_write_iter (fs=
/kernfs/file.c:88 fs/kernfs/file.c:356)
> kern  :err   : [   75.582645] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], go=
t write-back
> kern  :warn  : [   75.587701] [   T2261]        vfs_write (fs/read_write.=
c:596 (discriminator 1) fs/read_write.c:688 (discriminator 1))
> kern  :warn  : [   75.587703] [   T2261]        ksys_write (fs/read_write=
.c:740)
> kern  :err   : [   75.595073] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], go=
t write-back
> kern  :warn  : [   75.605660] [   T2261]        do_syscall_64 (arch/x86/e=
ntry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> kern  :err   : [   75.610934] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], go=
t write-back
> kern  :warn  : [   75.623438] [   T2261]        entry_SYSCALL_64_after_hw=
frame (arch/x86/entry/entry_64.S:130)
> kern  :warn  : [   75.623441] [   T2261]
> other info that might help us debug this:
>
> kern  :err   : [   75.627851] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], go=
t write-back
> kern  :warn  : [   75.632216] [   T2261] Chain exists of:
> cpu_add_remove_lock -->
> kern  :err   : [   75.637575] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], go=
t write-back
> kern  :warn  : [   75.650084] [   T2261] cpuhp_state-up --> (pm_chain_hea=
d).rwsem
> kern  :err   : [   75.655616] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], go=
t write-back
> kern  :warn  : [   75.668127] [   T2261]
>
> kern  :warn  : [   75.668127] [   T2261]  Possible unsafe locking scenari=
o:
>
> kern  :warn  : [   75.668128] [   T2261]        CPU0                    C=
PU1
> kern  :warn  : [   75.668129] [   T2261]        ----                    -=
---
> kern  :warn  : [   75.668130] [   T2261]   rlock(
> kern  :err   : [   75.672531] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], go=
t write-back
> kern  :warn  : [   75.685039] [   T2261] (pm_chain_head).rwsem);
> kern  :warn  : [   75.685041] [   T2261]                                l=
ock(cpuhp_state-up
> kern  :err   : [   75.690656] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], go=
t write-back
> kern  :warn  : [   75.703171] [   T2261] );
> kern  :warn  : [   75.703172] [   T2261]                                l=
ock((pm_chain_head).rwsem);
> kern  :err   : [   75.707918] [   T2140] x86/PAT: bmc-watchdog:2140 map p=
fn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], go=
t write-back
> kern  :warn  : [   75.712887] [   T2261]   lock(cpu_add_remove_lock);
> kern  :warn  : [   75.712889] [   T2261]
> *** DEADLOCK ***
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260330/202603300921.b5dc709c-lk=
p@intel.com

The report is correct.

rapl_pm_notifier cannot be registered with CPUs locked because CPU
hotplug has its own PM notifier which locks CPUs under
(pm_chain_head).rwsem.

I'm dropping commit 42dde4365f89 ("powercap: intel_rapl: Register PM
notifier only when RAPL package exists") along all of the commits that
depend on it from my linux-next branch.

Thanks!
