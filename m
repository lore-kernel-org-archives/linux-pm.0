From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/11] PM: add a per-device wake-up latency
	constraints plist
Date: Sat, 2 Jul 2011 21:39:51 +0200
Message-ID: <201107022139.51579.rjw__43367.0559236363$1309635579$gmane$org@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1309446685-17502-2-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add the field wakeup_lat_plist_head in the struct dev_pm_info
> and the initialization of the plist in device_pm_init.
> 
> This enables the implementation of per-device constraints in
> PM QoS.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/base/power/main.c |    3 +++
>  include/linux/pm.h        |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index aa632020..b1fd96b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -96,6 +96,8 @@ void device_pm_add(struct device *dev)
>  			dev_name(dev->parent));
>  	list_add_tail(&dev->power.entry, &dpm_list);
>  	mutex_unlock(&dpm_list_mtx);
> +	/* ToDo: call PM QoS to init the per-device wakeup latency constraints */
> +	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
>  }
>  
>  /**
> @@ -106,6 +108,7 @@ void device_pm_remove(struct device *dev)
>  {
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
> +	/* ToDo: call PM QoS to de-init the per-device wakeup latency constraints */
>  	complete_all(&dev->power.completion);
>  	mutex_lock(&dpm_list_mtx);
>  	list_del_init(&dev->power.entry);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 3160648..35fe682 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -22,6 +22,7 @@
>  #define _LINUX_PM_H
>  
>  #include <linux/list.h>
> +#include <linux/plist.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> @@ -462,6 +463,7 @@ struct dev_pm_info {
>  	unsigned long		accounting_timestamp;
>  	void			*subsys_data;  /* Owned by the subsystem. */
>  #endif
> +	struct plist_head	wakeup_lat_plist_head;
>  };

Please use a better name.  I mean, relly, the type implies that this is a
plist head, so that doesn't need to appear in the field name too.  Also,
the name is confusing, because "wakeup" may mean a couple of different things
and it's not entirely clear what "lat" stands for.  So, I'd prefer something
like

+	struct plist_head	latency_constraints;

or perhaps you can invent something even better.

>  
>  extern void update_pm_runtime_accounting(struct device *dev);
> 

Thanks,
Rafael
