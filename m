From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [kbuild-all] [PATCH 4/4] thermal/intel_powerclamp: stop sched
 tick in forced idle
Date: Wed, 30 Nov 2016 05:50:45 +0800
Message-ID: <20161129215045.GE16489@yexl-desktop>
References: <1480369492-23901-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <201611290756.8ueWRhF9%fengguang.wu@intel.com>
 <20161128231123.24fc63c0@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13514 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750700AbcK3Fuq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Nov 2016 00:50:46 -0500
Content-Disposition: inline
In-Reply-To: <20161128231123.24fc63c0@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: kbuild test robot <lkp@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 11/28, Jacob Pan wrote:
>On Tue, 29 Nov 2016 07:21:14 +0800
>kbuild test robot <lkp@intel.com> wrote:
>
>> Hi Jacob,
>> 
>> [auto build test ERROR on soc-thermal/next]
>> [also build test ERROR on v4.9-rc7 next-20161128]
>> [if your patch is applied to the wrong git tree, please drop us a
>> note to help improve the system]
>> 
>This patchset is applicable on top of another patch indicated in the
>cover letter.
>(https://lkml.org/lkml/2016/11/28/683)
>

Thanks for the info, you could try use git(>=2.9.0) format-patch --base=<commit> (or
--base=auto for convenience) to record what (public, well-known) commit
your patch series was built on, then 0day would be able to know the
exact base and prerequisite patches.

Thanks,
Xiaolong

>Thanks,
>
>Jacob
>
>> url:
>> https://github.com/0day-ci/linux/commits/Jacob-Pan/Misc-enhancements-to-intel_powerclamp/20161129-065523
>> base:
>> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>> next config: x86_64-randconfig-x015-201648 (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901 reproduce: # save the
>> attached .config to linux build tree make ARCH=x86_64 
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    drivers/thermal/intel_powerclamp.c: In function
>> 'clamp_idle_injection_func':
>> >> drivers/thermal/intel_powerclamp.c:448:2: error: implicit
>> >> declaration of function
>> >> 'play_idle' [-Werror=implicit-function-declaration]
>>      play_idle(jiffies_to_msecs(w_data->duration_jiffies));
>>      ^~~~~~~~~
>>    cc1: some warnings being treated as errors
>> 
>> vim +/play_idle +448 drivers/thermal/intel_powerclamp.c
>> 
>>    442			smp_mb();
>>    443		}
>>    444	
>>    445		if (should_skip)
>>    446			goto balance;
>>    447	
>>  > 448
>>  > play_idle(jiffies_to_msecs(w_data->duration_jiffies));
>>    449	
>>    450	balance:
>>    451		if (clamping && w_data->clamping &&
>> cpu_online(w_data->cpu))
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source
>> Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel
>> Corporation
>
>[Jacob Pan]
>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all
