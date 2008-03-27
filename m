From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks (rev. 4)
Date: Wed, 26 Mar 2008 23:09:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803262305580.21714-100000__47122.1666237854$1206587500$gmane$org@netrider.rowland.org>
References: <200803270212.36465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803270212.36465.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Mar 2008, Rafael J. Wysocki wrote:

> @@ -68,22 +75,32 @@ int device_pm_add(struct device *dev)
>  		 dev->bus ? dev->bus->name : "No Bus",
>  		 kobject_name(&dev->kobj));
>  	mutex_lock(&dpm_list_mtx);
> -	if ((dev->parent && dev->parent->power.sleeping) || all_sleeping) {
> -		if (dev->parent->power.sleeping)
> -			dev_warn(dev,
> -				"parent %s is sleeping, will not add\n",
> +	if (dev->parent) {
> +		if (dev->parent->power.status >= DPM_SUSPENDING) {
> +			dev_warn(dev, "parent %s is sleeping, will not add\n",
>  				dev->parent->bus_id);

You forgot to check for dev->parent->power.status == DPM_INVALID.

Alan Stern
