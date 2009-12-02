From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: fix a lockdep warning in runtime.c
Date: Wed, 2 Dec 2009 22:15:29 +0100
Message-ID: <200912022215.29098.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912021553010.3041-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912021553010.3041-100000@iolanthe.rowland.org>
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

On Wednesday 02 December 2009, Alan Stern wrote:
> This patch (as1309) fixes a lockdep warning in
> __pm_runtime_set_status().  This is the one place where the runtime PM
> framework acquires a nested power.lock, and the nesting is never more
> than one deep.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

I have a very simila patch queued up already.  The only difference is that it
uses SINGLE_DEPTH_NESTING instead of the new symbol.  My version is appended
below.

> 
> ---
> 
> If anybody is using the runtime PM framework in 2.6.32 then this 
> should be pushed before the final release.

I'll push it to Linus, then, if there still is time.  Would you mind if I used
my version?

Thanks,
Rafael

 
> Index: usb-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/runtime.c
> +++ usb-2.6/drivers/base/power/runtime.c
> @@ -10,6 +10,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/jiffies.h>
>  
> +#define	RPM_LOCK_PARENT		1
> +
>  static int __pm_runtime_resume(struct device *dev, bool from_wq);
>  static int __pm_request_idle(struct device *dev);
>  static int __pm_request_resume(struct device *dev);
> @@ -793,7 +795,7 @@ int __pm_runtime_set_status(struct devic
>  	}
>  
>  	if (parent) {
> -		spin_lock(&parent->power.lock);
> +		spin_lock_nested(&parent->power.lock, RPM_LOCK_PARENT);
>  
>  		/*
>  		 * It is invalid to put an active child under a parent that is

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Runtime: Fix lockdep warning in __pm_runtime_set_status()

Lockdep complains about taking the parent lock in
__pm_runtime_set_status(), so mark it as nested.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/runtime.c
===================================================================
--- linux-2.6.orig/drivers/base/power/runtime.c
+++ linux-2.6/drivers/base/power/runtime.c
@@ -777,7 +777,7 @@ int __pm_runtime_set_status(struct devic
 	}
 
 	if (parent) {
-		spin_lock(&parent->power.lock);
+		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
 
 		/*
 		 * It is invalid to put an active child under a parent that is
