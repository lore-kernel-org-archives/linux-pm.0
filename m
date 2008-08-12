From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] PM: Remove WARN_ON from device_pm_add
Date: Tue, 12 Aug 2008 15:59:02 +0300
Message-ID: <20080812125902.GB13910__43826.2368007146$1218546361$gmane$org@cs181140183.pp.htv.fi>
References: <200808090105.14770.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808090105.14770.rjw@sisk.pl>
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
Cc: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 09, 2008 at 01:05:13AM +0200, Rafael J. Wysocki wrote:
> PM: Remove WARN_ON from device_pm_add
> 
> Fix message in device_pm_add() saying that the device will not be
> added to dpm_list, although in fact the device is going to be added
> to the list regardless of the ordering violation.
> 
> Remove the WARN_ON(true) triggered in that situation, because it is
> hit by USB very often and spams the users' logs.
> 
> This patch fixes bug #11263

Michael Tsirkin said in #11284 (which is marked as a duplicate of #11263):

<--  snip  -->

> What exactly is this instability?

X often crashes on resume, sometimes ACPI seems to stop working
after resume. I am trying to figure exact way to reproduce first,
or get some relevant logs, then I'll report.

> Does 2.6.26 work fine?

yes

<--  snip  -->


Is this a separate regression or did the WARN_ON different from the 
first assumption indicate a functional regression?


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/main.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -74,11 +74,9 @@ void device_pm_add(struct device *dev)
>  		 kobject_name(&dev->kobj));
>  	mutex_lock(&dpm_list_mtx);
>  	if (dev->parent) {
> -		if (dev->parent->power.status >= DPM_SUSPENDING) {
> -			dev_warn(dev, "parent %s is sleeping, will not add\n",
> +		if (dev->parent->power.status >= DPM_SUSPENDING)
> +			dev_warn(dev, "parent %s should not be sleeping\n",
>  				dev->parent->bus_id);
> -			WARN_ON(true);
> -		}
>  	} else if (transition_started) {
>  		/*
>  		 * We refuse to register parentless devices while a PM

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
