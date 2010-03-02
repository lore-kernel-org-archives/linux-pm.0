From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Wakeup for PNP
Date: Tue, 2 Mar 2010 13:41:58 -0700
Message-ID: <201003021341.58988.bjorn.helgaas__38189.3851365477$1267562588$gmane$org@hp.com>
References: <Pine.LNX.4.44L0.1003021505130.1910-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003021505130.1910-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 March 2010 01:13:30 pm Alan Stern wrote:
> On Tue, 23 Feb 2010, Dmitry Torokhov wrote:
> 
> > Yes, I agree, we need a genric mechanism for PNP to emable wakups. It
> > was discussed a bit here:
> > 
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=8286
> > 
> > but David was too hung up on the fact that number of devices in ACPI
> > does not map directly onto number of serio ports when i8042 is in active
> > multiplexing mode that it id not go anywhere.
> 
> Does this look reasonable?  I don't know anything about PNPBIOS or 
> ISAPNP, so it handles only PNPACPI.  But at least it's a starting 
> point -- and it does enable my system to wake up in response to 
> hitting a key.

I don't know much about power management, but your patch looks
reasonable to me.

> --- usb-2.6.orig/drivers/pnp/pnpacpi/core.c
> +++ usb-2.6/drivers/pnp/pnpacpi/core.c
> @@ -121,12 +121,27 @@ static int pnpacpi_disable_resources(str
>  }
>  
>  #ifdef CONFIG_ACPI_SLEEP
> +static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);

I would have used:

	struct acpi_device *acpi_dev = dev->data;
	acpi_handle handle = acpi_dev->handle;

here because that's what the rest of the PNPACPI code does.

Bjorn
