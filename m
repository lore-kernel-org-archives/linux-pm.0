From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] devfreq: Add COMPILE_TEST for build coverage
Date: Tue, 28 Jun 2016 09:32:27 +0200
Message-ID: <5772280B.40306@samsung.com>
References: <201606280241.YE5uVWhf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32429 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbcF1Hcc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 03:32:32 -0400
In-reply-to: <201606280241.YE5uVWhf%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 06/27/2016 08:37 PM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on v4.7-rc5]
> [also build test ERROR on next-20160627]
> [cannot apply to devfreq/for-rafael]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/devfreq-Add-COMPILE_TEST-for-build-coverage/20160627-220248
> config: sh-allyesconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/devfreq/tegra-devfreq.c: In function 'tegra_actmon_rate_notify_cb':
>>> drivers/devfreq/tegra-devfreq.c:391:16: error: 'POST_RATE_CHANGE' undeclared (first use in this function)
>      if (action != POST_RATE_CHANGE)
>                    ^
>    drivers/devfreq/tegra-devfreq.c:391:16: note: each undeclared identifier is reported only once for each function it appears in
>>> drivers/devfreq/tegra-devfreq.c:396:24: error: dereferencing pointer to incomplete type 'struct clk_notifier_data'
>      tegra->cur_freq = data->new_rate / KHZ;
>                            ^
>    drivers/devfreq/tegra-devfreq.c: In function 'tegra_devfreq_probe':
>>> drivers/devfreq/tegra-devfreq.c:654:8: error: implicit declaration of function 'clk_notifier_register' [-Werror=implicit-function-declaration]
>      err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
>            ^
>    drivers/devfreq/tegra-devfreq.c: In function 'tegra_devfreq_remove':
>>> drivers/devfreq/tegra-devfreq.c:734:2: error: implicit declaration of function 'clk_notifier_unregister' [-Werror=implicit-function-declaration]
>      clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
>      ^
>    cc1: some warnings being treated as errors

I sent a follow up [1] for clock which I think fixes this report. In
case it won't be accepted, I'll change the Kconfig dependency to COMMON_CLK.

[1] https://lkml.org/lkml/2016/6/28/73

Best regards,
Krzysztof

