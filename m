From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm]
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 01 Jun 2012 11:50:44 -0400
Message-ID: <1338565844.13348.468.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1206011046460.1610-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1206011046460.1610-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-06-01 at 11:13 -0400, Alan Stern wrote:
> On Thu, 31 May 2012, Rafael J. Wysocki wrote:
> 
> > > @@ -1743,6 +1743,11 @@ int pci_prepare_to_sleep(struct pci_dev
> > >  	if (target_state == PCI_POWER_ERROR)
> > >  		return -EIO;
> > >  
> > > +	/* Some devices mustn't be in D3 during system sleep */
> > > +	if (target_state == PCI_D3hot &&
> > > +			(dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP))
> > > +		return 0;
> > > +
> > 
> > Why do you want to skip the wakeup setting in that case?
> 
> Because that's what the 151b61284776 commit did.  Also, the quirk marks 
> the controller as not wakeup-capable.
> 
> Still, it's worth testing.  Andrey and Steve, here's an updated patch 
> which should leave wakeup enabled on your EHCI controllers.  If you 
> don't have a USB keyboard handy for generating a wakeup signal, you 
> can test the wakeup functionality by doing:
> 
> 	echo enabled >/sys/bus/usb/devices/usb1/power/wakeup
> 	echo enabled >/sys/bus/usb/devices/usb2/power/wakeup
> 
> before suspending.  (In fact you need only one of those two lines, but
> at the moment I forget which -- probably the usb2 one.)  Then while
> the system is asleep, either plugging or unplugging a USB device
> directly into the computer should cause it to wake up.

I applied the patch, it suspends and resumes fine, but still no wakeup.

I even plugged in a USB keyboard, suspended, and tried to wake it up
with that. That did not work. I even enabled what you stated above, with
no effect (with keyboard or usb storage).

-- Steve


