From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/genpd-performance-state 6/9]
 drivers/opp/qcom_rpmpd.c:126:1: error: type defaults to 'int' in declaration
 of 'subsys_initcall'
Date: Fri, 6 Oct 2017 14:50:08 +0530
Message-ID: <20171006092008.GD18345@vireshk-i7>
References: <201710061639.njBlCufc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:53846 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbdJFJUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2017 05:20:12 -0400
Received: by mail-pg0-f50.google.com with SMTP id s2so1488998pge.10
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2017 02:20:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201710061639.njBlCufc%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 06-10-17, 16:35, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/genpd-performance-state
> head:   13fe1509c44fe331828415c105e47904a376a016
> commit: bc45091e2bb046eb6718d715bb24c6184baa0263 [6/9] soc: qcom: rpmpd: Add a powerdomain driver to model cx/mx powerdomains
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bc45091e2bb046eb6718d715bb24c6184baa0263
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> drivers/opp/qcom_rpmpd.c:126:1: warning: data definition has no type or storage class
>     subsys_initcall(rpmpd_get_performance);
>     ^~~~~~~~~~~~~~~
> >> drivers/opp/qcom_rpmpd.c:126:1: error: type defaults to 'int' in declaration of 'subsys_initcall' [-Werror=implicit-int]
> >> drivers/opp/qcom_rpmpd.c:126:1: warning: parameter names (without types) in function declaration
>    drivers/opp/qcom_rpmpd.c:95:19: warning: 'rpmpd_get_performance' defined but not used [-Wunused-function]
>     static int __init rpmpd_get_performance(void)
>                       ^~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Fixed it. Thanks. Had to include module.h as well.

-- 
viresh
