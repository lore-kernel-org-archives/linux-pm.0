From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [for-next PATCH 1/2] PM / devfreq: more documentation warning fixes
Date: Fri, 26 Oct 2012 02:05:04 +0200
Message-ID: <6833848.UlMixi1sUD@vostro.rjw.lan>
References: <1351206614-23993-1-git-send-email-nm@ti.com> <1351206614-23993-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37962 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab2JZABH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Oct 2012 20:01:07 -0400
In-Reply-To: <1351206614-23993-2-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thursday, October 25, 2012 06:10:13 PM Nishanth Menon wrote:
> Commit 34b53237e9ceb141e13e846baed2a282461f4a01
> (PM / devfreq: Add suspend and resume apis)
> in Rafael's pm-devfreq-next branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
> Patchworks: https://patchwork.kernel.org/patch/1545791/
> 
> Warning(drivers/devfreq/devfreq.c:436): No description found for parameter 'devfreq'
> Warning(drivers/devfreq/devfreq.c:450): No description found for parameter 'devfreq'
> 
> Yet again, a missing ':' causes the kernel-doc to cry
> 
> Since it is not merged to upstream, I suggest squashing it
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
>  drivers/devfreq/devfreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 32e9b48..cdc3e2d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -430,7 +430,7 @@ EXPORT_SYMBOL(devfreq_remove_device);
>  
>  /**
>   * devfreq_suspend_device() - Suspend devfreq of a device.
> - * @devfreq	the devfreq instance to be suspended
> + * @devfreq:	the devfreq instance to be suspended
>   */
>  int devfreq_suspend_device(struct devfreq *devfreq)
>  {
> @@ -444,7 +444,7 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>  
>  /**
>   * devfreq_resume_device() - Resume devfreq of a device.
> - * @devfreq	the devfreq instance to be resumed
> + * @devfreq:	the devfreq instance to be resumed
>   */
>  int devfreq_resume_device(struct devfreq *devfreq)
>  {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
