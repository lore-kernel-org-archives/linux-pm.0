From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [pm:bleeding-edge 8/8] drivers/devfreq/devfreq.c:631:9: error:
 implicit declaration of function 'dev_pm_opp_get_suspend_opp'
Date: Tue, 31 Jan 2017 09:37:35 +0900
Message-ID: <588FDC4F.4030405@samsung.com>
References: <201701280812.DyrTBe6m%fengguang.wu@intel.com>
 <1536438.yev350rkh8@aspire.rjw.lan>
 <CGME20170130045352epcas3p3f7eb227415766cd35dfdf5b6aa353aef@epcas3p3.samsung.com>
 <20170130045323.GC32580@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60111 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdAaAhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 19:37:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKM01VBACEOWP70@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 31 Jan 2017 09:37:36 +0900 (KST)
In-reply-to: <20170130045323.GC32580@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Lin Huang <hl@rock-chips.com>, kbuild test robot <fengguang.wu@intel.com>

Hi,

On 2017년 01월 30일 13:53, Viresh Kumar wrote:
> On 28-01-17, 10:23, Rafael J. Wysocki wrote:
>> On Saturday, January 28, 2017 08:11:14 AM kbuild test robot wrote:
>>>
>>> --r5Pyd7+fXNt84Ff3
>>> Content-Type: text/plain; charset=us-ascii
>>> Content-Disposition: inline
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>>> head:   a3010a64f3a78b5beab758083a58cedef710dcc0
>>> commit: a3010a64f3a78b5beab758083a58cedef710dcc0 [8/8] Merge branch 'pm-opp' into bleeding-edge
>>> config: x86_64-rhel (attached as .config)
>>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>>> reproduce:
>>>         git checkout a3010a64f3a78b5beab758083a58cedef710dcc0
>>>         # save the attached .config to linux build tree
>>>         make ARCH=x86_64 
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/devfreq/devfreq.c: In function 'devfreq_add_device':
>>>>> drivers/devfreq/devfreq.c:631:9: error: implicit declaration of function 'dev_pm_opp_get_suspend_opp' [-Werror=implicit-function-declaration]
>>>       opp = dev_pm_opp_get_suspend_opp(dev);
>>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    drivers/devfreq/devfreq.c:631:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>>>       opp = dev_pm_opp_get_suspend_opp(dev);
>>>           ^
>>>    cc1: some warnings being treated as errors
>>>
>>> vim +/dev_pm_opp_get_suspend_opp +631 drivers/devfreq/devfreq.c
>>>
>>> 4e670b1d Lin Huang 2016-12-28  625  	 */
>>> 4e670b1d Lin Huang 2016-12-28  626  	devfreq->suspend_freq = 0L;
>>> 4e670b1d Lin Huang 2016-12-28  627  	if (strncmp(devfreq->governor_name, "passive", 7)) {
>>> 4e670b1d Lin Huang 2016-12-28  628  		struct dev_pm_opp *opp;
>>> 4e670b1d Lin Huang 2016-12-28  629  
>>> 4e670b1d Lin Huang 2016-12-28  630  		rcu_read_lock();
>>> 4e670b1d Lin Huang 2016-12-28 @631  		opp = dev_pm_opp_get_suspend_opp(dev);
>>> 4e670b1d Lin Huang 2016-12-28  632  		if (opp)
>>> 4e670b1d Lin Huang 2016-12-28  633  			devfreq->suspend_freq = dev_pm_opp_get_freq(opp);
>>> 4e670b1d Lin Huang 2016-12-28  634  		rcu_read_unlock();
>>>
>>> :::::: The code at line 631 was first introduced by commit
>>> :::::: 4e670b1d75d939e33297601916699579e5f7218b PM / devfreq: Add suspend frequency support
>>
>> There seems to be some disagreement between this and the OPP changes from
>> Viresh.
>>
>> Can you guys please see what's going on and resolve it?
> 
> I have replied to the original patch from Chanwoo and he needs to use
> the new interface and resend his patch. @Chanwoo please use:
> dev_pm_opp_get_suspend_opp_freq() instead.
> 

This patch was posted before applied Viresh's patch.
I'll fix and resend next version. Please drop this patch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
