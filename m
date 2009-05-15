From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] pm: remove bus_type
	suspend_late()/resume_early()
Date: Fri, 15 May 2009 16:29:18 +0200
Message-ID: <200905151629.19337.rjw@sisk.pl>
References: <20090515141404.9189.51590.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090515141404.9189.51590.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 15 May 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Remove the ->suspend_late() and ->resume_early() callbacks
> from struct bus_type. These callbacks are legacy stuff at
> this point and since there seem to be no in-tree users we
> may as well remove them. New users should use dev_pm_ops.

OK

But please also have a look if they are not mentioned somewhere under
Documentation .

> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  This patch is almost too good to be true so there must be
>  something wrong. I did however spend quite some time grepping
>  and I could not find any in-tree users.
> 
>  drivers/base/power/main.c |    7 -------
>  include/linux/device.h    |    2 --
>  2 files changed, 9 deletions(-)
> 
> --- 0001/include/linux/device.h
> +++ work/include/linux/device.h	2009-05-15 13:11:46.000000000 +0900
> @@ -62,8 +62,6 @@ struct bus_type {
>  	void (*shutdown)(struct device *dev);
>  
>  	int (*suspend)(struct device *dev, pm_message_t state);
> -	int (*suspend_late)(struct device *dev, pm_message_t state);
> -	int (*resume_early)(struct device *dev);
>  	int (*resume)(struct device *dev);
>  
>  	struct dev_pm_ops *pm;
> --- 0001/drivers/base/power/main.c
> +++ work/drivers/base/power/main.c	2009-05-15 13:15:29.000000000 +0900
> @@ -334,9 +334,6 @@ static int resume_device_noirq(struct de
>  	if (dev->bus->pm) {
>  		pm_dev_dbg(dev, state, "EARLY ");
>  		error = pm_noirq_op(dev, dev->bus->pm, state);
> -	} else if (dev->bus->resume_early) {
> -		pm_dev_dbg(dev, state, "legacy EARLY ");
> -		error = dev->bus->resume_early(dev);
>  	}
>   End:
>  	TRACE_RESUME(error);
> @@ -591,10 +588,6 @@ static int suspend_device_noirq(struct d
>  	if (dev->bus->pm) {
>  		pm_dev_dbg(dev, state, "LATE ");
>  		error = pm_noirq_op(dev, dev->bus->pm, state);
> -	} else if (dev->bus->suspend_late) {
> -		pm_dev_dbg(dev, state, "legacy LATE ");
> -		error = dev->bus->suspend_late(dev, state);
> -		suspend_report_result(dev->bus->suspend_late, error);
>  	}
>  	return error;
>  }
> 
> 
