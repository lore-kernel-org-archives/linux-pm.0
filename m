From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce
	acpi_pm_device_sleep_wake function
Date: Wed, 25 Jun 2008 20:57:46 +0200
Message-ID: <200806252057.47869.rjw__37236.4493007355$1214420429$gmane$org@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl>
	<1214381467.3001.173.camel@rzhang-dt.sh.intel.com>
	<1214389766.9800.106.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1214389766.9800.106.camel@yakui_zhao.sh.intel.com>
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

On Wednesday, 25 of June 2008, Zhao Yakui wrote:
> On Wed, 2008-06-25 at 16:11 +0800, Zhang Rui wrote:
> > Hi, Rafael,
> > 
> > On Fri, 2008-06-20 at 01:51 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > PCI ACPI: Introduce acpi_pm_device_sleep_wake function
> > > 
> > > Introduce function acpi_pm_device_sleep_wake() for enabling and
> > > disabling the system wake-up capability of devices that are power
> > > manageable by ACPI.
> > > 
> > > Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
> > > for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().
> > 
> > acpi_pm_device_sleep_wake only enable/disable the power of wakeup
> > device, right?
> > If it doesn't set the acpi_device->wakeup.state.enabled, the wake up GPE
> > will not be enabled, which means the pci devices which have invoked
> > platform_pci_sleep_wake(dev, true) can not wake up the system as
> > excepted.
> > so this patch won't work. Is this what you want? or do I miss something?
> >From the patch it seems that acpi_dev->wakeup.state.enable is not set in
> >the function of acpi_pm_device_sleep_wake. If it is not set, it means
> >that the corresponding GPE won't be enabled. The device still can't wake
> >up the sleeping system. 

This is a good point, because I forgot about the GPE.

However, it's not my intention to set acpi_device->wakeup.state.enabled in
acpi_pm_device_sleep_wake().  Instead, I'd like to use the
/sys/devices/.../power/wakeup interface and more precisely the
dev->power.should_wakeup flag that is supposed to have been set/unset as
needed _before_ acpi_pm_device_sleep_wake() is called.

Still, I'll need to make the code in drivers/acpi/sleep/wakeup.c enable/disable
the wake-up GPEs for devices that have both dev->power.can_wakeup and
dev->power.should_wakeup set, as though these devices had
acpi_device->wakeup.state.enabled set.

> > But what is annoying me is that,
> > if acpi_device->wakeup.state.enabled is set in
> > acpi_pm_device_sleep_wake, this may bring some other trouble.
> > A lot of pci devices will call platform_pci_sleep_wake(dev, true) by
> > default, they won't wake up the system before because the wake up GPEs
> > are disabled, but they will do if this patch is applied.
> > So some of the users may got the "resume immediately after sleep"
> > problem, that's a regression, isn't it?

That won't happen as long as the devices' dev->power.should_wakeup flags are
not set.

Note that in the most recent series of patches these flags are unset by default
for devices that cannot generate PME#, but there are PCI devices that can
generate both PME# and the ACPI-enabled wake-up events and those devices will
have dev->power.should_wakeup set by default.  Still, if that may cause any
problems, we can unset dev->power.should_wakeup for all devices during
initialization and let the user space set it as desired.

> What Rui said is right. In current kernel when the system enters the
> sleeping state, the pci_enable_wake(dev,state, 1) will be called for the
> PCI device. If acpi_dev->wakeup.state.enabled is set in
> acpi_pm_device_sleep_wake , it means that the wakeup GPE will be
> enabled. Maybe some systems will be resumed immediately after sleeping.
> this is not what we expected.

However, pci_enable_wake() calls device_may_wakeup() and immediately aborts if
that returns 'false', so the user space can control its behavior using the
/sys/devices/.../power/wakeup interface.

> > 
> > we have discussed this a couple of times on the list, but we have not
> > got a solution yet.
> > IMO, both Dave's and your patches are good, and we can be a little
> > aggressive to merge them, and fix the drivers once we get any
> > regressions ASAP.
> As the acpi_dev->wakeup.state.enabled is not touched in this patch, it
> will be OK to merge them. 
> 
> If acpi_dev->wakeup.state.enable is required to be set/unset in
> acpi_pm_device_sleep_wake, maybe Rui's suggestion is good. Unless some
> device is expected to wake up the sleeping system, we will enable the
> corresponding GPE. Otherwise it will be assumed that the device needn't
> wake up the sleeping system and unnecessary to enable the device power
> and the corresponding GPE.
> > i.e. either change pci_enable_wake(dev, 1) to pci_enable_wake(dev, 0) in
> > the drivers suspend method, or invoke  device_set_wakeup_enable(dev, 0)
> > to disable the wakeup ability after the call to device_init_wakeup(dev,
> > 1).
> > 
> > any ideas?

Please see above. :-)

Thanks,
Rafael
