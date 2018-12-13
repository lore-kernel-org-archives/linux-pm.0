From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Thu, 13 Dec 2018 02:12:47 -0800
Message-ID: <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2018-12-13 02:05:06)
> On 13-12-18, 01:58, Stephen Boyd wrote:
> > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> > upon bringing the policy online the second time. I guess cpufreq_stats
> > aren't able to be freed from there because they take locks in different
> > order vs. the normal path?
>=20
> Please share the lockdep report and the steps to reproduce it. I will
> see if I can simulate the failure forcefully..
>=20

It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
think all it takes is to return an error the second time the policy is
initialized when cpufreq_online() calls into the cpufreq driver.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 4.19.8 #61 Tainted: G        W
 ------------------------------------------------------
 cpuhp/5/36 is trying to acquire lock:
 000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0x44/=
0x80

 but task is already holding lock:
 00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c/0x1=
cc

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #1 (&policy->rwsem){++++}:
        down_read+0x50/0xcc
        show+0x30/0x78
        sysfs_kf_seq_show+0x17c/0x25c
        kernfs_seq_show+0xb4/0xf8
        seq_read+0x4a8/0x8f0
        kernfs_fop_read+0xe0/0x360
        __vfs_read+0x80/0x328
        vfs_read+0xd0/0x1d4
        ksys_read+0x88/0x118
        __arm64_sys_read+0x4c/0x5c
        el0_svc_common+0x124/0x1c4
        el0_svc_compat_handler+0x64/0x8c
        el0_svc_compat+0x8/0x18

 -> #0 (kn->count#326){++++}:
        lock_acquire+0x244/0x360
        __kernfs_remove+0x324/0x4fc
        kernfs_remove_by_name_ns+0x44/0x80
        remove_files+0x5c/0xd8
        sysfs_remove_group+0xb4/0xec
        cpufreq_stats_free_table+0x50/0x9c
        cpufreq_policy_free+0x184/0x1cc
        cpufreq_online+0xa44/0xc4c
        cpuhp_cpufreq_online+0x1c/0x2c
        cpuhp_invoke_callback+0x608/0x1328
        cpuhp_thread_fun+0x1dc/0x440
        smpboot_thread_fn+0x46c/0x7c0
        kthread+0x248/0x260
        ret_from_fork+0x10/0x18

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&policy->rwsem);
                                lock(kn->count#326);
                                lock(&policy->rwsem);
   lock(kn->count#326);

  *** DEADLOCK ***

 2 locks held by cpuhp/5/36:
  #0: 00000000549a28c3 (cpuhp_state-up){+.+.}, at: cpuhp_lock_acquire+0x8/0=
x48
  #1: 00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17=
c/0x1cc

 stack backtrace:
 CPU: 5 PID: 36 Comm: cpuhp/5 Tainted: G        W         4.19.8 #61
 Call trace:
  dump_backtrace+0x0/0x2f8
  show_stack+0x20/0x2c
  __dump_stack+0x20/0x28
  dump_stack+0xcc/0x10c
  print_circular_bug+0x2c0/0x328
  __lock_acquire+0x22b0/0x2708
  lock_acquire+0x244/0x360
  __kernfs_remove+0x324/0x4fc
  kernfs_remove_by_name_ns+0x44/0x80
  remove_files+0x5c/0xd8
  sysfs_remove_group+0xb4/0xec
  cpufreq_stats_free_table+0x50/0x9c
  cpufreq_policy_free+0x184/0x1cc
  cpufreq_online+0xa44/0xc4c
  cpuhp_cpufreq_online+0x1c/0x2c
  cpuhp_invoke_callback+0x608/0x1328
  cpuhp_thread_fun+0x1dc/0x440
  smpboot_thread_fn+0x46c/0x7c0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18
