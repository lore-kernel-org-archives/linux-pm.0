From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Wakeup for PNP
Date: Tue, 2 Mar 2010 16:08:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003021606310.1326-100000__10368.6162656688$1267564179$gmane$org@iolanthe.rowland.org>
References: <201003021341.58988.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003021341.58988.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Mar 2010, Bjorn Helgaas wrote:

> > Does this look reasonable?  I don't know anything about PNPBIOS or 
> > ISAPNP, so it handles only PNPACPI.  But at least it's a starting 
> > point -- and it does enable my system to wake up in response to 
> > hitting a key.
> 
> I don't know much about power management, but your patch looks
> reasonable to me.

Thanks.

> > --- usb-2.6.orig/drivers/pnp/pnpacpi/core.c
> > +++ usb-2.6/drivers/pnp/pnpacpi/core.c
> > @@ -121,12 +121,27 @@ static int pnpacpi_disable_resources(str
> >  }
> >  
> >  #ifdef CONFIG_ACPI_SLEEP
> > +static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
> > +{
> > +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> 
> I would have used:
> 
> 	struct acpi_device *acpi_dev = dev->data;
> 	acpi_handle handle = acpi_dev->handle;
> 
> here because that's what the rest of the PNPACPI code does.

Ah yes.  I just copied the code from the corresponding PCI function 
without thinking about it very much.  I'll update the patch and wait to 
hear from other people.

Alan Stern
