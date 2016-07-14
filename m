From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [devfreq:testing/kozlowski 12/12] warning: (ARM_EXYNOS_BUS_DEVFREQ)
 selects DEVFREQ_EVENT_EXYNOS_PPMU which has unmet direct dependencies
 (PM_DEVFREQ && ..)
Date: Thu, 14 Jul 2016 15:03:19 +0900
Message-ID: <CAJ0PZbQk9Km1sJUr48ovpUef39j_u18X8nKDBo2N7LD+CH4WAw@mail.gmail.com>
References: <201607121927.xX0821td%fengguang.wu@intel.com> <5784E2F2.8060103@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36556 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcGNGDe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 02:03:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id u68so6056610oie.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2016 23:03:34 -0700 (PDT)
In-Reply-To: <5784E2F2.8060103@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Jul 12, 2016 at 9:30 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 07/12/2016 01:45 PM, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git testing/kozlowski
>> head:   dacb9d6e4946a56f550f706ee4361a6d68dc513a
>> commit: dacb9d6e4946a56f550f706ee4361a6d68dc513a [12/12] PM / devfreq: Add COMPILE_TEST for build coverage
>> config: sparc64-allyesconfig (attached as .config)
>> compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout dacb9d6e4946a56f550f706ee4361a6d68dc513a
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=sparc64
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (ARM_EXYNOS_BUS_DEVFREQ) selects DEVFREQ_EVENT_EXYNOS_PPMU which has unmet direct dependencies (PM_DEVFREQ && PM_DEVFREQ_EVENT && ARCH_EXYNOS)
>
> Hi MyungJoo,
>
> Thanks for applying the patch.
>
> The commit
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=testing/kozlowski&id=dacb9d6e4946a56f550f706ee4361a6d68dc513a
> looks wrong. It contains only half of necessary changes. It is missing
> defreq/event changes:
> https://patchwork.kernel.org/patch/9200657/
> This is the reason behind this kbuild warning.
>
> Additionally I see you cherry-picked dependency ("clk: Provide notifier
> stubs when !COMMON_CLK") but:
> 1. There is no signed-off-by of yours,

It is intentional, which is why the branch name is "testing/*", not "fixes*".

Anyway, the patch is updated.

> 2. It should be merged (pulled), not cherry-picked, because otherwise
> the commit will appear twice - both from clk tree and from yours. This
> is why Stephen provided a stable branch so just:
> $ git pull git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
> clk-notify

I wouldn't cherry-pick this clk-notify patch in the fixes branch
(after I can put Signoff on the patch).
That's why I asked you about the status of this prerequisite patch.

So, may I assume that this clk-notify patch is already being merged?



>
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
