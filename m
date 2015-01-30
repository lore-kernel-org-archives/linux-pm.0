From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: Fix build break of devfreq-event class
Date: Fri, 30 Jan 2015 18:09:02 +0900
Message-ID: <CAJ0PZbR3TvJ8Cz8eMPiVRU+_ausByv5DhmsE2N3vF-aeqeGOBw@mail.gmail.com>
References: <1422593648-18151-1-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:42749 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757337AbbA3JJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 04:09:04 -0500
In-Reply-To: <1422593648-18151-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rafael.j.wysocki@intel.com, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, Jan 30, 2015 at 1:54 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch fixes the build break of the exynos-ppmu driver because Makefile
> in drivers/devfreq don't include the entry of devfreq-event.c driver.
>
> The original patch[1] includes the entry to build devfreq-event.c without
> the build break. This build break is generated in the process of merging the
> patch.
> [1] https://lkml.org/lkml/2015/1/25/579
> - [PATCH v10 1/7] devfreq: event: Add new devfreq_event class to provide basic
>                   data for devfreq governor

Sorry, that one is already included in the for-rafael tree with
tags/pull_req_20150129. :)


>
> CC      init/version.o
> LD      init/built-in.o
> drivers/built-in.o: In function `exynos_ppmu_probe':
> binder.c:(.text+0x4447ec): undefined reference to `devm_devfreq_event_add_edev'
> make: *** [vmlinux] Error 1
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 9256c35..5134f9e 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_PM_DEVFREQ)       += devfreq.o
> +obj-$(CONFIG_PM_DEVFREQ_EVENT) += devfreq-event.o
>  obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)      += governor_simpleondemand.o
>  obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)  += governor_performance.o
>  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)    += governor_powersave.o
> --
> 1.8.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
