From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: One issue regarding the run time power management
Date: Wed, 3 Nov 2010 04:18:02 +0100
Message-ID: <201011030418.02830.rjw@sisk.pl>
References: <BLU102-W6F8402163EAD81AFBF321EB490@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W6F8402163EAD81AFBF321EB490@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 02, 2010, Raj Kumar wrote:
> 
> Hi,
>  
> There is a one issue coming regarding the run time power management during system suspend, Suppose
> system suspend is going on and before the suspend callback of driver is executed, driver issues a runtime resume to run time power management core before it gets
> the system suspend call back but System suspend is going on then how the run time power management prevents this condition?
>  
> As I saw the code during dpm_prepare, power usage count is incremented by 1 by calling pm_runtime_get_noresume(dev) and then it calls
> pm_runtime_barrier,
>  
> Since During System suspend, driver calls pm_runtime_get which will invoke 
>  
> atomic_inc(&dev->power.usage_count);
>  
> which increments the power usage count and calls pm_request_resume which does not have any check on power usage count,

pm_request_resume() called during system suspend will not have any effect, unless it is called before
the pm_runtime_barrier() in dpm_prepare(), in which case the device is going to be resumed and
system suspend will be aborted, because the PM workqueue if frozen before the suspend of
devices.

> So when System suspend is going on and it has not reached suspend call back of driver and driver submits run time resume request (if
> the device is suspended at runtime earlier)
>  
> Then How run time power management prevents device run time resume when the system suspend is going on as it does not
> check for power usage count?

The request to resume the device waits until the thawing of the PM workqueue.
if the driver needs to resume the device during suspend, it should use
pm_runtime_resume() for that, in which case the PM core doesn't care.

Thanks,
Rafael
