From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: RFC: additional event for pm_notifier
Date: Wed, 17 Mar 2010 22:34:43 +0100
Message-ID: <201003172234.44039.rjw@sisk.pl>
References: <alpine.LFD.2.00.1003171945130.2469@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1003171945130.2469@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 17 March 2010, Sebastian Ott wrote:
> hi,
> 
> on s390 certain hw features which we normally enable in our init
> calls, get reset while restoring the hibernation image.
> so we need a trigger to reenable them before the device callbacks
> are called.
> 
> is it possible to add an additional event for the existing
> pm_notifier (something like the attached patch)?
> 
> regards
> sebastian
> 
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  include/linux/notifier.h |    1 +
>  kernel/power/hibernate.c |    2 ++
>  2 files changed, 3 insertions(+)
> 
> Index: linux-2.6/include/linux/notifier.h
> ===================================================================
> --- linux-2.6.orig/include/linux/notifier.h
> +++ linux-2.6/include/linux/notifier.h
> @@ -250,6 +250,8 @@ static inline int notifier_to_errno(int 
>  #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
>  #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
>  #define PM_POST_RESTORE		0x0006 /* Restore failed */
> +#define PM_RESTORE_FINISHED	0x0007 /* Image restored, called prior to
> +					  device callbacks */
>  
>  /* Console keyboard events.
>   * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
> Index: linux-2.6/kernel/power/hibernate.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/hibernate.c
> +++ linux-2.6/kernel/power/hibernate.c
> @@ -290,6 +290,8 @@ static int create_image(int platform_mod
>  	if (!in_suspend)
>  		platform_leave(platform_mode);
>  
> +	pm_notifier_call_chain(PM_RESTORE_FINISHED);

Hmm.  Why can't you put that in platform_leave()?

> +
>   Power_up:
>  	sysdev_resume();
>  	/* NOTE:  dpm_resume_noirq() is just a resume() for devices

Rafael
