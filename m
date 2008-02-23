From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel]
 2.6.25-rc2 System no longer powers off aftersuspend-to-disk. Screen becomes
 green.)
Date: Fri, 22 Feb 2008 17:00:06 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802221653000.21332__24658.0306128182$1203728536$gmane$org@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211713.20713.jesse.barnes@intel.com>
	<200802211744.35563.jesse.barnes@intel.com>
	<200802230031.20292.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802230031.20292.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org



On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:

> --- linux-2.6.orig/drivers/char/drm/i915_drv.c
> +++ linux-2.6/drivers/char/drm/i915_drv.c
> @@ -222,6 +222,7 @@ static void i915_restore_vga(struct drm_
>  			   dev_priv->saveGR[0x18]);
>  
>  	/* Attribute controller registers */
> +	inb(st01);
>  	for (i = 0; i < 20; i++)
>  		i915_write_ar(st01, i, dev_priv->saveAR[i], 0);
>  	inb(st01); /* switch back to index mode */

I'm doing this part separately, please drop it - it has nothing to do with 
the rest of the patch.

I'd also suggest that you just add a helper function like

	int pm_event_powerdown(struct pm_message mesg)
	{
		return mesg.event >= PM_EVENT_SUSPEND;
	}

or something, so that you can have code like

	if (pm_event_powerdown(mesg))
		pci_set_power_state(pdev, PCI_D3hot);

instead of the test for EVENT_SUSPEND/HIBERNATE explicitly.

Of course, the places that already do a switch-statement are much better 
kept that way and just add PM_EVENT_HIBERNATE to the list.

> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -554,6 +554,7 @@ pci_power_t pci_choose_state(struct pci_
>  	case PM_EVENT_PRETHAW:
>  		/* REVISIT both freeze and pre-thaw "should" use D0 */
>  	case PM_EVENT_SUSPEND:
> +	case PM_EVENT_HIBERNATE:
>  		return PCI_D3hot;

Didn't you miss the apci_pci_choose_state() thing that also needs this 
extension?

> Index: linux-2.6/drivers/usb/host/u132-hcd.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/host/u132-hcd.c
> +++ linux-2.6/drivers/usb/host/u132-hcd.c
> @@ -3214,14 +3214,18 @@ static int u132_suspend(struct platform_
>                  return -ESHUTDOWN;
>          } else {
>                  int retval = 0;
> -                if (state.event == PM_EVENT_FREEZE) {
> +
> +		switch (state.event) {
> +		case PM_EVENT_FREEZE:
>                          retval = u132_bus_suspend(hcd);
> -                } else if (state.event == PM_EVENT_SUSPEND) {
> +			break;
> +		case PM_EVENT_SUSPEND:
> +		case PM_EVENT_HIBERNATE:
>                          int ports = MAX_U132_PORTS;
>                          while (ports-- > 0) {
>                                  port_power(u132, ports, 0);
>                          }
> -                }
> +			break;
>                  if (retval == 0)
>                          pdev->dev.power.power_state = state;
>                  return retval;

Looks like a missing close-brace to me there - you removed the final '}'.

Or am I blind?

Apart from those issues it looks fine to me.

			Linus
