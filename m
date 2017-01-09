From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/genpd-performance-state 14/18]
 include/linux/pm_qos.h:199:19: warning: 'dev_pm_qos_add_notifier' declared
 'static' but never defined
Date: Mon, 9 Jan 2017 08:54:45 +0530
Message-ID: <20170109032445.GK21926@vireshk-i7>
References: <201701061954.4iGTmC2m%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34726 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933873AbdAIDYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2017 22:24:49 -0500
Received: by mail-pf0-f171.google.com with SMTP id 127so27155895pfg.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2017 19:24:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201701061954.4iGTmC2m%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 06-01-17, 19:32, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/genpd-performance-state
> head:   e327d4cbb8b86e33f3e777bbbd8a9a8326e5f6d5
> commit: efd46e263c100a5051c4b9d15f523ce08f76934a [14/18] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
> config: openrisc-or1ksim_defconfig (attached as .config)
> compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout efd46e263c100a5051c4b9d15f523ce08f76934a
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/power/qos.c:32:0:
>    include/linux/pm_qos.h:202:4: error: expected identifier or '(' before '{' token
> >> include/linux/pm_qos.h:199:19: warning: 'dev_pm_qos_add_notifier' declared 'static' but never defined

Fixed thanks.

-- 
viresh
