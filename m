From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Fri, 21 Nov 2014 23:31:20 +0900
Message-ID: <CAJuA9agpbDZrtmiQYexuAcS5GZeeB2YY22HTFQRPxnA+CLWb3Q@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
	<CAMAWPa_V2rO9Ymezf0xPqeQNykCFq9QwLsNOG3EgPZfP-8MRBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36179 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758361AbaKUObW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 09:31:22 -0500
In-Reply-To: <CAMAWPa_V2rO9Ymezf0xPqeQNykCFq9QwLsNOG3EgPZfP-8MRBQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On Thu, Nov 20, 2014 at 2:30 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Hi Thomas,
>
> On Mon, Oct 20, 2014 at 4:41 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>> which did not have CPUfreq driver support, enable the use of generic
>> CPUfreq driver.
>>
>> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Chander Kashyap <k.chander@samsung.com>
>
> What's the status of the exynos5 CPUfreq support for upstream?  This
> was pretty broadly reviewed and tested, but I still don't see this
> either in linux-next or Kukjin's for-next.

The rebased version of the patches have been posted [1]. My apologies
for the delay in following up on this patch series.

Thanks,
Thomas.

[1] http://www.spinics.net/lists/arm-kernel/msg380011.html

>
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
