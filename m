From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Reintroduce dropped call to
	check_wakeup_irqs
Date: Mon, 11 Jul 2011 10:46:55 +0200
Message-ID: <201107111046.56044.rjw__25078.0609589585$1310374001$gmane$org@sisk.pl>
References: <1310342666-2493-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1310342666-2493-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 11, 2011, Colin Cross wrote:
> Patch 2e711c04dbbf7a7732a3f7073b1fc285d12b369d
> (PM: Remove sysdev suspend, resume and shutdown operations)
> deleted sysdev_suspend, which was being relied on to call
> check_wakeup_irqs in suspend.  If check_wakeup_irqs is not
> called, wake interrupts that are pending when suspend is
> entered may be lost.  It also breaks IRQCHIP_MASK_ON_SUSPEND,
> which is handled in check_wakeup_irqs.
> 
> This patch adds a call to check_wakeup_irqs in syscore_suspend,
> similar to what was deleted in sysdev_suspend.
> 
> CC: Rafael J. Wysocki <rjw@sisk.pl>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Colin Cross <ccross@android.com>

Thanks a lot for the patch and sorry for the breakage.

I'll push it to Linus later today (hopefully, that's not to late for 3.0).

Thanks,
Rafael


> ---
>  drivers/base/syscore.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
> index c126db3..9b8bbe0 100644
> --- a/drivers/base/syscore.c
> +++ b/drivers/base/syscore.c
> @@ -9,6 +9,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> +#include <linux/interrupt.h>
>  
>  static LIST_HEAD(syscore_ops_list);
>  static DEFINE_MUTEX(syscore_ops_lock);
> @@ -48,6 +49,13 @@ int syscore_suspend(void)
>  	struct syscore_ops *ops;
>  	int ret = 0;
>  
> +	pr_debug("Checking wake-up interrupts\n");
> +
> +	/* Return error code if there are any wake-up interrupts pending */
> +	ret = check_wakeup_irqs();
> +	if (ret)
> +		return ret;
> +
>  	WARN_ONCE(!irqs_disabled(),
>  		"Interrupts enabled before system core suspend.\n");
>  
> 
