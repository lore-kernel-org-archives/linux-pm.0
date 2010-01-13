From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] [RFC] firewire: Add ohci1394 PCI runtime
 power management support
Date: Wed, 13 Jan 2010 01:56:15 +0100
Message-ID: <4B4D1A2F.4020103__41993.1180695587$1263344257$gmane$org@s5r6.in-berlin.de>
References: <1263336982-15424-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263336982-15424-1-git-send-email-mjg@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> OHCI firewire controllers with 1394a or later phys support the generation
> of PMEs from D3hot when a cable is connected or disconnected. This patch
> adds support for enabling this functionality, along with hooking it into
> the PCI runtime PM framework. The device will be kept awake if a cable
> is connected to any of its ports, and put to sleep if no connection is
> present.

Looks good at a quick glance, though there may be room for optimization.

> For sanity purposes, the code ensures that the phy is recent enough to
> implement the required functionality. It also ensures that all ports have
> the interrupt enabled - a VIA chip I've tested appears to only allow
> int_enable to be set on one port at a time, which is inadequate for the
> purposes of this code.

This adds more extensive use of the link--PHY interface than we ever
had, and FireWire stacks in other popular OSs may not have used these
features yet too.  We will most certainly discover further errata
besides the one that you already found.

> This depends on the PCI runtime PM code, which is not yet upstream. I'm
> sending this out now for sanity checking.

Is there a convenient source where I can get the infrastructure, so that
I could start testing with the few cards that I have?

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/firewire/ohci.c |  283 +++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 238 insertions(+), 45 deletions(-)

Besides the danger of regressions due to hardware bugs, there is also
the cost in terms of code footprint.  Therefore it would be very good if
measurements of actual effects on energy consumption could be obtained.

Chipsets which are popular on notebook motherboards (Ricoh, Agere and
some others) and ExpressCards (TI, Agere, ?) would be the ones that
should get special consideration.  Chipsets that are common on CardBus
cards (VIA, NEC, TI, ...?) coud also be looked at.

I for one can't measure it for the time being; I currently only have a
desktop PC (with CardBus slot but far too many energy hungry components)
and a Mac mini (well, that one could be somewhat useful) and no
precision instruments.

> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index a61571c..3f90de9 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -35,6 +35,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  
> @@ -184,6 +185,7 @@ struct fw_ohci {
>  	dma_addr_t self_id_bus;
>  	__le32 *self_id_cpu;
>  	struct tasklet_struct bus_reset_tasklet;
> +	struct tasklet_struct phy_tasklet;

Until now, only the controller startup/ shutdown code, firewire-core's
bus manager worklet, firewire-core's config ROM changing code, and
firewire-core's userspace interface's (cdev) bus reset routine accessed
the PHY control register.  There was already some concurrency, but more
one a hypothetical level.  Now that there is also a PHY event tasklet
using that register, we will inevitably get real concurrency. Therefore...

>  	int node_id;
>  	int generation;
>  	int request_generation;	/* for timestamping incoming requests */
> @@ -217,6 +219,8 @@ struct fw_ohci {
>  	u64 ir_context_channels;
>  	u32 ir_context_mask;
>  	struct iso_context *ir_context_list;
> +
> +	bool runtime_pm;
>  };
>  
>  static inline struct fw_ohci *fw_ohci(struct fw_card *card)
> @@ -452,25 +456,81 @@ static inline void flush_writes(const struct fw_ohci *ohci)
>  	reg_read(ohci, OHCI1394_Version);
>  }
>  
> -static int ohci_update_phy_reg(struct fw_card *card, int addr,
> -			       int clear_bits, int set_bits)
> +static int ohci_read_phy_reg(struct fw_card *card, int addr, u32 *val)
>  {
>  	struct fw_ohci *ohci = fw_ohci(card);
> -	u32 val, old;
> +	int i;
>  
>  	reg_write(ohci, OHCI1394_PhyControl, OHCI1394_PhyControl_Read(addr));

...the read and write "transactions" on OHCI1394_PhyControl need to be
serialized with a lock or mutex now.  This means the simple read/ write
operations and also the combined read--update operations or combined
page-select--read-page operations.

(Of course your implementation requires a spinlock rather than a mutex,
for now.)

>  	flush_writes(ohci);
> -	msleep(2);
> -	val = reg_read(ohci, OHCI1394_PhyControl);
> -	if ((val & OHCI1394_PhyControl_ReadDone) == 0) {
> -		fw_error("failed to set phy reg bits.\n");
> +
> +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
> +		*val = reg_read(ohci, OHCI1394_PhyControl);
> +		if (*val & OHCI1394_PhyControl_ReadDone)
> +			break;
> +		mdelay(1);
> +	}

Gone is the msleep, here comes the mdelay.  I suspect all that can be
implemented in a non-atomic context, can't it?  I.e. tasklet ->
worklet...  May possibly require to convert the bus reset tasklet to a
worklet too, which may have a few benefits on its own right.

But this atomic -> non-atomic conversion could be done later by somebody
else; it shouldn't be seen as a show-stopper.

Furthermore, these polling loops --- at least the ones after a
reg_write(..., OHCI1394_PhyControl_Read(..)) --- could then be replaced
by an interrupt driven mechanism.  (Except in those usages of
ohci_update_phy_reg() when we do not have interrupts enabled.)

On OHCI_LOOP_COUNT:  Don't use this one.  IMO this is only obuscation.
Its current single use in firewire-ohci should be eliminated as well,
and that one is unrelated to PHY control.  And even the new PHY control
related loops may perhaps want different loop counts.

Furthermore, 500 times mdelay(1) as worst case sounds suboptimal.  If
this is converted into nonatomic context, timeouts this large will be
more acceptable.

> +
> +	if (i == OHCI_LOOP_COUNT) {
> +		fw_error("Get PHY Reg timeout [0x%08x/0x%08x/%d]",
> +			 *val, *val & OHCI1394_PhyControl_ReadDone, i);
>  		return -EBUSY;
>  	}
>  
> -	old = OHCI1394_PhyControl_ReadData(val);
> -	old = (old & ~clear_bits) | set_bits;
> +	*val = OHCI1394_PhyControl_ReadData(*val);
> +
> +	return 0;
> +}
> +
> +static int ohci_update_phy_reg(struct fw_card *card, int addr,
> +			       int clear_bits, int set_bits)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	u32 r;
> +	int i;
> +
> +	if (ohci_read_phy_reg(card, addr, &r))
> +		return -EBUSY;
> +
> +	r = (r & ~clear_bits) | set_bits;
>  	reg_write(ohci, OHCI1394_PhyControl,
> -		  OHCI1394_PhyControl_Write(addr, old));
> +		  OHCI1394_PhyControl_Write(addr, r));
> +
> +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
> +		r = reg_read(ohci, OHCI1394_PhyControl);
> +		if (!(r & OHCI1394_PhyControl_WriteDone))
> +			break;
> +	}

Forgot an mdelay?

> +
> +	if (i == OHCI_LOOP_COUNT) {
> +		fw_error("Set PHY Reg timeout [0x%08x/0x%08x/%d]",
> +			 r, r & OHCI1394_PhyControl_WriteDone, i);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ohci_read_port_reg(struct fw_card *card, int port,
> +			      int addr, u32 *val)
> +{
> +	if (ohci_update_phy_reg(card, 7, 0xff, port))
> +		return -EBUSY;
> +
> +	if (ohci_read_phy_reg(card, 8+addr, val))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static int ohci_write_port_reg(struct fw_card *card, int port,
> +			       int addr, int clear_bits, int set_bits)
> +{
> +	if (ohci_update_phy_reg(card, 7, 0xff, port))
> +		return -EBUSY;
> +
> +	if (ohci_update_phy_reg(card, 8+addr, clear_bits, set_bits))
> +		return -EBUSY;
>  
>  	return 0;
>  }
> @@ -1250,6 +1310,45 @@ static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
>  
>  }
>  
> +static int ohci_port_is_connected(struct fw_card *card)
> +{
> +	int i, total_ports;
> +	u32 val;
> +
> +	if (ohci_read_phy_reg(card, 2, &val))
> +		return -EBUSY;
> +
> +	total_ports = val & 0x1f;
> +
> +	for (i = 0; i < total_ports; i++) {
> +		ohci_read_port_reg(card, i, 0, &val);
> +		if (val & 0x04)
> +			return 1;
> +	}
> +
> +	return 0;
> +}

This is a somewhat costly check.  Its two call sites should be examined
whether there is other information available that tells us whether ports
are connected.  For example...

> +
> +static int ohci_clear_port_event(struct fw_card *card)
> +{
> +
> +	return ohci_update_phy_reg(card, 5, 0, 0x04);
> +}
> +
> +static void phy_tasklet(unsigned long data)
> +{
> +	struct fw_ohci *ohci = (struct fw_ohci *)data;
> +	u32 val;
> +
> +	ohci_read_phy_reg(&ohci->card, 5, &val);
> +
> +	if (val & 0x04)
> +		ohci_clear_port_event(&ohci->card);
> +
> +	if (!ohci_port_is_connected(&ohci->card))
> +		pm_schedule_suspend(ohci->card.device, 1000);
> +}
> +
>  static void bus_reset_tasklet(unsigned long data)
>  {
>  	struct fw_ohci *ohci = (struct fw_ohci *)data;
> @@ -1259,14 +1358,17 @@ static void bus_reset_tasklet(unsigned long data)
>  	void *free_rom = NULL;
>  	dma_addr_t free_rom_bus = 0;
>  
> +	/* Cancel any pending suspend requests */
> +	pm_runtime_resume(ohci->card.device);
> +
>  	reg = reg_read(ohci, OHCI1394_NodeID);
>  	if (!(reg & OHCI1394_NodeID_idValid)) {
>  		fw_notify("node ID not valid, new bus reset in progress\n");
> -		return;
> +		goto out;
>  	}
>  	if ((reg & OHCI1394_NodeID_nodeNumber) == 63) {
>  		fw_notify("malconfigured bus\n");
> -		return;
> +		goto out;
>  	}
>  	ohci->node_id = reg & (OHCI1394_NodeID_busNumber |
>  			       OHCI1394_NodeID_nodeNumber);
> @@ -1274,7 +1376,7 @@ static void bus_reset_tasklet(unsigned long data)
>  	reg = reg_read(ohci, OHCI1394_SelfIDCount);
>  	if (reg & OHCI1394_SelfIDCount_selfIDError) {
>  		fw_notify("inconsistent self IDs\n");
> -		return;
> +		goto out;
>  	}
>  	/*
>  	 * The count in the SelfIDCount register is the number of
> @@ -1285,7 +1387,7 @@ static void bus_reset_tasklet(unsigned long data)
>  	self_id_count = (reg >> 3) & 0xff;
>  	if (self_id_count == 0 || self_id_count > 252) {
>  		fw_notify("inconsistent self IDs\n");
> -		return;
> +		goto out;
>  	}
>  	generation = (cond_le32_to_cpu(ohci->self_id_cpu[0]) >> 16) & 0xff;
>  	rmb();
> @@ -1293,7 +1395,7 @@ static void bus_reset_tasklet(unsigned long data)
>  	for (i = 1, j = 0; j < self_id_count; i += 2, j++) {
>  		if (ohci->self_id_cpu[i] != ~ohci->self_id_cpu[i + 1]) {
>  			fw_notify("inconsistent self IDs\n");
> -			return;
> +			goto out;
>  		}
>  		ohci->self_id_buffer[j] =
>  				cond_le32_to_cpu(ohci->self_id_cpu[i]);
> @@ -1318,7 +1420,7 @@ static void bus_reset_tasklet(unsigned long data)
>  	if (new_generation != generation) {
>  		fw_notify("recursive bus reset detected, "
>  			  "discarding self ids\n");
> -		return;
> +		goto out;
>  	}
>  
>  	/* FIXME: Document how the locking works. */
> @@ -1379,6 +1481,11 @@ static void bus_reset_tasklet(unsigned long data)
>  
>  	fw_core_handle_bus_reset(&ohci->card, ohci->node_id, generation,
>  				 self_id_count, ohci->self_id_buffer);
> +out:
> +	if (!ohci_port_is_connected(&ohci->card))
> +		pm_schedule_suspend(ohci->card.device, 1000);
> +
> +	return;
>  }

...if we have a valid self ID buffer here, and if we previously
determined how many self IDs the local PHY itself generates (in practice
only one, in theory up to three), then we can cheaply check by means of
self_id_count whether anything is attached.

Or we can change fw_core_handle_bus_reset to give back a return value
that tells whether only our own self IDs came in.

Of course, self IDs are already at a higher level than the bare port
status, but I think it is still low level enough as a means to trigger
pm_schedule_suspend().

[BTW, some cards may actually have a second PHY hardwired to the PHY
which is attached to the link.  For example, Mac Pro have a second PHY
for the front panel ports.  But your approach is unable to figure that
out either.  And it doesn't matter because battery powered devices do
not have more than one PHY per link.]

>  
>  static irqreturn_t irq_handler(int irq, void *data)
> @@ -1396,6 +1503,9 @@ static irqreturn_t irq_handler(int irq, void *data)
>  	reg_write(ohci, OHCI1394_IntEventClear, event & ~OHCI1394_busReset);
>  	log_irqs(event);
>  
> +	if (event & OHCI1394_phy)
> +		tasklet_schedule(&ohci->phy_tasklet);
> +
>  	if (event & OHCI1394_selfIDComplete)
>  		tasklet_schedule(&ohci->bus_reset_tasklet);
>  
> @@ -1488,6 +1598,58 @@ static void copy_config_rom(__be32 *dest, const __be32 *src, size_t length)
>  		memset(&dest[length], 0, CONFIG_ROM_SIZE - size);
>  }
>  
> +static int is_extended_phy(struct fw_card *card)
> +{
> +	u32 val;
> +
> +	if (ohci_read_phy_reg(card, 2, &val))
> +		return -EBUSY;
> +
> +	if ((val & 0xE0) == 0xE0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int ohci_configure_wakeup(struct fw_card *card)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	int i, total_ports;
> +	u32 val;
> +
> +	if (ohci_read_phy_reg(card, 2, &val))
> +		return -EBUSY;

Since its caller does not check for error return,
ohci_configure_wakeup() can just return void.

> +
> +	total_ports = val & 0x1f;
> +
> +	/* Attempt to enable port interrupts */
> +	for (i = 0; i < total_ports; i++) {
> +		ohci_write_port_reg(card, i, 1, 0, 0x10);
> +		ohci_read_port_reg(card, i, 1, &val);
> +		if (!(val & 0x10)) {
> +			fw_error("Failed to enable interrupts on port %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	/*
> +	 * Some cards appear to only support int_enable on a single port.
> +	 * Check that it's still set on everything
> +	 */
> +
> +	for (i = 0; i < total_ports; i++) {
> +		ohci_read_port_reg(card, i, 1, &val);
> +		if (!(val & 0x10)) {
> +			fw_error("int_enable on port %d didn't stick\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	ohci->runtime_pm = 1;
> +
> +	return 0;
> +}
> +
>  static int ohci_enable(struct fw_card *card,
>  		       const __be32 *config_rom, size_t length)
>  {
> @@ -1555,7 +1717,7 @@ static int ohci_enable(struct fw_card *card,
>  		  OHCI1394_postedWriteErr | OHCI1394_cycleTooLong |
>  		  OHCI1394_cycleInconsistent |
>  		  OHCI1394_cycle64Seconds | OHCI1394_regAccessFail |
> -		  OHCI1394_masterIntEnable);
> +		  OHCI1394_masterIntEnable | OHCI1394_phy);

This warrants a little addition in our goophy debug logging section, see
log_irqs() at the top pf ohci.c.

>  	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
>  		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
>  
> @@ -1604,6 +1766,7 @@ static int ohci_enable(struct fw_card *card,
>  	ohci->next_header = ohci->next_config_rom[0];
>  	ohci->next_config_rom[0] = 0;
>  	reg_write(ohci, OHCI1394_ConfigROMhdr, 0);
> +
>  	reg_write(ohci, OHCI1394_BusOptions,
>  		  be32_to_cpu(ohci->next_config_rom[2]));
>  	reg_write(ohci, OHCI1394_ConfigROMmap, ohci->next_config_rom_bus);

What's this blank line for? :-)

> @@ -1624,6 +1787,11 @@ static int ohci_enable(struct fw_card *card,
>  		  OHCI1394_HCControl_BIBimageValid);
>  	flush_writes(ohci);
>  
> +	if (is_extended_phy(card)) {
> +		ohci_configure_wakeup(card);
> +		ohci_clear_port_event(card);
> +	}
> +
>  	/*
>  	 * We are ready to go, initiate bus reset to finish the
>  	 * initialization.
> @@ -2455,6 +2623,9 @@ static int __devinit pci_probe(struct pci_dev *dev,
>  	tasklet_init(&ohci->bus_reset_tasklet,
>  		     bus_reset_tasklet, (unsigned long)ohci);
>  
> +	tasklet_init(&ohci->phy_tasklet,
> +		     phy_tasklet, (unsigned long)ohci);
> +
>  	err = pci_request_region(dev, 0, ohci_driver_name);
>  	if (err) {
>  		fw_error("MMIO resource unavailable\n");
> @@ -2548,6 +2719,11 @@ static int __devinit pci_probe(struct pci_dev *dev,
>  	if (err)
>  		goto fail_self_id;
>  
> +	if (pci_dev_run_wake(dev) && ohci->runtime_pm) {
> +		pm_runtime_set_active(&dev->dev);
> +		pm_runtime_enable(&dev->dev);
> +	}
> +
>  	fw_notify("Added fw-ohci device %s, OHCI version %x.%x\n",
>  		  dev_name(&dev->dev), version >> 16, version & 0xff);
>  
> @@ -2580,9 +2756,17 @@ static int __devinit pci_probe(struct pci_dev *dev,
>  
>  static void pci_remove(struct pci_dev *dev)
>  {
> -	struct fw_ohci *ohci;
> +	struct fw_ohci *ohci = pci_get_drvdata(dev);
> +
> +	pm_runtime_get_sync(&dev->dev);
> +
> +	if (pci_dev_run_wake(dev) && ohci->runtime_pm) {
> +		pm_runtime_disable(&dev->dev);
> +		pm_runtime_set_suspended(&dev->dev);
> +	}
> +
> +	pm_runtime_put_noidle(&dev->dev);
>  
> -	ohci = pci_get_drvdata(dev);
>  	reg_write(ohci, OHCI1394_IntMaskClear, ~0);
>  	flush_writes(ohci);
>  	fw_core_remove_card(&ohci->card);
> @@ -2619,42 +2803,41 @@ static void pci_remove(struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_PM
> -static int pci_suspend(struct pci_dev *dev, pm_message_t state)
> +static int ohci_pci_suspend(struct device *dev)
>  {
> -	struct fw_ohci *ohci = pci_get_drvdata(dev);
> -	int err;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct fw_ohci *ohci = pci_get_drvdata(pdev);
>  
>  	software_reset(ohci);
> -	free_irq(dev->irq, ohci);
> -	err = pci_save_state(dev);
> -	if (err) {
> -		fw_error("pci_save_state failed\n");
> -		return err;
> -	}
> -	err = pci_set_power_state(dev, pci_choose_state(dev, state));
> -	if (err)
> -		fw_error("pci_set_power_state failed with %d\n", err);
> -	ohci_pmac_off(dev);
> +
> +	ohci_pmac_off(pdev);
>  
>  	return 0;
>  }
>  
> -static int pci_resume(struct pci_dev *dev)
> +static int ohci_pci_runtime_suspend(struct device *dev)
>  {
> -	struct fw_ohci *ohci = pci_get_drvdata(dev);
> -	int err;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct fw_ohci *ohci = pci_get_drvdata(pdev);
>  
> -	ohci_pmac_on(dev);
> -	pci_set_power_state(dev, PCI_D0);
> -	pci_restore_state(dev);
> -	err = pci_enable_device(dev);
> -	if (err) {
> -		fw_error("pci_enable_device failed\n");
> -		return err;
> -	}
> +	ohci_clear_port_event(&ohci->card);
> +	return ohci_pci_suspend(dev);
> +}
> +
> +static int ohci_pci_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct fw_ohci *ohci = pci_get_drvdata(pdev);
> +
> +	ohci_pmac_on(pdev);
>  
>  	return ohci_enable(&ohci->card, NULL, 0);
>  }
> +
> +static int ohci_pci_runtime_idle(struct device *dev)
> +{
> +	return -EBUSY;
> +}
>  #endif
>  
>  static struct pci_device_id pci_table[] = {
> @@ -2664,14 +2847,24 @@ static struct pci_device_id pci_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, pci_table);
>  
> +static struct dev_pm_ops ohci_pci_pm_ops = {
> +	.suspend = ohci_pci_suspend,
> +	.resume = ohci_pci_resume,
> +	.freeze = ohci_pci_suspend,
> +	.thaw = ohci_pci_resume,
> +	.poweroff = ohci_pci_suspend,
> +	.runtime_suspend = ohci_pci_runtime_suspend,
> +	.runtime_resume = ohci_pci_resume,
> +	.runtime_idle = ohci_pci_runtime_idle,
> +};

Obligatory whitespace nitpick :-) --- Look how nicely krh aligned his code:

> +
>  static struct pci_driver fw_ohci_pci_driver = {
>  	.name		= ohci_driver_name,
>  	.id_table	= pci_table,
>  	.probe		= pci_probe,
>  	.remove		= pci_remove,
>  #ifdef CONFIG_PM
> -	.resume		= pci_resume,
> -	.suspend	= pci_suspend,
> +	.driver.pm	= &ohci_pci_pm_ops,
>  #endif
>  };
>  

Thanks for working on this.  Considering how often FireWire equipped
notebooks are used with the 1394 drivers loaded but the port unused all
day, this may be a worthwile enhancement.
-- 
Stefan Richter
-=====-==-=- ---= -==-=
http://arcgraph.de/sr/
