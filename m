From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v1] PM / Domains: Keep the pd status during system PM
 phases
Date: Fri, 20 Jan 2017 10:15:54 +0800
Message-ID: <201701201047.juTmuxEo%fengguang.wu@intel.com>
References: <1484794273-30103-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484794273-30103-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, xf@rock-chips.com, heiko@sntech.de, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, huangtao@rock-chips.com, xxx@rock-chips.com, wxt@rock-chips.com, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elaine,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.10-rc4 next-20170119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Elaine-Zhang/PM-Domains-Keep-the-pd-status-during-system-PM-phases/20170120-091738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-x016-201703 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from include/linux/delay.h:10,
                    from drivers/base/power/domain.c:9:
   drivers/base/power/domain.c: In function 'pm_genpd_suspend_noirq':
   drivers/base/power/domain.c:885:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/base/power/domain.c:884:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~
   drivers/base/power/domain.c:885:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:149:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/base/power/domain.c:884:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~
   drivers/base/power/domain.c:885:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:160:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/base/power/domain.c:884:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~
   drivers/base/power/domain.c: In function 'pm_genpd_resume_noirq':
   drivers/base/power/domain.c:923:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers/base/power/domain.c:922:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~
   drivers/base/power/domain.c:923:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:149:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   drivers/base/power/domain.c:922:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~
   drivers/base/power/domain.c:923:29: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
         dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:160:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   drivers/base/power/domain.c:922:2: note: in expansion of macro 'if'
     if (genpd->suspend_power_off ||
     ^~

vim +/if +884 drivers/base/power/domain.c

   868	 * @dev: Device to suspend.
   869	 *
   870	 * Stop the device and remove power from the domain if all devices in it have
   871	 * been stopped.
   872	 */
   873	static int pm_genpd_suspend_noirq(struct device *dev)
   874	{
   875		struct generic_pm_domain *genpd;
   876		int ret;
   877	
   878		dev_dbg(dev, "%s()\n", __func__);
   879	
   880		genpd = dev_to_genpd(dev);
   881		if (IS_ERR(genpd))
   882			return -EINVAL;
   883	
 > 884		if (genpd->suspend_power_off ||
   885		    dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
   886			return 0;
   887	
   888		if (genpd->dev_ops.stop && genpd->dev_ops.start) {
   889			ret = pm_runtime_force_suspend(dev);
   890			if (ret)
   891				return ret;
   892		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
k6P9/wEpOYZoxWIBAA==

--X1bOJ3K7DJ5YkBrT--
