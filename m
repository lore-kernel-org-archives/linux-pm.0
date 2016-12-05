From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/redesign 12/33] drivers/devfreq/rk3399_dmc.c:432:2:
 error: 'dmcfreq' undeclared
Date: Mon, 5 Dec 2016 08:58:24 +0530
Message-ID: <20161205032824.GB29595@vireshk-i7>
References: <201612030100.HKMmzg4g%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36711 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbcLED21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2016 22:28:27 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so60752333pfz.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2016 19:28:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201612030100.HKMmzg4g%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 03-12-16, 01:28, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/redesign
> head:   c498cda5a64396dfa518b157441091494af76371
> commit: 276a99b3cadf159054f43b4a1fbe963414d42a72 [12/33] devfreq: rk3399_dmc: Don't use OPP structures outside of RCU locks
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 276a99b3cadf159054f43b4a1fbe963414d42a72
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):

Fixed thanks.

-- 
viresh
