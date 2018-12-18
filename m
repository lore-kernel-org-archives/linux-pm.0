From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Tue, 18 Dec 2018 11:15:45 +0530
Message-ID: <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

On 13-12-18, 02:12, Stephen Boyd wrote:
> Quoting Viresh Kumar (2018-12-13 02:05:06)
> > On 13-12-18, 01:58, Stephen Boyd wrote:
> > > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> > > upon bringing the policy online the second time. I guess cpufreq_stats
> > > aren't able to be freed from there because they take locks in different
> > > order vs. the normal path?
> > 
> > Please share the lockdep report and the steps to reproduce it. I will
> > see if I can simulate the failure forcefully..
> > 
> 
> It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> think all it takes is to return an error the second time the policy is
> initialized when cpufreq_online() calls into the cpufreq driver.
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  4.19.8 #61 Tainted: G        W
>  ------------------------------------------------------
>  cpuhp/5/36 is trying to acquire lock:
>  000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0x44/0x80
> 
>  but task is already holding lock:
>  00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c/0x1cc
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (&policy->rwsem){++++}:
>         down_read+0x50/0xcc
>         show+0x30/0x78
>         sysfs_kf_seq_show+0x17c/0x25c
>         kernfs_seq_show+0xb4/0xf8
>         seq_read+0x4a8/0x8f0
>         kernfs_fop_read+0xe0/0x360
>         __vfs_read+0x80/0x328
>         vfs_read+0xd0/0x1d4
>         ksys_read+0x88/0x118
>         __arm64_sys_read+0x4c/0x5c
>         el0_svc_common+0x124/0x1c4
>         el0_svc_compat_handler+0x64/0x8c
>         el0_svc_compat+0x8/0x18

I failed to reproduce it over linux/next.

I had the following changes over linux/next:
https://pastebin.ubuntu.com/p/zkVm77PGdY/

I also did savedefconfig to show what all I changed in it. I faked multiple
clusters on my hikey960 board, which is not big little..

And here is the command list from history that I ran after boot.

  501  grep . /sys/devices/system/cpu/cpufreq/*/*
  502  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  503  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  504  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  505  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  506  grep . /sys/devices/system/cpu/cpufreq/*/*
  507  grep . /sys/devices/system/cpu/cpufreq/*/*
  508  echo 0 > /sys/devices/system/cpu/cpu4/online 
  509  echo 0 > /sys/devices/system/cpu/cpu5/online 
  510  echo 0 > /sys/devices/system/cpu/cpu6/online 
  511  echo 0 > /sys/devices/system/cpu/cpu7/online 
  512  grep . /sys/devices/system/cpu/cpufreq/*/*
  513  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  514  grep . /sys/devices/system/cpu/cpufreq/*/*
  515  echo 1 > /sys/devices/system/cpu/cpu4/online 
  516  grep . /sys/devices/system/cpu/cpufreq/*/*
  517  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  518  dmesg 

-- 
viresh
