From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 2/3] Runtime PM support for named power states
Date: Mon, 3 Oct 2005 11:19:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510031057170.4824-100000@iolanthe.rowland.org>
References: <20051002204142.GB2239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============049284785404085873=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051002204142.GB2239@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============049284785404085873==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 2 Oct 2005, Pavel Machek wrote:

> Hi!
> 
> > Index: usb-2.6/drivers/pci/probe.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/pci/probe.c
> > +++ usb-2.6/drivers/pci/probe.c
> > @@ -22,6 +22,54 @@ EXPORT_SYMBOL(pci_root_buses);
> >  
> >  LIST_HEAD(pci_devices);
> >  
> > +const char pci_name_D0[] = "D0";
> > +const char pci_name_D1[] = "D1";
> > +const char pci_name_D2[] = "D2";
> > +const char pci_name_D3[] = "D3";
> 
> Why not "D3hot"? And what about "D3cold"?

I considered these questions while writing the patch.  Not being entirely 
certain of the correct answers, I just kept things simple for now.

These names refer to device power-states in a running system.  Isn't it 
true that as long as the system is awake, PCI devices can go into D3hot 
but not D3cold?  If it is true, we might as well just call the state "D3".
Note that the pci_set_power_state() routine won't permit states beyond 
D3hot...

On the other hand, it occurred to me later that a more complete set of
names might be useful so that the pci_state_to_name routine could use
them.  And it would be desirable for pci_name_to_state to recognize all
the possible outputs from pci_state_to_name.

Remember, this patch was a first-pass, show-that-it-can-be-done sort of 
thing.

> > +/**
> > + * pci_state_to_name -- return a static name string for a power state
> > + * @state: power state to convert
> > + */
> > +const char *pci_state_to_name(pci_power_t state)
> > +{
> > +	static const char *(names[]) = {
> > +		pci_name_D0, pci_name_D1, pci_name_D2,
> > +		"D3hot", "D3cold", "Unknown"};
> 
> } should go on separate line.

Okay.

> > +	int i = (int __force) state;
> > +
> > +	if (i < 0 || i >= sizeof(names) / sizeof(names[0]))
> > +		return "Error";
> 
> Why the "Unknown" in the array, then?

Because this function looked like it might end up being more generally 
useful for PCI drivers, and the list of all pci_power_t values includes 
PCI_UNKNOWN as well as PCI_POWER_ERROR.

One of the weaknesses of this patch is that the current power state, as
stored in pcidev->dev.power.power_state.name, is not closely tied to the
value stored in pcidev->current_state.


> > @@ -109,6 +117,7 @@ struct pci_dev {
> >  	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
> >  					   this is D0-D3, D0 being fully functional,
> >  					   and D3 being off. */
> > +	const char	*(states[5]);	/* Names for supported states */
> 
> That constant looks strange here...

It does.  We can change it.  The idea was that this is a null-terminated 
array which might have to hold entries for up to four PCI power states.  
Therefore five array slots are pre-allocated.

Another possible improvement would be to make the new fields dependent 
on CONFIG_PM.  I didn't do it in order to keep the patches simple and to 
avoid adding preprocessor conditionals in the middle of subroutines.

Alan Stern


--===============049284785404085873==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============049284785404085873==--
