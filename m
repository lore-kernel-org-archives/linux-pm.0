From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
Date: Thu, 31 Jul 2014 20:40:05 +0200
Message-ID: <53DA8D85.3050106@gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com> <1406707663-16656-5-git-send-email-thomas.ab@samsung.com> <53DA8BB9.6020702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:52764 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaGaSkK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 14:40:10 -0400
In-Reply-To: <53DA8BB9.6020702@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.majewski@samsung.com, mturquette@linaro.org, heiko@sntech.de, viresh.kumar@linaro.org, t.figa@samsung.com, cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org

Kukjin,

On 31.07.2014 20:32, Kukjin Kim wrote:
> On 07/30/14 17:07, Thomas Abraham wrote:
>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>> which did not have CPUfreq driver support, enable the use of generic
>> CPUfreq driver.
>>
>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>> Cc: Kukjin Kim<kgene.kim@samsung.com>
> 
> Looks good to me,
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> BTW, who will handle this series? I hope see this series in 3.17.

This series consists mostly of clock changes and it likely depends on
patches already in my for-next, so I would be inclined toward taking it
through samsung-clk tree. However, for this I would need Acks for patch
5/6 from Viresh and for patches [1] and [2] (which are dependencies of
this series) from you. I also need to make sure that the two mentioned
patches don't have any dependencies already in your tree.

[1] ARM: dts: add CPU nodes for Exynos4 SoCs
   - https://lkml.org/lkml/2014/7/21/315
[2] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
   - http://www.spinics.net/lists/arm-kernel/msg351134.html

Best regards,
Tomasz
