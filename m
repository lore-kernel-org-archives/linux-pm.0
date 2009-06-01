From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] pm: remove device_type
	suspend()/resume()
Date: Mon, 1 Jun 2009 20:40:57 +0200
Message-ID: <200906012040.58290.rjw@sisk.pl>
References: <20090601103836.10959.43392.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090601103836.10959.43392.sendpatchset@rx1.opensource.se>
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
To: Magnus Damm <magnus.damm@gmail.com>, gregkh@suse.de
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 01 June 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes the legacy callbacks ->suspend() and
> ->resume() from struct device_type. These callbacks seem
> unused, and new code should instead make use of struct
> dev_pm_ops.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

This is fine by me.

Greg, Pavel, Alan, any objections?

Rafael


> ---
> 
>  Only lightly compile tested on my laptop, could use some
>  multi-arch build farm verification.
> 
>  drivers/base/power/main.c |    7 -------
>  include/linux/device.h    |    3 ---
>  2 files changed, 10 deletions(-)
> 
> --- 0001/drivers/base/power/main.c
> +++ work/drivers/base/power/main.c	2009-06-01 17:07:23.000000000 +0900
> @@ -399,9 +399,6 @@ static int device_resume(struct device *
>  		if (dev->type->pm) {
>  			pm_dev_dbg(dev, state, "type ");
>  			error = pm_op(dev, dev->type->pm, state);
> -		} else if (dev->type->resume) {
> -			pm_dev_dbg(dev, state, "legacy type ");
> -			error = dev->type->resume(dev);
>  		}
>  		if (error)
>  			goto End;
> @@ -641,10 +638,6 @@ static int device_suspend(struct device 
>  		if (dev->type->pm) {
>  			pm_dev_dbg(dev, state, "type ");
>  			error = pm_op(dev, dev->type->pm, state);
> -		} else if (dev->type->suspend) {
> -			pm_dev_dbg(dev, state, "legacy type ");
> -			error = dev->type->suspend(dev, state);
> -			suspend_report_result(dev->type->suspend, error);
>  		}
>  		if (error)
>  			goto End;
> --- 0001/include/linux/device.h
> +++ work/include/linux/device.h	2009-06-01 17:00:20.000000000 +0900
> @@ -293,9 +293,6 @@ struct device_type {
>  	char *(*nodename)(struct device *dev);
>  	void (*release)(struct device *dev);
>  
> -	int (*suspend)(struct device *dev, pm_message_t state);
> -	int (*resume)(struct device *dev);
> -
>  	struct dev_pm_ops *pm;
>  };
