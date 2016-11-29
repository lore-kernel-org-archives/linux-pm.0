From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 4/4] thermal/intel_powerclamp: stop sched tick in forced
 idle
Date: Mon, 28 Nov 2016 23:11:23 -0800
Message-ID: <20161128231123.24fc63c0@yairi>
References: <1480369492-23901-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <201611290756.8ueWRhF9%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62980 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755971AbcK2HL2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Nov 2016 02:11:28 -0500
In-Reply-To: <201611290756.8ueWRhF9%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jacob.jun.pan@linux.intel.com

On Tue, 29 Nov 2016 07:21:14 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Jacob,
> 
> [auto build test ERROR on soc-thermal/next]
> [also build test ERROR on v4.9-rc7 next-20161128]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> 
This patchset is applicable on top of another patch indicated in the
cover letter.
(https://lkml.org/lkml/2016/11/28/683)

Thanks,

Jacob

> url:
> https://github.com/0day-ci/linux/commits/Jacob-Pan/Misc-enhancements-to-intel_powerclamp/20161129-065523
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> next config: x86_64-randconfig-x015-201648 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901 reproduce: # save the
> attached .config to linux build tree make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/thermal/intel_powerclamp.c: In function
> 'clamp_idle_injection_func':
> >> drivers/thermal/intel_powerclamp.c:448:2: error: implicit
> >> declaration of function
> >> 'play_idle' [-Werror=implicit-function-declaration]
>      play_idle(jiffies_to_msecs(w_data->duration_jiffies));
>      ^~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/play_idle +448 drivers/thermal/intel_powerclamp.c
> 
>    442			smp_mb();
>    443		}
>    444	
>    445		if (should_skip)
>    446			goto balance;
>    447	
>  > 448
>  > play_idle(jiffies_to_msecs(w_data->duration_jiffies));
>    449	
>    450	balance:
>    451		if (clamping && w_data->clamping &&
> cpu_online(w_data->cpu))
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

[Jacob Pan]
