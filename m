From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up
	(rev. 3)
Date: Mon, 30 Jun 2008 12:19:01 +0200
Message-ID: <200806301219.02189.rjw__23944.0862475478$1214821261$gmane$org@sisk.pl>
References: <200806270022.24496.rjw@sisk.pl> <200806280240.13939.rjw@sisk.pl>
	<1214791528.26947.12.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1214791528.26947.12.camel@yakui_zhao.sh.intel.com>
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
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 of June 2008, Zhao Yakui wrote:
> On Sat, 2008-06-28 at 02:40 +0200, Rafael J. Wysocki wrote:
> > On Friday, 27 of June 2008, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>

> > @@ -107,10 +113,15 @@ void acpi_disable_wakeup_device(u8 sleep
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  		    container_of(node, struct acpi_device, wakeup_list);
> > +		struct device *ldev;
> > +		bool wakeup_enabled;
> >  
> >  		if (!dev->wakeup.flags.valid)
> >  			continue;
> > -		if (!dev->wakeup.state.enabled ||
> > +		ldev = acpi_get_physical_device(dev->handle);
> > +		wakeup_enabled = dev->wakeup.state.enabled ||
> > +			(ldev ? device_may_wakeup(ldev) : false);
> > +		if (!wakeup_enabled ||
> >  		    sleep_state > (u32) dev->wakeup.sleep_state) {
> >  			if (dev->wakeup.flags.run_wake) {
> >  				spin_unlock(&acpi_device_lock);
> It seems that the device_init_wakeup(dev,1) will be called in many
> drivers regardless of userspace, which will enable the corresponding
> GPE. Maybe some laptops will be resumed immediately from the sleeping
> state.
> 
> Is it more reasonable that default state is set as "wake-up disabled" in
> driver and userspace can change it from "disabled" to "enabled"?

Yes, it is, IMO.

One possible way to make it happen is to modify device_init_wakeup() so that
it always clears power.should_wakeup.

Still, that may lead to functional "regressions", ie. if we do that, some
people will have to manually write "enable" to /sys/devices/.../power/wakeup to
make their usual wake-up devices work.

Either way, there is possibility of breaking something.

Thanks,
Rafael
