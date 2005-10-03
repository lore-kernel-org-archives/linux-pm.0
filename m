From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2/3] Runtime PM support for named power states
Date: Mon, 03 Oct 2005 11:14:06 -0700
Message-ID: <20051003181406.06C97EE8D4@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509301616200.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97100329570209798=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301616200.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============97100329570209798==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In the PCI init:

> @@ -589,7 +673,6 @@ static void pci_read_irq(struct pci_dev 
>  static int pci_setup_device(struct pci_dev * dev)
>  {
>  	u32 class;
> -	u16 pm;
>  
>  	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
>  		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> @@ -617,19 +700,7 @@ static int pci_setup_device(struct pci_d
>  		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
>  		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
>  		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
> -
> -		/* PCI PM capable devices may be able to issue PME# (wakeup) */
> -		pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> -		if (pm) {
> -			pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);

It's worth noting that Andrew has run into problems with that bit of
the wakeup patch ... it seems that some PPC systems (G5?) get unhappy.

It's not a general "can't read capabilities" issue, since that was done
in pci_cfg_space_size() shortly before pci_setup_device() gets called.

Though it's unclear to me (G5-less) whether that's an issue with that
patch or with some other PPC changes.  There was some mainline breakage
for PPC reported at the same time, which could easily be the same issue;
someone with a G5 should investigate.  (Benjamin?  Or maybe Paul, who
ISTR was reworking PPC support for PCI.)


> -			if (pm & PCI_PM_CAP_PME_MASK)
> -				device_init_wakeup(&dev->dev, 1);
> -
> -			/* REVISIT: if (pm & PCI_PM_CAP_PME_D3cold) then
> -			 * pci pm spec 1.2, section 3.2.4 says we should
> -			 * init PCI_PM_CTRL_PME_{STATUS,ENABLE} ...
> -			 */
> -		}
> +		pci_setup_device_pm(dev);
>  		break;
>  
>  	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */


And in the USB PCI glue:

> @@ -261,19 +262,23 @@ int usb_hcd_pci_suspend (struct pci_dev 
>  		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
>  		 * some device state (e.g. as part of clock reinit).
>  		 */
> -		retval = pci_set_power_state (dev, PCI_D3hot);
> +		if (message.event == PM_EVENT_RUNTIME)
> +			level = pci_name_to_state (message.name);
> +		retval = pci_set_power_state (dev, level);
>  		if (retval == 0) {
> -			dev_dbg (hcd->self.controller, "--> PCI D3\n");
> +			dev_dbg (hcd->self.controller, "--> PCI %s\n",
> +					pci_state_to_name (level));
>  
>  			/* Ignore these return values.  We rely on pci code to
>  			 * reject requests the hardware can't implement, rather
>  			 * than coding the same thing.
>  			 */
> +			/* FIXME: Do we want these for runtime PM? */

Actually, the line below should use "level" not "PCI_D3hot", since the
reason to enable wake from D3hot is that D3hot was the target state.

And if the target isn't D3hot, it may not be necessary to enable wake
from D3cold ... the reason to enable wake from D3cold is that it's
not currently knowable if system suspend is going to morph the D3hot
into a D3cold.

IMO it's probably fair to ignore D3cold except if the target is D3hot.

>  			(void) pci_enable_wake (dev, PCI_D3hot, hcd->remote_wakeup);
>  			(void) pci_enable_wake (dev, PCI_D3cold, hcd->remote_wakeup);
>  		} else {
> -			dev_dbg (&dev->dev, "PCI D3 suspend fail, %d\n",
> -					retval);
> +			dev_dbg (&dev->dev, "PCI %s suspend fail, %d\n",
> +					pci_state_to_name (level), retval);
>  			(void) usb_hcd_pci_resume (dev);
>  		}
>  
>


- Dave





--===============97100329570209798==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97100329570209798==--
