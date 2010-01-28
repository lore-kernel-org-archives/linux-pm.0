From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Clean up
	pm_runtime_disable()
Date: Thu, 28 Jan 2010 10:37:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001281037120.1384-100000__47301.4953117401$1264693266$gmane$org@iolanthe.rowland.org>
References: <201001280011.06055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001280011.06055.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Jan 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove the second argument of __pm_runtime_disable(), which is not
> necessary any more, and rename this funtion to pm_runtime_disable().
> Accordingly, drop the static inline definition of
> pm_runtime_disable() using __pm_runtime_disable() and export
> pm_runtime_disable() as appropriate.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/runtime.c |   31 ++++---------------------------
>  include/linux/pm_runtime.h   |    9 ++-------
>  2 files changed, 6 insertions(+), 34 deletions(-)
> 
> Index: linux-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/runtime.c
> +++ linux-2.6/drivers/base/power/runtime.c
> @@ -943,20 +943,15 @@ int pm_runtime_barrier(struct device *de
>  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>  
>  /**
> - * __pm_runtime_disable - Disable run-time PM of a device.
> + * pm_runtime_disable - Disable run-time PM of a device.
>   * @dev: Device to handle.
> - * @check_resume: If set, check if there's a resume request for the device.
>   *
>   * Increment power.disable_depth for the device and if was zero previously,
>   * cancel all pending run-time PM requests for the device and wait for all
>   * operations in progress to complete.  The device can be either active or
>   * suspended after its run-time PM has been disabled.
> - *
> - * If @check_resume is set and there's a resume request pending when
> - * __pm_runtime_disable() is called and power.disable_depth is zero, the
> - * function will wake up the device before disabling its run-time PM.
>   */
> -void __pm_runtime_disable(struct device *dev, bool check_resume)
> +void pm_runtime_disable(struct device *dev)
>  {

Why did you decide to remove the check_resume argument?  That decision 
should be explained in the patch description.

Alan Stern
