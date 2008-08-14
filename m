From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] PM: Rework disabling of user mode
	helpers during suspend/hibernation
Date: Thu, 14 Aug 2008 07:32:35 +0200
Message-ID: <20080814053235.GG6995__7241.10575761205$1218712146$gmane$org@ucw.cz>
References: <200808080019.37057.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808080019.37057.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> PM: Rework disabling of user mode helpers during suspend/hibernation
> 
> We currently use a PM notifier to disable user mode helpers before
> suspend and hibernation and to re-enable them during the resume.
> However, this is not an ideal solution, because if any drivers want
> to upolad firmware into memory before suspend, they have to use a
> PM notifier for this purpose and there is not guarantee that the
> ordering of PM notifiers will be as expected (ie. the notifier that
> disables user mode helpers has to be run after the driver's notifier
> used for uploading the firmware).
> 
> For this reason, it seems better to move the disabling and enabling
> of user mode helpers to separate functions that will be called by the
> PM core as necessary.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> Index: linux-2.6/include/linux/kmod.h
> ===================================================================
> --- linux-2.6.orig/include/linux/kmod.h
> +++ linux-2.6/include/linux/kmod.h
> @@ -99,4 +99,9 @@ struct file;
>  extern int call_usermodehelper_pipe(char *path, char *argv[], char *envp[],
>  				    struct file **filp);
>  
> +#ifdef CONFIG_PM_SLEEP
> +extern int usermodehelper_disable(void);
> +extern void usermodehelper_enable(void);
> +#endif

No #ifdef needed for prototypes?


>  #endif /* __LINUX_KMOD_H__ */
> Index: linux-2.6/kernel/power/main.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/main.c
> +++ linux-2.6/kernel/power/main.c
> @@ -21,6 +21,7 @@
>  #include <linux/freezer.h>
>  #include <linux/vmstat.h>
>  #include <linux/syscalls.h>
> +#include <linux/kmod.h>
>  
>  #include "power.h"
>  
> @@ -236,6 +237,10 @@ static int suspend_prepare(void)
>  	if (error)
>  		goto Finish;
>  
> +	error = usermodehelper_disable();
> +	if (error)
> +		goto Finish;
> +
>  	if (suspend_freeze_processes()) {
>  		error = -EAGAIN;
>  		goto Thaw;

Could this be moved into suspend_freeze_processes? It is related
(usermode helper is disabled when no userland), and you will not have
to call it from 3 places...?

						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
