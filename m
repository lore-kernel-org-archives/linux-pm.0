From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [devfreq:testing/kozlowski 12/12] warning:
 (ARM_EXYNOS_BUS_DEVFREQ) selects DEVFREQ_EVENT_EXYNOS_PPMU which has unmet
 direct dependencies (PM_DEVFREQ && ..)
Date: Tue, 12 Jul 2016 14:30:42 +0200
Message-ID: <5784E2F2.8060103@samsung.com>
References: <201607121927.xX0821td%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:63525 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcGLMaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 08:30:46 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA7002B4C38PU90@mailout4.w1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 12 Jul 2016 13:30:44 +0100 (BST)
In-reply-to: <201607121927.xX0821td%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 07/12/2016 01:45 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git testing/kozlowski
> head:   dacb9d6e4946a56f550f706ee4361a6d68dc513a
> commit: dacb9d6e4946a56f550f706ee4361a6d68dc513a [12/12] PM / devfreq: Add COMPILE_TEST for build coverage
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout dacb9d6e4946a56f550f706ee4361a6d68dc513a
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (ARM_EXYNOS_BUS_DEVFREQ) selects DEVFREQ_EVENT_EXYNOS_PPMU which has unmet direct dependencies (PM_DEVFREQ && PM_DEVFREQ_EVENT && ARCH_EXYNOS)

Hi MyungJoo,

Thanks for applying the patch.

The commit
https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=testing/kozlowski&id=dacb9d6e4946a56f550f706ee4361a6d68dc513a
looks wrong. It contains only half of necessary changes. It is missing
defreq/event changes:
https://patchwork.kernel.org/patch/9200657/
This is the reason behind this kbuild warning.

Additionally I see you cherry-picked dependency ("clk: Provide notifier
stubs when !COMMON_CLK") but:
1. There is no signed-off-by of yours,
2. It should be merged (pulled), not cherry-picked, because otherwise
the commit will appear twice - both from clk tree and from yours. This
is why Stephen provided a stable branch so just:
$ git pull git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
clk-notify

Best regards,
Krzysztof
