From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO, Thermal and X86
 due for the v4.13 merge window
Date: Wed, 31 May 2017 08:02:25 +0100
Message-ID: <20170531070225.bymdhhpclidwwtpt@dell>
References: <20170523072615.r4widzjc6apwxpwb@dell>
 <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170530085306.s4hlijutbz7gp3ay@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34043 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdEaHCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 03:02:36 -0400
Received: by mail-wr0-f171.google.com with SMTP id g76so3562399wrd.1
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2017 00:02:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170530085306.s4hlijutbz7gp3ay@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com

> Dear fellow Maintainers,
> 
> Enjoy!

... or not!

Please remove these patches from your tree, since they cause build
problems in the USB subsystem.

I have asked Kuppuswamy to squash all un-bisectable patches and
re-submit.  Once in my possession, the plan is to push out another
pull-request.

> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-gpio-thermal-x86-v4.13
> 
> for you to fetch changes up to 6aa60f67c11c10540e43bbe5a6377f7a0231501e:
> 
>   platform: x86: intel_bxtwc_tmu: remove first level irq unmask (2017-05-30 09:34:08 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, GPIO, Thermal and X86 due for the v4.13 merge window
> 
> ----------------------------------------------------------------
> Kuppuswamy Sathyanarayanan (8):
>       mfd: intel_soc_pmic_bxtwc: Fix TMU interrupt index
>       mfd: intel_soc_pmic_bxtwc: Remove thermal second level irqs
>       thermal: intel_bxt_pmic_thermal: use first level PMIC thermal irq
>       mfd: intel_soc_pmic_bxtwc: Remove second level irq for gpio device
>       gpio: gpio-wcove: use first level PMIC GPIO irq
>       mfd: intel_soc_pmic_bxtwc: Utilize devm_* functions in driver probe
>       mfd: intel_soc_pmic_bxtwc: Use chained irqs for second level irq chips
>       platform: x86: intel_bxtwc_tmu: remove first level irq unmask
> 
>  drivers/gpio/gpio-wcove.c                |  14 +-
>  drivers/mfd/intel_soc_pmic_bxtwc.c       | 234 ++++++++++++++++++++-----------
>  drivers/platform/x86/intel_bxtwc_tmu.c   |   4 -
>  drivers/thermal/intel_bxt_pmic_thermal.c |   2 +-
>  include/linux/mfd/intel_soc_pmic.h       |   5 +-
>  5 files changed, 174 insertions(+), 85 deletions(-)
> 
> Kind regards,
> Lee
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
