From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
 errors unnecessarily
Date: Thu, 2 Dec 2010 10:38:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012021038040.1921-100000__8534.286710392$1291304501$gmane$org@iolanthe.rowland.org>
References: <201012020050.31171.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012020050.31171.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Dec 2010, Rafael J. Wysocki wrote:

> OK, so please let me know what you think of the appended patch (on top of the
> previous one).
> 
> Thanks,
> Rafael
> Index: linux-2.6/include/linux/suspend.h
> ===================================================================
> --- linux-2.6.orig/include/linux/suspend.h
> +++ linux-2.6/include/linux/suspend.h
> @@ -292,7 +292,7 @@ extern int unregister_pm_notifier(struct
>  /* drivers/base/power/wakeup.c */
>  extern bool events_check_enabled;
>  
> -extern bool pm_check_wakeup_events(void);
> +extern bool pm_wakeup_pending(void);
>  extern bool pm_get_wakeup_count(unsigned int *count);
>  extern bool pm_save_wakeup_count(unsigned int count);
>  #else /* !CONFIG_PM_SLEEP */
> @@ -309,7 +309,7 @@ static inline int unregister_pm_notifier
>  
>  #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
>  
> -static inline bool pm_check_wakeup_events(void) { return true; }
> +static inline bool pm_wakeup_pending(void) { return true; }

Shouldn't this return false?

Alan Stern
