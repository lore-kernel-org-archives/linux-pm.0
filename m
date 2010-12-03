From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] PM: Use pm_wakeup_pending() in
	device_suspend()
Date: Fri, 3 Dec 2010 10:26:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012031024020.1682-100000__5012.75906940481$1291390148$gmane$org@iolanthe.rowland.org>
References: <201012030123.43786.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012030123.43786.rjw@sisk.pl>
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

On Fri, 3 Dec 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Before starting to suspend a device in device_suspend() check if
> there's a request to abort the power transition and return -EBUSY
> in that case.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/main.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -935,6 +935,11 @@ static void async_suspend(void *data, as
>  
>  static int device_suspend(struct device *dev)
>  {
> +	if (pm_wakeup_pending()) {
> +		async_error = -EBUSY;
> +		return async_error;
> +	}
> +
>  	INIT_COMPLETION(dev->power.completion);
>  
>  	if (pm_async_enabled && dev->power.async_suspend) {

Is a similar test needed in async_suspend()?  What happens if 
dpm_suspend() runs through the entire device list okay, but a wakeup 
event occurs in the middle of the async_synchronize_full() delay?

Alan Stern
