From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM: Prevent waiting forever on
	asynchronous resume after abort
Date: Fri, 3 Sep 2010 01:25:28 +0200
Message-ID: <201009030125.28494.rjw@sisk.pl>
References: <201009022340.41584.rjw@sisk.pl>
	<1283468359-6642-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1283468359-6642-1-git-send-email-ccross@android.com>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 03, 2010, Colin Cross wrote:
> During suspend, the power.completion is expected to be set when a
> device has not yet started suspending.  Set it on init to fix a
> corner case where a device is resumed when its parent has never
> suspended.
> 
> Consider three drivers, A, B, and C.  The parent of A is C, and C
> has async_suspend set.  On boot, C->power.completion is initialized
> to 0.
> 
> During the first suspend:
> suspend_devices_and_enter(...)
>  dpm_resume(...)
>   device_suspend(A)
>   device_suspend(B) returns error, aborts suspend
>  dpm_resume_end(...)
>    dpm_resume(...)
>     device_resume(A)
>      dpm_wait(A->parent == C)
>       wait_for_completion(C->power.completion)
> 
> The wait_for_completion will never complete, because
> complete_all(C->power.completion) will only be called from
> device_suspend(C) or device_resume(C), neither of which is called
> if suspend is aborted before C.
> 
> After a successful suspend->resume cycle, where B doesn't abort
> suspend, C->power.completion is left in the completed state by the
> call to device_resume(C), and the same call path will work if B
> aborts suspend.
> 
> Signed-off-by: Colin Cross <ccross@android.com>

Thanks, rebased on top of the current Linus' tree and applied to
suspend-2.6/pm-fixes .

Rafael


> ---
>  drivers/base/power/main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index cb784a0..b1b4029 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -63,6 +63,7 @@ void device_pm_init(struct device *dev)
>  {
>  	dev->power.status = DPM_ON;
>  	init_completion(&dev->power.completion);
> +	complete_all(&dev->power.completion);
>  	pm_runtime_init(dev);
>  }
>  
> 
