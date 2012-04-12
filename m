From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 16:02:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
References: <1334259347.23924.345.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334259347.23924.345.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Steven Rostedt wrote:

> > Anyway, this shows that the EHCI controllers are being set to the same 
> > power state with the same wakeup settings in both cases.  And yet one 
> > hangs the computer while the other doesn't.
> > 
> > Here's another rather drastic test you can do.  In 
> > drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), call ehci_reset(ehci) 
> > just before the final return statement.  That should leave the hardware 
> > in exactly the same state as if ehci-hcd had been unbound.
> 
> Want me to remove previous updates before doing so? I can keep the
> dev_log, but what about the other change you asked about.

Keep them.

Asumming you get the same result as Andrey, that the computer still
hangs even with the ehci_reset() call, there's one more thing for the 
two of you to try.

I noted before that with ehci-hcd bound, it would call 
pci_disable_device.  But with the driver unbound, the PCI core calls 
pci_disable_enabled_device instead.

So let's have the driver do the same thing.  At the end of
drivers/usb/core/hcd-pci.c:suspend_common, change pci_disable_device to
pci_disable_enabled_device.  You'll also have to EXPORT that routine;
it's defined in drivers/pci/pci.c.

Do this with the ehci_reset added and all the other changes present as 
well.  Then there should be no difference at all between the two 
scenarios.

Alan Stern
