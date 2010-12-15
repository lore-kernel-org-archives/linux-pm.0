From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_runtime_suspended() and non-pm_runtime-using
 (i2c) drivers
Date: Wed, 15 Dec 2010 15:38:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012151530590.2171-100000__1990.48152794621$1292452015$gmane$org@iolanthe.rowland.org>
References: <201012150119.59801.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012150119.59801.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 15 Dec 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Runtime: Fix pm_runtime_suspended()
> 
> pm_runtime_suspended() shouldn't return true if the runtime PM of the
> given device is disabled.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/pm_runtime.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pm_runtime.h
> +++ linux-2.6/include/linux/pm_runtime.h
> @@ -78,7 +78,8 @@ static inline void device_set_run_wake(s
>  
>  static inline bool pm_runtime_suspended(struct device *dev)
>  {
> -	return dev->power.runtime_status == RPM_SUSPENDED;
> +	return dev->power.runtime_status == RPM_SUSPENDED
> +		&& !dev->power.disable_depth;
>  }

You need to update the documentation entry for pm_runtime_suspended as 
well.

I think this is okay.  If a driver or subsystem uses
pm_runtime_suspended() then it must be runtime-PM-aware, so it wouldn't
leave a device disabled for runtime PM.

So in theory the only place this would matter is if the function is
called in a generic setting, and AFAICT the only place that happens is
in generic_ops.c, where the change is correct.

Alan Stern
