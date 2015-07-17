From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: Add AMD SB8XX/SB9XX/A5X/A8X driver
Date: Fri, 17 Jul 2015 13:34:30 +0200
Message-ID: <CACRpkdbh6DrGZq5zbXZd_c5yBv9PTRebOdk9GbB+6Twz2omxPg@mail.gmail.com>
References: <20150620215753.GD29802@yumi.tdiedrich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33927 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbbGQLeb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 07:34:31 -0400
Received: by obre1 with SMTP id e1so64254216obr.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2015 04:34:31 -0700 (PDT)
In-Reply-To: <20150620215753.GD29802@yumi.tdiedrich.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

tI caught this message by pure luck down in the spam filter.

Please send new GPIO drivers to linux-gpio@vger.kernel.org and
also to me and Alexandre Courbot on the To: line, see MAINTAINERS.
In this case, please also add linux-acpi and linux-pm, Mika Westerberg
and Rafael Wysocki for info.

On Sat, Jun 20, 2015 at 11:57 PM, Tobias Diedrich
<ranma+kernel@tdiedrich.de> wrote:

> In principle this driver could export a pinmux interface as well, but
> since setting up the pinmux settings is the BIOS/EFI responsibility
> I don't think it makes sense to add it

Famous last words.

Surely AMD users does not want to be worse off than
drivers/pinctrl/intel/* ?

I think the Intel people are enjoying their fine-grained pinctrl interfaces
a lot. Partly some drivers are there just to be able to label and
browse pins in debugfs.

A reason Mika added it to their driver was that (OTOMH) it turns out
that runtime pin reconfiguration for power savings is *not* done by the
BIOS/EFI.

Of course I have heard a 100 variants of "but the BIOS should..."
arguments about that, but it's just like that: the BIOS just doesn't,
and pinctrl gets to deal with it. Just wait and see.

> (I only read it to print
> the current mux state in /sys/kernel/debug/gpio).

That is nice.

> Signed-off-by: Tobias Diedrich <ranma+kernel@tdiedrich.de>
(...)
> +++ b/drivers/gpio/gpio-sb8xx.c
> @@ -0,0 +1,489 @@
> +/*
> + * GPIO driver for AMD SB8XX/SB9XX/A5X/A8X south bridges
> + *
> + * Copyright (c) 2015 Tobias Diedrich
> + *
> + * Based on the AMD 8111 GPIO driver:
> + * Copyright (c) 2012 Dmitry Eremin-Solenikov
> + *
> + * Based on the AMD RNG driver:
> + * Copyright 2005 (c) MontaVista Software, Inc.
> + * with the majority of the code coming from:
> + *
> + * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
> + * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
> + *
> + * derived from
> + *
> + * Hardware driver for the AMD 768 Random Number Generator (RNG)
> + * (c) Copyright 2001 Red Hat Inc
> + *
> + * derived from
> + *
> + * Hardware driver for Intel i810 Random Number Generator (RNG)
> + * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
> + * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>

It's kinda bizarre to have one line about the GPIO and then 10+ lines
about random random number generators.

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/gpio.h>

#include <linux/gpio/driver.h> should be sufficient.

> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/acpi.h>

So I see you use this for PM. So in Kconfig you should depend
on ACPI, right?

> +#include <linux/platform_device.h>

Why? PCI devices are not platform devices either.

> +#define PM_REG_BASE    0xCD6
> +#define PM_REG_SIZE    2
> +#define PM_IDX_REG     (PM_REG_BASE + 0)
> +#define PM_DATA_REG    (PM_REG_BASE + 1)
> +#define PM_ACPI_MMIO_BAR       0x24
> +
> +#define GPIO_OFFSET    0x100
> +#define GPIO_SIZE      0x100
> +#define IOMUX_OFFSET   0xd00
> +#define IOMUX_SIZE     0x100
> +
> +#define MAX_GPIO       256

Some variables here have confusing names. Consider that
CONFIG_ARCH_NR_GPIO we could use some driver-specific
naming suffix here. Atleast AMD_MAX_GPIO or so.

> +#define REG_GPIO(i)    (0x00 + (i))
> +
> +#define IOMUX_MASK     0x03
> +#define IOMUX_FN0      0x00
> +#define IOMUX_FN1      0x01
> +#define IOMUX_FN2      0x02
> +#define IOMUX_FN3      0x03
> +
> +#define GPIO_OWN_NONE  0x00 /* No owner */
> +#define GPIO_OWN_IMC   0x01 /* OwnedByImc */

What is IMC? Spell it out, quite interesting. Does this mean there
is a coprocessor or so on the chip that may "own" pins?

> +#define GPIO_OWN_HOST  0x02 /* OwnedByHost */
> +#define GPIO_OWN_MASK  (GPIO_OWN_IMC | GPIO_OWN_HOST)
> +#define GPIO_STICKY    0x04 /* Settings sticky across reset */
> +#define GPIO_PULLUP_B  0x08 /* 0 to enable pull-up */
> +#define GPIO_PULLDOWN  0x10 /* 1 to enable pull-down */
> +#define GPIO_PULL_MASK (GPIO_PULLUP_B | GPIO_PULLDOWN)
> +#define GPIO_PULL_UP   0x00
> +#define GPIO_PULL_DOWN 0x18
> +#define GPIO_PULL_NONE 0x08

This may be one of those drivers that we want to put in drivers/pinctrl/*
even if it's only implementing GPIO right now. There is no strict requirement
that drivers in drivers/pinctrl must implement pin control interfaces, I more
think it's for hardware of pin controller type, and this is clearly so.

> +static int enable_unsafe_direction_change;
> +module_param(enable_unsafe_direction_change, int, 0);
> +MODULE_PARM_DESC(enable_unsafe_direction_change,
> +                "Enable gpio direction changes. This can be unsafe!");

Bah just give the users this power. If you can't shoot yourself
in the foot in kernel space, where else should you do it?
Just print a warning when doing it.

> +struct amd_sb8xx_gpio {
> +       struct gpio_chip        chip;
> +       u32                     gpio_base;
> +       u32                     iomux_base;> +/*
> + * Explicitly register the supported PCI ids via MODULE_DEVICE_TABLE.
> + * We do not actually register a pci_driver, because the SMBUS driver
> + * (i2c_piix4) already does.
> + */
> +MODULE_DEVICE_TABLE(pci, pci_tbl);
> +
> +       void __iomem            *gpio;
> +       void __iomem            *iomux;
> +       struct device           *dev;
> +       spinlock_t              lock; /* guards hw registers and orig table */
> +       u8                      orig[MAX_GPIO];

orig? This struct member needs documentation more than the
spinlock above it.

> +#define to_agp(chip)   container_of(chip, struct amd_sb8xx_gpio, chip)

Please do a static inline instead. (See other drivers.)
Defines are hard to read.

> +static int amd_sb8xx_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct amd_sb8xx_gpio *agp = to_agp(chip);
> +       u8 orig = ioread8(agp->gpio + offset);
> +
> +       if (orig & GPIO_OWN_IMC) {
> +               dev_err(agp->dev, "Requested GPIO %d is owned by IMC\n",
> +                       offset);

Spell out what IMC means, anyone seeing it is going to be as clueless
as I am.

> +static void amd_sb8xx_gpio_set(struct gpio_chip *chip, unsigned offset,
> +                              int value)
> +{
> +       struct amd_sb8xx_gpio *agp = to_agp(chip);
> +       u8 temp;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&agp->lock, flags);
> +       temp = ioread8(agp->gpio + offset);
> +       if ((temp & GPIO_OUT_EN_B) == 0 || enable_unsafe_direction_change) {
> +               temp &= ~(GPIO_OUT | GPIO_OUT_EN_B);
> +               temp |= value ? GPIO_OUT : 0;
> +               iowrite8(temp, agp->gpio + offset);
> +       }

I think you should detect if you need to do the unsafe direction change and
print a warning.

> +static int amd_sb8xx_gpio_dirout(struct gpio_chip *chip, unsigned offset,
> +                                int value)
> +{
> +       struct amd_sb8xx_gpio *agp = to_agp(chip);
> +       u8 temp, orig;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&agp->lock, flags);
> +       orig = ioread8(agp->gpio + offset);
> +       temp = (orig & ~(GPIO_OUT | GPIO_OUT_EN_B)) | (value ? GPIO_OUT : 0);
> +       if (orig != temp) {
> +               if (!enable_unsafe_direction_change)
> +                       ret = -EINVAL;

Print a warning if you make an unsafe change.

> +               else
> +                       iowrite8(temp, agp->gpio + offset);
> +       }
> +       spin_unlock_irqrestore(&agp->lock, flags);
> +
> +       if (ret)
> +               dev_err(agp->dev,
> +                       "Cannot change GPIO %d to output: enable_unsafe_direction_change not set\n",
> +                       offset);

I think this should just be possible. But if you can give me some
info on the horrors that may occur, I may change my mind :D

> +static int amd_sb8xx_gpio_dirin(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct amd_sb8xx_gpio *agp = to_agp(chip);
> +       u8 temp, orig;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&agp->lock, flags);
> +       orig = ioread8(agp->gpio + offset);
> +       temp = orig | GPIO_OUT_EN_B;
> +       if (orig != temp) {
> +               if (!enable_unsafe_direction_change)
> +                       ret = -EINVAL;

Print.

> +#ifdef CONFIG_DEBUG_FS
> +static void amd_sb8xx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
> +{
> +       struct amd_sb8xx_gpio *agp = to_agp(chip);
> +       int i;
> +
> +       for (i = 0; i < chip->ngpio; i++) {
> +               int gpio = i + chip->base;
> +               u8 reg;
> +               const char *label, *pull, *owner, *mux;
> +
> +               /* We report the GPIO even if it's not requested since
> +                * we're also reporting things like alternate
> +                * functions which apply even when the GPIO is not in
> +                * use as a GPIO.
> +                */
> +               label = gpiochip_is_requested(chip, i);
> +               if (!label) {
> +                       label = "Unrequested";
> +
> +                       /* Skip known gaps in the gpio range unless they were
> +                        * explicitly requested.
> +                        */
> +                       if ((i > 67 && i < 96) ||
> +                           (i > 119 && i < 128) ||
> +                           (i > 150 && i < 160) ||
> +                           i > 228)
> +                               continue;
> +               }
> +
> +               seq_printf(s, " gpio-%-3d(%d) (%-20.20s) ", gpio, i, label);
> +
> +               reg = ioread8(agp->gpio + i);
> +
> +               switch (reg & GPIO_PULL_MASK) {
> +               case GPIO_PULL_NONE:
> +                       pull = "nopull";
> +                       break;
> +               case GPIO_PULL_DOWN:
> +                       pull = "pulldown";
> +                       break;
> +               case GPIO_PULL_UP:
> +                       pull = "pullup";
> +                       break;
> +               default:
> +                       pull = "INVALID PULL";
> +                       break;
> +               }
> +
> +               switch (reg & GPIO_OWN_MASK) {
> +               case GPIO_OWN_IMC:
> +                       owner = "imc";
> +                       break;
> +               case GPIO_OWN_HOST:
> +                       owner = "host";
> +                       break;
> +               case GPIO_OWN_NONE:
> +                       owner = NULL;
> +                       break;
> +               default:
> +                       owner = "INVALID OWNER";
> +               }
> +
> +               reg = ioread8(agp->iomux + i);
> +               switch (reg & IOMUX_MASK) {
> +               case IOMUX_FN0:
> +                       mux = "fn0";
> +                       break;
> +               case IOMUX_FN1:
> +                       mux = "fn1";
> +                       break;
> +               case IOMUX_FN2:
> +                       mux = "fn2";
> +                       break;
> +               case IOMUX_FN3:
> +                       mux = "fn3";
> +                       break;
> +               default:
> +                       mux = "INVALID IOMUX";
> +                       break;
> +               }
> +
> +               seq_printf(s, " %s %s %s %s",
> +                          reg & GPIO_OUT_EN_B ? "in" : "out",
> +                          reg & GPIO_IN ? "high" : "low",
> +                          pull, mux);
> +               if (i >= 96 && i <= 119)
> +                       seq_printf(s, " gevent%d", i - 96);
> +               if (owner)
> +                       seq_printf(s, " %s", owner);
> +               seq_putc(s, '\n');
> +       }
> +}
> +#else
> +#define amd_sb8xx_gpio_dbg_show NULL
> +#endif

This is nice, but proper pinctrl debugfs will enable you to name all the
pins on the silicon package etc. It adds another dimension to it.
The GPIO ranges in pinctrl makes it possible to see the correlation
between the pins on the package and the GPIO lines.

> +static struct amd_sb8xx_gpio gp = {
> +       .chip = {
> +               .label          = "AMD SB8XX/SB9XX/A5X/A8X GPIO driver",
> +               .owner          = THIS_MODULE,
> +               .base           = -1,

This is nice. Thanks.

> +static u8 amd_pm_read(u8 reg)
> +{
> +       outb_p(reg, PM_IDX_REG);
> +       return inb_p(PM_DATA_REG);
> +}

Port-mapped I/O? Wowsers. Well I guess you know what is going on...
I'm not much of an x86 person.

> +static u32 amd_acpi_mmio_base(struct device *dev)
> +{
> +       u32 bar = 0;
> +       struct resource *pm_region;
> +
> +       pm_region = devm_request_region(dev, PM_REG_BASE, PM_REG_SIZE,
> +                                       "AMD PM IO");
> +       if (!pm_region) {
> +               dev_err(dev, "AMD PM IO already in use.\n");
> +               return 0;
> +       }

This looks unsafe. Is the same PM IO used by *all* hardware?
It seems they could collide any time, isn't a mutex more
appropriate than failing then? (Certainly Rafael can explain this to me,
but I'm curious.)

> +out_release_pmio:
> +       devm_release_region(dev, PM_REG_BASE, PM_REG_SIZE);
> +
> +       return bar & ~3;

Quite magic. Can you use some #define?

> +static struct pci_dev *amd_get_sb_pcidev(void)
> +{
> +       struct pci_dev *dev = NULL;
> +       const struct pci_device_id *ent;
> +
> +       /* We look for our device - AMD South Bridge
> +        * I don't know about a system with two such bridges,
> +        * so we can assume that there is max. one device.

Can we? Allright then.

> +        *
> +        * We can't use plain pci_driver mechanism,
> +        * as the device is really a multiple function device,
> +        * main driver that binds to the pci_device is an smbus
> +        * driver and have to find & bind to the device this way.
> +        */
> +       for_each_pci_dev(dev) {
> +               ent = pci_match_id(pci_tbl, dev);
> +               if (ent)
> +                       return dev;
> +       }
> +
> +       return NULL;
> +}

What is a bit disturbing is that you autodetect this device, but
the ACPI power thing is hard-coded in PM_REG_BASE
which results in a confusing mix of hard-coding and detection.

Can you explain how we end up like this?

> +static int __init amd_sb8xx_gpio_init(void)
> +{
> +       int ret = -ENODEV;
> +       struct pci_dev *pcidev = amd_get_sb_pcidev();
> +       u32 acpi_bar = 0;
> +
> +       if (!pcidev)
> +               goto err;
> +
> +       if (pcidev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
> +           pcidev->revision < 0x40) {
> +               /* Southbridges before SB800 handle GPIO differently. */
> +               goto err;
> +       }
> +
> +       gp.dev = &pcidev->dev;
> +
> +       acpi_bar = amd_acpi_mmio_base(gp.dev);
> +       if (!acpi_bar) {
> +               dev_err(gp.dev, "Unable to find MMIO base address!\n");
> +               goto err;
> +       }
> +
> +       gp.gpio_base = (acpi_bar & ~3) + GPIO_OFFSET;
> +       gp.iomux_base = (acpi_bar & ~3) + IOMUX_OFFSET;
> +
> +       if (!devm_request_mem_region(gp.dev, gp.gpio_base, GPIO_SIZE,
> +                                    "AMD SB8XX GPIO")) {
> +               dev_err(gp.dev, "GPIO region 0x%x already in use!\n",
> +                       gp.gpio_base);
> +               ret = -EBUSY;
> +               goto err;
> +       }
> +       if (!devm_request_mem_region(gp.dev, gp.iomux_base, IOMUX_SIZE,
> +                                    "AMD SB8XX IOMUX")) {
> +               dev_err(gp.dev, "IOMUX region 0x%x already in use!\n",
> +                       gp.iomux_base);
> +               ret = -EBUSY;
> +               goto err_release_gpio;
> +       }
> +
> +       gp.gpio = devm_ioremap(gp.dev, gp.gpio_base, GPIO_SIZE);
> +       if (!gp.gpio) {
> +               dev_err(gp.dev, "Couldn't map GPIO region\n");
> +               ret = -ENOMEM;
> +               goto err_release_iomux;
> +       }
> +       gp.iomux = devm_ioremap(gp.dev, gp.iomux_base, IOMUX_SIZE);
> +       if (!gp.gpio) {
> +               dev_err(gp.dev, "Couldn't map IOMUX region\n");
> +               ret = -ENOMEM;
> +               goto err_release_iomux;
> +       }
> +
> +
> +       gp.dev = gp.dev;
> +       gp.chip.dev = gp.dev;
> +
> +       spin_lock_init(&gp.lock);
> +
> +       ret = gpiochip_add(&gp.chip);
> +       if (ret) {
> +               dev_err(gp.dev, "Registering gpiochip failed\n");
> +               goto err_release_iomux;
> +       }
> +
> +       return 0;
> +
> +err_release_iomux:
> +       devm_release_mem_region(gp.dev, gp.iomux_base, GPIO_SIZE);
> +err_release_gpio:
> +       devm_release_mem_region(gp.dev, gp.gpio_base, GPIO_SIZE);
> +err:
> +       return ret;
> +}

Looks correct to me.

Yours,
Linus Walleij
