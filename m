From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 10:24:52 -0700
Message-ID: <200805091024.53027.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
	<200805090947.08620.jbarnes@virtuousgeek.org>
	<200805091913.40197.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805091913.40197.rjw@sisk.pl>
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

On Friday, May 09, 2008 10:13 am Rafael J. Wysocki wrote:
> > So why not make platform_pci_choose_state do:
> > + pci_power_t noacpi_pci_choose_state(struct pci_dev *dev, pci_message_t
> > state)
> > + {
> > +       if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > +               return state;
> > + }
> >
> > instead?  Then in the PCI core we would assign either
> > platform_pci_choose_state to acpi_pci_choose_state or
> > noacpi_pci_choose_state
>
> Good idea.
>
> > (though that's a bad name).
>
> Does generic_pci_choose_state() sound better?

Yeah, that's better.

> > But really, since drivers should probably know what power state to put
> > their devices in for suspend & hibernate, maybe on non-ACPI systems the
> > function should just return an error and the driver can choose...
>
> That's one possibility too, but in that case many drivers will do
>
> state = pci_preferred_state(dev);
> if (state == PCI_POWER_ERROR)
> 	state = something;
>
> It's just shorter to write
>
> state = pci_preferred_state(dev, something);

But really that's the idea, since if the core doesn't know what state your 
device should be in (and in many non-ACPI cases I'd argue that to be true) 
your driver should be picking something sensible.  After all, states other 
than D0 and D3 are really device dependent, right?

One way to avoid some ugliness like you show above would be:

device_suspend(...)
{
  ...
  state = PCI_D3hot;
  pci_choose_state(dev, pm_state, &state);
  pci_set_power_state(dev, state);
  ...
}

So in this case pci_choose_state would either change state or leave it 
untouched if it didn't have a better idea about things.  But now that I look 
at it I'm not sure it's an improvement. :)

Jesse
