From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:bleeding-edge 8/8] drivers/devfreq/devfreq.c:631:9: error: implicit declaration of function 'dev_pm_opp_get_suspend_opp'
Date: Sat, 28 Jan 2017 10:23:05 +0100
Message-ID: <1536438.yev350rkh8@aspire.rjw.lan>
References: <201701280812.DyrTBe6m%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48603 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750828AbdA1J1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jan 2017 04:27:43 -0500
In-Reply-To: <201701280812.DyrTBe6m%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Lin Huang <hl@rock-chips.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Saturday, January 28, 2017 08:11:14 AM kbuild test robot wrote:
> 
> --r5Pyd7+fXNt84Ff3
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   a3010a64f3a78b5beab758083a58cedef710dcc0
> commit: a3010a64f3a78b5beab758083a58cedef710dcc0 [8/8] Merge branch 'pm-opp' into bleeding-edge
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout a3010a64f3a78b5beab758083a58cedef710dcc0
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/devfreq/devfreq.c: In function 'devfreq_add_device':
> >> drivers/devfreq/devfreq.c:631:9: error: implicit declaration of function 'dev_pm_opp_get_suspend_opp' [-Werror=implicit-function-declaration]
>       opp = dev_pm_opp_get_suspend_opp(dev);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/devfreq/devfreq.c:631:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>       opp = dev_pm_opp_get_suspend_opp(dev);
>           ^
>    cc1: some warnings being treated as errors
> 
> vim +/dev_pm_opp_get_suspend_opp +631 drivers/devfreq/devfreq.c
> 
> 4e670b1d Lin Huang 2016-12-28  625  	 */
> 4e670b1d Lin Huang 2016-12-28  626  	devfreq->suspend_freq = 0L;
> 4e670b1d Lin Huang 2016-12-28  627  	if (strncmp(devfreq->governor_name, "passive", 7)) {
> 4e670b1d Lin Huang 2016-12-28  628  		struct dev_pm_opp *opp;
> 4e670b1d Lin Huang 2016-12-28  629  
> 4e670b1d Lin Huang 2016-12-28  630  		rcu_read_lock();
> 4e670b1d Lin Huang 2016-12-28 @631  		opp = dev_pm_opp_get_suspend_opp(dev);
> 4e670b1d Lin Huang 2016-12-28  632  		if (opp)
> 4e670b1d Lin Huang 2016-12-28  633  			devfreq->suspend_freq = dev_pm_opp_get_freq(opp);
> 4e670b1d Lin Huang 2016-12-28  634  		rcu_read_unlock();
> 
> :::::: The code at line 631 was first introduced by commit
> :::::: 4e670b1d75d939e33297601916699579e5f7218b PM / devfreq: Add suspend frequency support

There seems to be some disagreement between this and the OPP changes from
Viresh.

Can you guys please see what's going on and resolve it?

Thanks,
Rafael

