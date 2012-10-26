From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [for-next PATCH 2/2] PM / devfreq: more documentation warning fixes next set
Date: Fri, 26 Oct 2012 02:05:18 +0200
Message-ID: <3731897.oMofWLtvr4@vostro.rjw.lan>
References: <1351206614-23993-1-git-send-email-nm@ti.com> <1351206614-23993-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37974 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2JZABV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Oct 2012 20:01:21 -0400
In-Reply-To: <1351206614-23993-3-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thursday, October 25, 2012 06:10:14 PM Nishanth Menon wrote:
> commit cfd5194aecd08cd8fbfbf1534a0209b95bc6fcdf
> (PM / devfreq: Core updates to support devices which can idle)
> in Rafael's pm-devfreq-next branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
> Patchworks: https://patchwork.kernel.org/patch/1545751/
> 
> introduced a kernel documentation warning:
> Warning(drivers/devfreq/devfreq.c:289): bad line: 		release its resources.
> 
> This is due to lack of '*' at documentation start messing
> up poor scripts/kernel-doc 's mind. I suggest squashing
> this to original commit given not-yet-upstream status :).
> 
> Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

I fixed up the original patch in a slightly different way.

Thanks,
Rafael


> ---
>  drivers/devfreq/devfreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index cdc3e2d..2f6ad6b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -286,7 +286,7 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  
>  /**
>   * _remove_devfreq() - Remove devfreq from the devfreq list and
> -		release its resources.
> + *			release its resources.
>   * @devfreq:	the devfreq struct
>   * @skip:	skip calling device_unregister().
>   */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
