From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Mon, 12 May 2008 16:52:55 +0200
Message-ID: <200805121652.56002.rjw__12722.6545046598$1210604216$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
	<200805092344.53713.rjw@sisk.pl> <20080512140013.GC1725@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080512140013.GC1725@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 12 of May 2008, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The new suspend and hibernation callbacks introduced with
> > 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> > pm_message_t argument, so the drivers using them will not be able
> > to use pci_choose_state() in its present form.  For this reason,
> > introduce a new function, pci_choose_and_set_state(), playing the
> > role of pci_choose_state() combined with pci_set_power_state() and
> > allowing the driver to put the device into a power state chosen by
> > the platform.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pci.c   |   46 +++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/pci.h |    1 +
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/pci/pci.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pci.c
> > +++ linux-2.6/drivers/pci/pci.c
> > @@ -509,7 +509,51 @@ pci_set_power_state(struct pci_dev *dev,
> >  }
> >  
> >  pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
> > - 
> > +
> > +/**
> > + * pci_choose_and_set_state - Choose the power state of a PCI device and put
> > + *                            the device into that state.
> > + * @dev: PCI device to be put into a low power state
> > + * @state: State to put the device into by default
> > + *
> > + * Use the platform driver to choose the preferred PCI power state of given
> > + * device and put the device into that state.  If the target power state of
> > + * the device cannot be chosen using the platform driver, the driver-provided
> > + * @state is used.
> > + *
> > + * RETURN VALUE:
> > + * -EINVAL if trying to enter a lower state than we're already in.
> > + * 0 if we're already in the requested state.
> > + * -EIO if device does not support PCI PM.
> > + * 0 if we can successfully change the power state.
> > + */
> > +
> > +int pci_choose_and_set_state(struct pci_dev *dev, pci_power_t state)
> > +{
> 
> > +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > +		return -EIO;
> 
> Hmm, not sure if this is good idea. First, simple drivers will just
> ignore the return value,

That doesn't matter to us.

> and second, it returns -EIO even if I'm 
> asking it to enter state it already has -- like PCI_D0 -- no?

The -EIO means the operation could not be carried out, whatever the driver
author meant.  In particular, we wouldn't check what the current state of the
device was, so why would we return anything other than error code?

Thanks,
Rafael
