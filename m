From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: fix typo
Date: Fri, 21 Feb 2014 15:50:55 +0100
Message-ID: <20140221145054.GA5796@amd.pavel.ucw.cz>
References: <1392883232-24738-1-git-send-email-prabhakar.csengg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52431 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396AbaBUOu4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2014 09:50:56 -0500
Content-Disposition: inline
In-Reply-To: <1392883232-24738-1-git-send-email-prabhakar.csengg@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu 2014-02-20 13:30:32, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

...and as this is really trivial, you may want to send it to
trivial@kernel.org if it is not applied by Rafael.
								Pavel

> ---
>  include/linux/pm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8c6583a..b051ba9 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -352,7 +352,7 @@ const struct dev_pm_ops name = { \
>  
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
> - * (sustem suspend, hibernation or runtime PM).
> + * (system suspend, hibernation or runtime PM).
>   * NOTE: In general, system suspend callbacks, .suspend() and .resume(), should
>   * be different from the corresponding runtime PM callbacks, .runtime_suspend(),
>   * and .runtime_resume(), because .runtime_suspend() always works on an already

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
