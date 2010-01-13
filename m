From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] [RFC] firewire: Add ohci1394 PCI runtime
	power	management support
Date: Wed, 13 Jan 2010 14:33:12 +0000
Message-ID: <20100113143312.GA21292__37868.5728683651$1263393267$gmane$org@srcf.ucam.org>
References: <1263336982-15424-1-git-send-email-mjg@redhat.com>
	<4B4D1A2F.4020103@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B4D1A2F.4020103@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 13, 2010 at 01:56:15AM +0100, Stefan Richter wrote:
> Matthew Garrett wrote:
> > For sanity purposes, the code ensures that the phy is recent enough to
> > implement the required functionality. It also ensures that all ports have
> > the interrupt enabled - a VIA chip I've tested appears to only allow
> > int_enable to be set on one port at a time, which is inadequate for the
> > purposes of this code.
> 
> This adds more extensive use of the link--PHY interface than we ever
> had, and FireWire stacks in other popular OSs may not have used these
> features yet too.  We will most certainly discover further errata
> besides the one that you already found.

I don't doubt it. There's almost certainly serious dragons here on some 
hardware.

> > This depends on the PCI runtime PM code, which is not yet upstream. I'm
> > sending this out now for sanity checking.
> 
> Is there a convenient source where I can get the infrastructure, so that
> I could start testing with the few cards that I have?

Rafael posted the latest set to linux-acpi on the 27th of December. I 
don't think there's a set online yet.

> Besides the danger of regressions due to hardware bugs, there is also
> the cost in terms of code footprint.  Therefore it would be very good if
> measurements of actual effects on energy consumption could be obtained.

Sure. I'll try to do the measurements today.

> >  
> >  	reg_write(ohci, OHCI1394_PhyControl, OHCI1394_PhyControl_Read(addr));
> 
> ...the read and write "transactions" on OHCI1394_PhyControl need to be
> serialized with a lock or mutex now.  This means the simple read/ write
> operations and also the combined read--update operations or combined
> page-select--read-page operations.
> 
> (Of course your implementation requires a spinlock rather than a mutex,
> for now.)

Right. I'll add that.

> > +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
> > +		*val = reg_read(ohci, OHCI1394_PhyControl);
> > +		if (*val & OHCI1394_PhyControl_ReadDone)
> > +			break;
> > +		mdelay(1);
> > +	}
> 
> Gone is the msleep, here comes the mdelay.  I suspect all that can be
> implemented in a non-atomic context, can't it?  I.e. tasklet ->
> worklet...  May possibly require to convert the bus reset tasklet to a
> worklet too, which may have a few benefits on its own right.

Yeah, that might well be a bonus. The phy accesses should only be at 
startup or in response to a bus reset or cable connection state change, 
so I wouldn't have thought that there'd be any noticable performance 
impact. I'll look at changing it in a followup patch.

> Furthermore, these polling loops --- at least the ones after a
> reg_write(..., OHCI1394_PhyControl_Read(..)) --- could then be replaced
> by an interrupt driven mechanism.  (Except in those usages of
> ohci_update_phy_reg() when we do not have interrupts enabled.)

Oh, ok - I hadn't realised there was an interrupt to indicate that.

> On OHCI_LOOP_COUNT:  Don't use this one.  IMO this is only obuscation.
> Its current single use in firewire-ohci should be eliminated as well,
> and that one is unrelated to PHY control.  And even the new PHY control
> related loops may perhaps want different loop counts.
>
> Furthermore, 500 times mdelay(1) as worst case sounds suboptimal.  If
> this is converted into nonatomic context, timeouts this large will be
> more acceptable.

This was just copied from the old ieee1394 ohci code when I was seeing 
some odd phy behaviour. I've since worked out that this was due to me 
misunderstanding the specs, so I suspect it'd work fine with the old 
code (well, s/sleep/delay/).
 
> > +		  OHCI1394_PhyControl_Write(addr, r));
> > +
> > +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
> > +		r = reg_read(ohci, OHCI1394_PhyControl);
> > +		if (!(r & OHCI1394_PhyControl_WriteDone))
> > +			break;
> > +	}
> 
> Forgot an mdelay?

I wondered about that, but there wasn't one in the ieee1394 code. 
Presumably the register reads take long enough that it settles within 
the loop count?

> > +	for (i = 0; i < total_ports; i++) {
> > +		ohci_read_port_reg(card, i, 0, &val);
> > +		if (val & 0x04)
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> This is a somewhat costly check.  Its two call sites should be examined
> whether there is other information available that tells us whether ports
> are connected.  For example...

It's certainly not entirely optimal.

> > +out:
> > +	if (!ohci_port_is_connected(&ohci->card))
> > +		pm_schedule_suspend(ohci->card.device, 1000);
> > +
> > +	return;
> >  }
> 
> ...if we have a valid self ID buffer here, and if we previously
> determined how many self IDs the local PHY itself generates (in practice
> only one, in theory up to three), then we can cheaply check by means of
> self_id_count whether anything is attached.

And if we don't, we fall back to the check? That'd work.

> [BTW, some cards may actually have a second PHY hardwired to the PHY
> which is attached to the link.  For example, Mac Pro have a second PHY
> for the front panel ports.  But your approach is unable to figure that
> out either.  And it doesn't matter because battery powered devices do
> not have more than one PHY per link.]

Hrm. That's potentially a problem. Will this always show up as a 
connection being present on the first PHY? If so it'll just effectively 
disable the power management, which isn't ideal but at least doesn't 
break anything.

> > +
> > +	if (ohci_read_phy_reg(card, 2, &val))
> > +		return -EBUSY;
> 
> Since its caller does not check for error return,
> ohci_configure_wakeup() can just return void.

Hm. Should probably actually check the return value instead.

> >  		  OHCI1394_cycle64Seconds | OHCI1394_regAccessFail |
> > -		  OHCI1394_masterIntEnable);
> > +		  OHCI1394_masterIntEnable | OHCI1394_phy);
> 
> This warrants a little addition in our goophy debug logging section, see
> log_irqs() at the top pf ohci.c.

Ok.

> >  	reg_write(ohci, OHCI1394_ConfigROMhdr, 0);
> > +
> >  	reg_write(ohci, OHCI1394_BusOptions,
> >  		  be32_to_cpu(ohci->next_config_rom[2]));
> >  	reg_write(ohci, OHCI1394_ConfigROMmap, ohci->next_config_rom_bus);
> 
> What's this blank line for? :-)

Oops - left over from debug code.

> > +	.poweroff = ohci_pci_suspend,
> > +	.runtime_suspend = ohci_pci_runtime_suspend,
> > +	.runtime_resume = ohci_pci_resume,
> > +	.runtime_idle = ohci_pci_runtime_idle,
> > +};
> 
> Obligatory whitespace nitpick :-) --- Look how nicely krh aligned his code:

Heh, ok.

> Thanks for working on this.  Considering how often FireWire equipped
> notebooks are used with the 1394 drivers loaded but the port unused all
> day, this may be a worthwile enhancement.

Yeah, I realised that working on this is the first time I've ever 
plugged a firewire cable into anything...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
