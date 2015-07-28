From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] opp: add dev_pm_opp_is_turbo() helper
Date: Tue, 28 Jul 2015 16:27:13 +0200
Message-ID: <20150728142713.GB17745@amd>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <e7e8c272f85df846466e9b57d7c9eef74109c081.1438081962.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45417 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbG1O1Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 10:27:16 -0400
Content-Disposition: inline
In-Reply-To: <e7e8c272f85df846466e9b57d7c9eef74109c081.1438081962.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On Tue 2015-07-28 16:50:00, Viresh Kumar wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Add dev_pm_opp_is_turbo() helper to verify if an opp is to be used only
> for turbo mode or not.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h   |  7 +++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index b38f2600d797..a0c54058c4dd 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -281,6 +281,36 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  
>  /**
> + * dev_pm_opp_is_turbo() - Returns true if opp was trubo OPP

Typo.

And this is not exactly most helpful comment. opp is turbo... returns
if opp was turbo. Explanation what "turbo" means in this context would
be nice. I'm pretty sure it is not about air compression :-).

> + * Return: true if opp is turbo opp, else false.

Duplicate from above.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
