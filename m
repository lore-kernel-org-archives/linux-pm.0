From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 5/7] PM: combine runtime PM entry points
Date: Fri, 24 Sep 2010 00:36:04 +0200
Message-ID: <201009240036.04207.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009231719570.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009231719570.1667-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 23, 2010, Alan Stern wrote:
> This patch (as1424) combines the various public entry points for the
> runtime PM routines into three simple functions: one for idle, one for
> suspend, and one for resume.  A new bitflag specifies whether or not
> to increment or decrement the usage_count field.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -16,19 +16,17 @@
>  #define RPM_ASYNC			0x01	/* Request is asynchronous */
>  #define RPM_RETURN_IF_IN_PROGRESS	0x02	/* Don't wait for concurrent
>  						    state change */
> +#define RPM_GET_PUT			0x04	/* Increment/decrement the
> +						    usage_count */
>  
>  #ifdef CONFIG_PM_RUNTIME
>  
>  extern struct workqueue_struct *pm_wq;
>  
> -extern int pm_runtime_idle(struct device *dev);
> -extern int pm_runtime_suspend(struct device *dev);
> -extern int pm_runtime_resume(struct device *dev);
> -extern int pm_request_idle(struct device *dev);
> +extern int pm_runtime_idle_entry(struct device *dev, int rpmflags);
> +extern int pm_runtime_suspend_entry(struct device *dev, int rpmflags);
> +extern int pm_runtime_resume_entry(struct device *dev, int rpmflags);

Hmm.  Since you're renaming everything anyway, why not to give new names to the
new merged routines in [4/7], like rpm_idle(), rpm_suspend(), rpm_resume() and 
call the new entry points __pm_runtime_idle(), __pm_runtime_suspen() and
__pm_runtime_resume()?  [I don't really like the _entry part.]  That would
match the general naming convention used in such cases.

Thanks,
Rafael
