From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 17:24:57 +0100
Message-ID: <200803271724.59155.rjw__37001.2050997049$1206635239$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803262305580.21714-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803262305580.21714-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, 27 of March 2008, Alan Stern wrote:
> On Thu, 27 Mar 2008, Rafael J. Wysocki wrote:
> 
> > @@ -68,22 +75,32 @@ int device_pm_add(struct device *dev)
> >  		 dev->bus ? dev->bus->name : "No Bus",
> >  		 kobject_name(&dev->kobj));
> >  	mutex_lock(&dpm_list_mtx);
> > -	if ((dev->parent && dev->parent->power.sleeping) || all_sleeping) {
> > -		if (dev->parent->power.sleeping)
> > -			dev_warn(dev,
> > -				"parent %s is sleeping, will not add\n",
> > +	if (dev->parent) {
> > +		if (dev->parent->power.status >= DPM_SUSPENDING) {
> > +			dev_warn(dev, "parent %s is sleeping, will not add\n",
> >  				dev->parent->bus_id);
> 
> You forgot to check for dev->parent->power.status == DPM_INVALID.

Right, will fix.

Thanks,
Rafael
