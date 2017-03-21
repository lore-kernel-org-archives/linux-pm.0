From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/genpd-performance-state 10/11]
 drivers/soc/tegra/pmc.c:577:1: warning: the frame size of 1176 bytes is
 larger than 1024 bytes
Date: Tue, 21 Mar 2017 10:56:20 +0530
Message-ID: <20170321052620.GN25659@vireshk-i7>
References: <201703211237.8SX8YFBW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32836 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755279AbdCUF0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 01:26:38 -0400
Received: by mail-pg0-f41.google.com with SMTP id n190so88439038pga.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 22:26:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201703211237.8SX8YFBW%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 21-03-17, 12:17, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/genpd-performance-state
> head:   a7599bffacf277fa414af9fd0bccd31fedcd9573
> commit: bf0b21ab085088476f15bf69d9205d41055cd54e [10/11] PM / Domain: Add struct device to genpd
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bf0b21ab085088476f15bf69d9205d41055cd54e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/soc/tegra/pmc.c: In function 'tegra_powergate_sequence_power_up':
> >> drivers/soc/tegra/pmc.c:577:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     }
>     ^

Fixed, thanks.

-- 
viresh
