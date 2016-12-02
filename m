From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/redesign 20/33] fair_share.c:(.text+0x2b5):
 multiple definition of `dev_pm_opp_unregister_notifier'
Date: Fri, 2 Dec 2016 19:43:48 +0530
Message-ID: <20161202141348.GD22049@vireshk-i7>
References: <201612022046.DtplDrll%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34389 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760507AbcLBONw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 09:13:52 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so108035167pgx.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2016 06:13:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201612022046.DtplDrll%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 02-12-16, 20:26, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/redesign
> head:   fbf8f0c337a7cfcd4cb67865b5ea710e69c21f1f
> commit: 28475c4b5d76a2eef9b35fa198545403e07e1461 [20/33] PM / OPP: Don't expose srcu_head to register notifiers
> config: x86_64-randconfig-i0-201648 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout 28475c4b5d76a2eef9b35fa198545403e07e1461
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/thermal/fair_share.o: In function `dev_pm_opp_unregister_notifier':
> >> fair_share.c:(.text+0x2b5): multiple definition of `dev_pm_opp_unregister_notifier'
>    drivers/thermal/thermal_core.o:thermal_core.c:(.text+0x200d): first defined here
>    drivers/thermal/step_wise.o: In function `dev_pm_opp_unregister_notifier':
>    step_wise.c:(.text+0x3c8): multiple definition of `dev_pm_opp_unregister_notifier'
>    drivers/thermal/thermal_core.o:thermal_core.c:(.text+0x200d): first defined here
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Fixed both the reported issues. Thanks.

-- 
viresh
