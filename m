From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] power: user: Standardize "Syncing filesystems ..."
 message
Date: Fri, 5 Jun 2015 12:37:27 +0200
Message-ID: <20150605103727.GA6054@amd>
References: <cover.1433442778.git.joe@perches.com>
 <06fdc51c7d2ab639729107a137b947704fd7d161.1433442778.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53745 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbFEKhd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2015 06:37:33 -0400
Content-Disposition: inline
In-Reply-To: <06fdc51c7d2ab639729107a137b947704fd7d161.1433442778.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org

On Thu 2015-06-04 11:36:48, Joe Perches wrote:
> Instead of a two individual printks that would generally be
> emitted on a single line, emit 2 lines to make the start
> and end of the synchronization more easily timeable.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/power/user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 526e891..e22f6ad 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -221,9 +221,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  		if (data->frozen)
>  			break;
>  
> -		printk("Syncing filesystems ... ");
> +		printk("Syncing filesystems ...\n");
>  		sys_sync();
> -		printk("done.\n");
> +		printk("Syncing filesystems: done\n");

You converted " ..." -> "..." elsewhere, so why not here?

Is splitting message to two lines a good idea?

Is it time to introduce helper function that does the sync with the
printing?

I must say that I'm to a great fan on adding more lines to hibernation
output. Eats too much vertical space on screen, etc. Do you see real
problems there or are you just trying to "improve" this?

I'm pretty sure sync timing can be easily obtained from other messages
around this one...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
