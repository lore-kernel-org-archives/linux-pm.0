From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/redesign 24/33]
 drivers/cpufreq/sti-cpufreq.c:228:3: error: too many arguments to function
 'dev_pm_opp_put_prop_name'
Date: Mon, 5 Dec 2016 08:58:43 +0530
Message-ID: <20161205032843.GC29595@vireshk-i7>
References: <201612030123.O5i0GZxC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33026 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcLED2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2016 22:28:46 -0500
Received: by mail-pg0-f51.google.com with SMTP id 3so131472393pgd.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2016 19:28:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201612030123.O5i0GZxC%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 03-12-16, 01:49, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/redesign
> head:   c498cda5a64396dfa518b157441091494af76371
> commit: 354fcad932188685153f27b903db5b81584d42ba [24/33] PM / OPP: Return opp_table from dev_pm_opp_set_*() routines
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 354fcad932188685153f27b903db5b81584d42ba
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):

Fixed thanks.

-- 
viresh
