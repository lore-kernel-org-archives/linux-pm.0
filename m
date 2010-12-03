From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] PM: Use pm_wakeup_pending() in
	device_suspend()
Date: Fri, 3 Dec 2010 17:04:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012031702490.1682-100000__20386.1597263769$1291413936$gmane$org@iolanthe.rowland.org>
References: <201012032254.55542.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012032254.55542.rjw@sisk.pl>
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

> The devices will be suspended and the suspend will progress until it's
> finally aborted before putting the system into the sleep state.  But I agree
> it's better to check pm_wakeup_pending() in async_suspend() too,
> so I think we can simply put it into __device_suspend() instead, like in the
> patch below.
> 
> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Use pm_wakeup_pending() in __device_suspend()
> 
> Before starting to suspend a device in __device_suspend() check if
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
> @@ -877,6 +877,11 @@ static int __device_suspend(struct devic
>  	if (async_error)
>  		goto End;
>  
> +	if (pm_wakeup_pending()) {
> +		async_error = -EBUSY;
> +		goto End;
> +	}
> +
>  	if (dev->class) {
>  		if (dev->class->pm) {
>  			pm_dev_dbg(dev, state, "class ");
> 

Looks good.

Alan Stern
