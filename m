From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:opp/genpd-performance-state 10/11]
 drivers/base/power/domain.c:1814:14: error: invalid type argument of '->'
 (have 'struct device')
Date: Mon, 20 Mar 2017 16:32:50 +0530
Message-ID: <20170320110250.GF25659@vireshk-i7>
References: <201703201725.FTs5fapC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33821 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754195AbdCTLET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:04:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id p189so41240582pfp.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:02:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201703201725.FTs5fapC%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org

On 20-03-17, 17:58, kbuild test robot wrote:
> tree:   https://git.linaro.org/people/vireshk/linux opp/genpd-performance-state
> head:   1c80aea883c2a8481a5266a5fdd0d250b28f4817
> commit: 26603b1348d6153199cae0a2f9aff115c888d5b0 [10/11] PM / Domain: Add struct device to genpd
> config: i386-randconfig-x015-201712 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 26603b1348d6153199cae0a2f9aff115c888d5b0
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: the vireshk/opp/genpd-performance-state HEAD 1c80aea883c2a8481a5266a5fdd0d250b28f4817 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/power/domain.c: In function 'of_genpd_add_provider_simple':
> >> drivers/base/power/domain.c:1814:14: error: invalid type argument of '->' (have 'struct device')
>        genpd->dev->of_node = np;
>                  ^~

Fixed thanks.

-- 
viresh
