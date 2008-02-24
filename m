From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 19:21:21 +0100
Message-ID: <20080224182120.GB3886__40626.0003489026$1203877785$gmane$org@ucw.cz>
References: <200802240119.51935.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0802232143050.29968-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802232143050.29968-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

> Index: usb-2.6/drivers/base/power/main.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/main.c
> +++ usb-2.6/drivers/base/power/main.c
> @@ -25,6 +25,7 @@
>  #include <linux/pm.h>
>  #include <linux/resume-trace.h>
>  #include <linux/rwsem.h>
> +#include <linux/sched.h>
>  
>  #include "../base.h"
>  #include "power.h"
> @@ -59,6 +60,13 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
>  
>  int (*platform_enable_wakeup)(struct device *dev, int is_on);
>  
> +static struct task_struct *suspending_task;

What locking protects this variable? What happens when suspending_task
exits? (Hmm, that would probably be bug, anyway?)

Or are we running UP when this is accessed? This at least needs a big
fat comment.

> +bool in_suspend_context(void)
> +{
> +	return (suspending_task == current);
> +}


							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
