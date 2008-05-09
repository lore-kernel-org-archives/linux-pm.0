From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 09:47:08 -0700
Message-ID: <200805090947.08620.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
	<200805072032.58472.rjw@sisk.pl> <200805091744.04749.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805091744.04749.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > > > I thought about that too.  I'd like to know what the other people
> > > > think, though.
> > >
> > > The point of this isn't at all clear.
> > >
> > > Is this routine meant to be called during a hibernation
> > > transition?
> >
> > Yes, it is.
> >
> > > Or is it just for suspend?
> > >
> > > And why would the return value ever be anything other than D3_hot?  (Or
> > > why would the driver ever want to put a device in a different state?)
> >
> > In principle, the driver may want to put the device into a state having
> > shorter wake up latency than D3_hot.
> >
> > > AFAICS, the only reason would be because platform_pci_choose_state()
> > > suggested something else.  In which case there's no need for the
> > > "policy" argument.
> >
> > There is a need in two cases:
> > - if platform_pci_choose_state() is not defined (it only is defined for
> > ACPI systems at the moment),
> > - if platform_pci_choose_state() returns PCI_POWER_ERROR meaning that it
> > cannot handle the device.
> >
> > I agree with Pavel that the driver could pass a "fallback state" as a
> > second argument to be used in case the platform cannot provide it with
> > one.
>
> Modified patch follows.

So why not make platform_pci_choose_state do:
+ pci_power_t noacpi_pci_choose_state(struct pci_dev *dev, pci_message_t 
state)
+ {
+       if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+               return state;
+ }

instead?  Then in the PCI core we would assign either 
platform_pci_choose_state to acpi_pci_choose_state or noacpi_pci_choose_state 
(though that's a bad name).

But really, since drivers should probably know what power state to put their 
devices in for suspend & hibernate, maybe on non-ACPI systems the function 
should just return an error and the driver can choose...

Jesse
