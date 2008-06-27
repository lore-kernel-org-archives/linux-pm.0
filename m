From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up
Date: Fri, 27 Jun 2008 15:26:45 +0200
Message-ID: <200806271526.46932.rjw__28772.1674460501$1214573377$gmane$org@sisk.pl>
References: <200806270022.24496.rjw@sisk.pl> <200806270028.29396.rjw@sisk.pl>
	<1214532498.26388.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1214532498.26388.2.camel@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Zhao,
	Yakui" <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 27 of June 2008, Shaohua Li wrote:
> On Fri, 2008-06-27 at 06:28 +0800, Rafael J. Wysocki wrote:
[--snip--]
> > +
> > +       if (pmc & PCI_PM_CAP_PME_MASK) {
> > +               dev_printk(KERN_INFO, &dev->dev,
> > +                       "PME# supported from%s%s%s%s%s\n",
> > +                       (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> > +                       (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> > +                       (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
> > +                       (pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
> > +                       (pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" :
> > "");
> > +               /*
> > +                * Make device's PM flags reflect the wake-up
> > capability, but
> > +                * let the user space enable it to wake up the system
> > as needed.
> > +                */
> > +               device_set_wakeup_capable(&dev->dev, true);
> > +               device_set_wakeup_enable(&dev->dev, false);
> > +               /* Disable the PME# generation functionality */
> > +               pci_pme_active(dev, pm, false);
> > +       }
> >  }
> It appears a lot of drivers will call device_init_wakeup(dev, 1)
> regardless if userspace enable wakeup for the device. Will you fix the
> drivers?

Either fix the drivers, or change device_init_wakeup() so that it doesn't
set power.should_wakeup to the same value as power.can_wakeup, which IMO is
a mistake.

Perhaps it's better to drop device_init_wakeup() altogether.

Thanks,
Rafael
