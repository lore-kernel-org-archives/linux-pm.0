From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
Date: Mon, 25 Jul 2016 13:19:47 +0800
Message-ID: <20160725131947.644e6166@xhacker>
References: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
	<201607222230.DZObarhu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40324 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbcGYFYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 01:24:30 -0400
In-Reply-To: <201607222230.DZObarhu%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear all,

On Fri, 22 Jul 2016 22:30:53 +0800 kbuild test robot wrote:

> Hi,
> 
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on v4.7-rc7 next-20160722]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/PM-OPP-optimize-dev_pm_opp_set_rate-a-bit/20160722-205339
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':
> >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_max' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>       _set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt' may be used uninitialized in this function [-Wmaybe-uninitialized]  

These warnings seem weired. We only use them when !IS_ERR(old_opp), and we
should already set them if !IS_ERR(old_opp). Another weired thing is if
we add something, printk e.g in _find_freq_ceil(), then these warnings disappear

Could you please kindly give some suggestions about how to fix these warnings?

Thanks,
Jisheng

> 
> vim +/ou_volt_max +666 drivers/base/power/opp/core.c
> 
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  650  	if (freq < old_freq) {
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  651  		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  652  				       u_volt_max);
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  653  		if (ret)
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  654  			goto restore_freq;
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  655  	}
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  656  
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  657  	return 0;
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  658  
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  659  restore_freq:
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  660  	if (clk_set_rate(clk, old_freq))
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  661  		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  662  			__func__, old_freq);
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  663  restore_voltage:
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  664  	/* This shouldn't harm even if the voltages weren't updated earlier */
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  665  	if (!IS_ERR(old_opp))
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09 @666  		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  667  
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  668  	return ret;
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  669  }
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  670  EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
> 6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  671  
> 2c2709dc drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  672  /* OPP-dev Helpers */
> 2c2709dc drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  673  static void _kfree_opp_dev_rcu(struct rcu_head *head)
> 06441658 drivers/base/power/opp.c      Viresh Kumar 2015-07-29  674  {
> 
> :::::: The code at line 666 was first introduced by commit
> :::::: 6a0712f6f199e737aa5913d28ec4bd3a25de9660 PM / OPP: Add dev_pm_opp_set_rate()
> 
> :::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

