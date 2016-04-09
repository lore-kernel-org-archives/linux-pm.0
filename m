From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2] PM / Runtime: Move ignore_children flag under
 CONFIG_PM
Date: Sat, 9 Apr 2016 18:02:02 +0200
Message-ID: <20160409160202.GG19362@xo-6d-61-c0.localdomain>
References: <1460115653-32421-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46133 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbcDIQCP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 12:02:15 -0400
Content-Disposition: inline
In-Reply-To: <1460115653-32421-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi!

> The ignore_children flag is used only when CONFIG_PM is set, so let's move
> it into that section within the struct dev_pm_info.
> 
> Move also the corresponding pm_suspend_ignore_children() API out of
> device.h into pm_runtime.h, to be consistent with similar APIs.
> 
> Unfortunate this causes the Toshiba PCI SD mmc host driver to fail to
> compile as it needs pm_runtime.h, so let's fix this here as well.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 6a5d654..06eb353 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -591,6 +590,7 @@ struct dev_pm_info {
>  	unsigned int		deferred_resume:1;
>  	unsigned int		run_wake:1;
>  	unsigned int		runtime_auto:1;
> +	bool			ignore_children:1;
>  	unsigned int		no_callbacks:1;
>  	unsigned int		irq_safe:1;
>  	unsigned int		use_autosuspend:1;

Some day we might want to change these to bools they really are....?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
