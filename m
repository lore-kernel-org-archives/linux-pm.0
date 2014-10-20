From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v11 5/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
Date: Mon, 20 Oct 2014 17:02:36 +0530
Message-ID: <CAKohpo=0wQD4mWq+GbpMnLR6W5u9U7n16KUyecffL6BAxeYVOQ@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:61521 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbaJTLcg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 07:32:36 -0400
Received: by mail-oi0-f42.google.com with SMTP id a141so3508451oig.29
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2014 04:32:36 -0700 (PDT)
In-Reply-To: <1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 20 October 2014 17:11, Thomas Abraham <thomas.ab@samsung.com> wrote:
> Exynos4210 and Exynos5250 based platforms have switched over to use generic
> cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
> drivers for these platforms can be removed.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Chander Kashyap <k.chander@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm |   22 ----------------------
>  drivers/cpufreq/Makefile    |    2 --
>  2 files changed, 0 insertions(+), 24 deletions(-)

Looks like you forgot removing drivers ;)
