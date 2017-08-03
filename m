From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/genpd-performance-state 8/8]
 drivers//remoteproc/qcom_q6v5_pil.c:1050:26: error: implicit declaration of
 function 'pm_genpd_has_performance_state'
Date: Thu, 3 Aug 2017 08:34:41 +0530
Message-ID: <20170803030441.GG31169@vireshk-i7>
References: <201708030821.peNGem3G%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35238 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHCDEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 23:04:45 -0400
Received: by mail-pg0-f44.google.com with SMTP id v189so850357pgd.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Aug 2017 20:04:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201708030821.peNGem3G%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 03-08-17, 08:11, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/genpd-performance-state
> head:   632eb4c9568177dd7a3f3c29ba88698616f6e4ad
> commit: 632eb4c9568177dd7a3f3c29ba88698616f6e4ad [8/8] remoteproc: qcom: q6v5: Vote for proxy powerdomain performance state
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 632eb4c9568177dd7a3f3c29ba88698616f6e4ad
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//remoteproc/qcom_q6v5_pil.c: In function 'q6v5_probe':
> >> drivers//remoteproc/qcom_q6v5_pil.c:1050:26: error: implicit declaration of function 'pm_genpd_has_performance_state' [-Werror=implicit-function-declaration]
>      qproc->has_perf_state = pm_genpd_has_performance_state(&qproc->dev);
>                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/pm_genpd_has_performance_state +1050 drivers//remoteproc/qcom_q6v5_pil.c

It was just a testing patch, dropped it from the tree now. Thanks.

-- 
viresh
