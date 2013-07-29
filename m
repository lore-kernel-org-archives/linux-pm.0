From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] ACPI / PM: Make messages in acpi_device_set_power() print device names
Date: Mon, 29 Jul 2013 14:20:07 +0200
Message-ID: <4285597.UpTJrMA8Fu@vostro.rjw.lan>
References: <10433383.dueoNg39qi@vostro.rjw.lan> <1895563.95T8SxMegu@vostro.rjw.lan> <51F5D390.5040506@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45941 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab3G2MJ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jul 2013 08:09:57 -0400
In-Reply-To: <51F5D390.5040506@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Monday, July 29, 2013 10:29:36 AM Aaron Lu wrote:
> On 07/27/2013 09:11 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Modify acpi_device_set_power() so that diagnostic messages printed by
> > it to the kernel log always contain the name of the device concerned
> > to make it possible to identify the device that triggered the message
> > if need be.
> > 
> > Also replace printk(KERN_WARNING ) with dev_warn() everywhere in that
> > function.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/device_pm.c |   22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > Index: linux-pm/drivers/acpi/device_pm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -166,20 +166,20 @@ int acpi_device_set_power(struct acpi_de
> >  	/* Make sure this is a valid target state */
> >  
> >  	if (state == device->power.state) {
> > -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at %s\n",
> > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] already in %s\n",
> > +				  device->pnp.bus_id,
> >  				  acpi_power_state_string(state)));
> >  		return 0;
> >  	}
> >  
> >  	if (!device->power.states[state].flags.valid) {
> > -		printk(KERN_WARNING PREFIX "Device does not support %s\n",
> > -		       acpi_power_state_string(state));
> > +		dev_warn(&device->dev, "Power state %s not supported\n",
> > +			 acpi_power_state_string(state));
> >  		return -ENODEV;
> >  	}
> >  	if (device->parent && (state < device->parent->power.state)) {
> > -		printk(KERN_WARNING PREFIX
> > -			      "Cannot set device to a higher-powered"
> > -			      " state than parent\n");
> > +		dev_warn(&device->dev, "Cannot transition to a higher-powered "
> > +			 "state than parent\n");
> 
> I think the state information would also be useful here:
> 
> 		dev_warn(&device->dev, "Cannot transition to a higher-powereed "
> 		         "state %d than paeren's state %d\n", state,
> 			 device->parent->power.state);

This is not the scope of this patch, please send another one on top of it.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
