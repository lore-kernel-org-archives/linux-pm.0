From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: linux-next (4.12-rc1): DEADLOCK: WARNING: possible circular
 locking dependency detected
Date: Thu, 18 May 2017 16:11:51 +0530
Message-ID: <20170518104151.GG17481@vireshk-i7>
References: <CA+G9fYtgsQ0y2TpNFxBqmiMg6V9j+8xvyTDE+ODEzwQM6ihfig@mail.gmail.com>
 <CAKohpon0KYA6ZDhLs=OFdvgxvbQJQHsAxRjmVB4KxLre_nKBow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36582 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdERKly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2017 06:41:54 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so21923688pfg.3
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2017 03:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpon0KYA6ZDhLs=OFdvgxvbQJQHsAxRjmVB4KxLre_nKBow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Milosz Wasilewski <milosz.wasilewski@linaro.org>, Fathi Boudra <fathi.boudra@linaro.org>, Tom Gall <tom.gall@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18-05-17, 16:08, Viresh Kumar wrote:
> On 18 May 2017 at 16:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Boot HiKey board.
> >
> > [   76.039134] ======================================================
> > [   76.045319] WARNING: possible circular locking dependency detected
> > [   76.051507] 4.12.0-rc1-next-20170515 #1 Not tainted
> > [   76.056387] ------------------------------------------------------
> > [   76.062572] irq/56-wl18xx/2354 is trying to acquire lock:
> > [   76.067974]  (rtnl_mutex){+.+.+.}, at: [<ffff0000089b92f8>]
> > rtnl_lock+0x18/0x20
> > [   76.075309]
> > [   76.075309] but task is already holding lock:
> > [   76.081145]  (&wl->mutex){+.+.+.}, at: [<ffff000000f24054>]
> > wlcore_irq+0xdc/0x1a0 [wlcore]
> > [   76.089510]
> > [   76.089510] which lock already depends on the new lock.
> > [   76.089510]
> > [   76.097697]
> > [   76.097697] the existing dependency chain (in reverse order) is:
> > [   76.105187]
> > [   76.105187] -> #1 (&wl->mutex){+.+.+.}:
> > [   76.110519]        __lock_acquire+0x17b4/0x1928
> > [   76.115053]        lock_acquire+0xc8/0x290
> > [   76.119155]        __mutex_lock+0x78/0x8a8
> > [   76.123261]        mutex_lock_nested+0x1c/0x28
> > [   76.127775]        wlcore_regdomain_config.part.25+0x20/0x78 [wlcore]
> > [   76.134292]        wl1271_reg_notify+0x30/0x40 [wlcore]
> > [   76.139727]        wiphy_update_regulatory+0x294/0x420 [cfg80211]
> > [   76.145975]        wiphy_regulatory_register+0x34/0x48 [cfg80211]
> > [   76.152218]        wiphy_register+0x5fc/0x7d8 [cfg80211]
> > [   76.157812]        ieee80211_register_hw+0x3d4/0xa48 [mac80211]
> > [   76.163811]        wlcore_nvs_cb+0x758/0x9a8 [wlcore]
> > [   76.168936]        wlcore_probe+0x98/0xf0 [wlcore]
> > [   76.173779]        wl18xx_probe+0x4c/0xa8 [wl18xx]
> > [   76.178586]        platform_drv_probe+0x58/0xc0
> > [   76.183127]        driver_probe_device+0x214/0x2d0
> > [   76.187926]        __driver_attach+0xb4/0xb8
> > [   76.192204]        bus_for_each_dev+0x64/0xa0
> > [   76.196568]        driver_attach+0x20/0x28
> > [   76.200672]        bus_add_driver+0x110/0x230
> > [   76.205037]        driver_register+0x60/0xf8
> > [   76.209315]        __platform_driver_register+0x40/0x48
> > [   76.214551]        0xffff000000f90018
> > [   76.218222]        do_one_initcall+0x38/0x120
> > [   76.222589]        do_init_module+0x5c/0x1c0
> > [   76.226868]        load_module+0x1cac/0x2428
> > [   76.231145]        SyS_finit_module+0xc0/0xd0
> > [   76.235510]        __sys_trace_return+0x0/0x4
> > [   76.239872]
> > [   76.239872] -> #0 (rtnl_mutex){+.+.+.}:
> > [   76.245215]        print_circular_bug+0x80/0x2e0
> > [   76.249840]        __lock_acquire+0x17dc/0x1928
> > [   76.254379]        lock_acquire+0xc8/0x290
> > [   76.258485]        __mutex_lock+0x78/0x8a8
> > [   76.262589]        mutex_lock_nested+0x1c/0x28
> > [   76.267042]        rtnl_lock+0x18/0x20
> > [   76.270956]        cfg80211_sched_scan_results+0x60/0x230 [cfg80211]
> > [   76.277587]        ieee80211_sched_scan_results+0x5c/0x1e0 [mac80211]
> > [   76.284117]        wlcore_scan_sched_scan_results+0x24/0x60 [wlcore]
> > [   76.290523]        wl18xx_process_mailbox_events+0x60/0x468 [wl18xx]
> > [   76.296955]        wl1271_event_handle+0xc4/0x160 [wlcore]
> > [   76.302514]        wlcore_irq_locked+0x4e0/0x660 [wlcore]
> > [   76.307986]        wlcore_irq+0xe4/0x1a0 [wlcore]
> > [   76.312703]        irq_thread_fn+0x28/0x68
> > [   76.316809]        irq_thread+0x158/0x1f8
> > [   76.320827]        kthread+0x108/0x138
> > [   76.324584]        ret_from_fork+0x10/0x40
> > [   76.328686]
> > [   76.328686] other info that might help us debug this:
> > [   76.328686]
> > [   76.336715]  Possible unsafe locking scenario:
> > [   76.336715]
> > [   76.342650]        CPU0                    CPU1
> > [   76.347186]        ----                    ----
> > [   76.351722]   lock(&wl->mutex);
> > [   76.354872]                                lock(rtnl_mutex);
> > [   76.360543]                                lock(&wl->mutex);
> > [   76.366213]   lock(rtnl_mutex);
> > [   76.369361]
> > [   76.369361]  *** DEADLOCK ***
> > [   76.369361]
> > [   76.375304] 1 lock held by irq/56-wl18xx/2354:
> > [   76.379753]  #0:  (&wl->mutex){+.+.+.}, at: [<ffff000000f24054>]
> > wlcore_irq+0xdc/0x1a0 [wlcore]
> > [   76.388547]
> > [   76.388547] stack backtrace:
> > [   76.392922] CPU: 4 PID: 2354 Comm: irq/56-wl18xx Not tainted
> > 4.12.0-rc1-next-20170515 #1
> > [   76.401032] Hardware name: HiKey Development Board (DT)
> > [   76.406267] Call trace:
> > [   76.408720] [<ffff00000808a028>] dump_backtrace+0x0/0x240
> > [   76.414131] [<ffff00000808a32c>] show_stack+0x14/0x20
> > [   76.419195] [<ffff0000084984f4>] dump_stack+0xbc/0xf8
> > [   76.424258] [<ffff000008124504>] print_circular_bug+0x1f4/0x2e0
> > [   76.430190] [<ffff00000812757c>] __lock_acquire+0x17dc/0x1928
> > [   76.435947] [<ffff000008127f38>] lock_acquire+0xc8/0x290
> > [   76.441272] [<ffff000008af5888>] __mutex_lock+0x78/0x8a8
> > [   76.446595] [<ffff000008af60d4>] mutex_lock_nested+0x1c/0x28
> > [   76.452267] [<ffff0000089b92f8>] rtnl_lock+0x18/0x20
> > [   76.457402] [<ffff000000cf4518>]
> > cfg80211_sched_scan_results+0x60/0x230 [cfg80211]
> > [   76.465253] [<ffff000000dfb0cc>]
> > ieee80211_sched_scan_results+0x5c/0x1e0 [mac80211]
> > [   76.472994] [<ffff000000f3887c>]
> > wlcore_scan_sched_scan_results+0x24/0x60 [wlcore]
> > [   76.480624] [<ffff000000f77640>]
> > wl18xx_process_mailbox_events+0x60/0x468 [wl18xx]
> > [   76.488278] [<ffff000000f2c874>] wl1271_event_handle+0xc4/0x160 [wlcore]
> > [   76.495056] [<ffff000000f22c28>] wlcore_irq_locked+0x4e0/0x660 [wlcore]
> > [   76.501747] [<ffff000000f2405c>] wlcore_irq+0xe4/0x1a0 [wlcore]
> > [   76.507682] [<ffff00000813dab8>] irq_thread_fn+0x28/0x68
> > [   76.513005] [<ffff00000813dda0>] irq_thread+0x158/0x1f8
> > [   76.518242] [<ffff0000080f4b38>] kthread+0x108/0x138
> > [   76.523217] [<ffff000008083710>] ret_from_fork+0x10/0x40

You sure you pasted the right log? This doesn't look related to
cpufreq at all.

-- 
viresh
