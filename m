From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Date: Mon, 22 Oct 2018 08:06:26 +0200
Message-ID: <CAJZ5v0h65cYvR9+7PmrDDMazuUE4_vbgF7R1rrosbTEaX=UhMg@mail.gmail.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181019152105.0325a663@endymion> <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
Sender: stable-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 20, 2018 at 6:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 19, 2018 at 03:21:05PM +0200, Jean Delvare wrote:
> > On Thu, 18 Oct 2018 15:30:38 +0300, Jarkko Nikula wrote:
> > > Allow PCI core to do runtime PM to devices without needing to use dummy
> > > runtime PM callback functions if there is no need to do anything device
> > > specific beyond PCI device power state management.
> > >
> > > Implement this by letting core to change device power state during
> > > runtime PM transitions even if no callback functions are defined.
> >
> > Thank you very much for looking into this and providing a fix.
> >
> > > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > ---
> > > This is related to my i2c-i801.c fix thread back in June which I completely
> > > forgot till now: https://lkml.org/lkml/2018/6/27/642
> > > Discussion back then was that it should be handled in the PCI PM instead
> > > of having dummy functions in the drivers. I wanted to respin with a
> > > patch.
> > > ---
> > >  drivers/pci/pci-driver.c | 16 ++++++----------
> > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index bef17c3fca67..6185b878ede1 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
> > >     struct pci_dev *pci_dev = to_pci_dev(dev);
> > >     const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > >     pci_power_t prev = pci_dev->current_state;
> > > -   int error;
> > > +   int error = 0;
> > >
> > >     /*
> > >      * If pci_dev->driver is not set (unbound), we leave the device in D0,
> > > @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
> > >             return 0;
> > >     }
> > >
> > > -   if (!pm || !pm->runtime_suspend)
> > > -           return -ENOSYS;
> > > -
> > >     pci_dev->state_saved = false;
> > > -   error = pm->runtime_suspend(dev);
> > > +   if (pm && pm->runtime_suspend)
> > > +           error = pm->runtime_suspend(dev);
> > >     if (error) {
> > >             /*
> > >              * -EBUSY and -EAGAIN is used to request the runtime PM core
> >
> > Later in this function, pm is dereferenced again. It happens twice in
> > the "if (error)" condition where it is currently safe (error can't be
> > non-zero if pm->runtime_suspend() has not been called, and obviously
> > pm->runtime_suspend() can't have been called if pm was NULL). However
> > it also happens later without the condition:
> >
> >       if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> >           && pci_dev->current_state != PCI_UNKNOWN) {
> >               WARN_ONCE(pci_dev->current_state != prev,
> >                       "PCI PM: State of device not saved by %pF\n",
> >                       pm->runtime_suspend);
> >               return 0;
> >       }
> >
> > I am no expert of the PM framework but is there no risk to dereference
> > NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
> > be NULL, leading to a confusing warning message?
> >
> > More generally, I would feel better if instead of initializing error to
> > 0, we would move under the "if (pm && pm->runtime_suspend)" condition
> > everything that must not be run if pm->runtime_suspend is not defined.
> > That would make the possible code flows a lot clearer.
>
> I agree, this isn't good.  Even if it's safe (and I don't think that
> second spot is safe), it's too hard to analyze.  I'm going to drop
> this for now.

Yeah, sorry for missing this.

[Note to self: be more careful with patch reviews in the future.]

Cheers,
Rafael
