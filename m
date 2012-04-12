From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 15:11:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121504550.1496-100000@iolanthe.rowland.org>
References: <1334255150.23924.342.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334255150.23924.342.camel@gandalf.stny.rr.com>
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

> On Thu, 2012-04-12 at 14:17 -0400, Steven Rostedt wrote:
> 
> > And I forgot that the echo isn't enough, and I need to do a pm-suspend
> > too ;-)
> > 
> > # dmesg | grep target
> > [ 8829.427534] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> > [ 8829.443524] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
> > [ 8829.459506] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> > [ 8829.459560] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> > [ 8829.459607] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> > [ 8829.475458] ehci_hcd 0000:00:1d.0: target 3 wakeup 1 error 0
> > [ 8829.491433] ehci_hcd 0000:00:1a.0: target 3 wakeup 1 error 0
> > [ 8829.507416] pci 0000:00:16.0: target 3 wakeup 0 error 0
> > 
> 
> The above was without the script, with the script:
> 
> # dmesg | grep target
> [ 8829.427534] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> [ 8829.443524] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
> [ 8829.459506] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> [ 8829.459560] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> [ 8829.459607] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> [ 8829.475458] ehci_hcd 0000:00:1d.0: target 3 wakeup 1 error 0
> [ 8829.491433] ehci_hcd 0000:00:1a.0: target 3 wakeup 1 error 0
> [ 8829.507416] pci 0000:00:16.0: target 3 wakeup 0 error 0

The entries above are left over from the earlier test.

> [ 9419.750158] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> [ 9419.766134] pci 0000:03:00.0: target 3 wakeup 1 error 0
> [ 9419.782126] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> [ 9419.782181] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> [ 9419.782230] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> [ 9419.798087] pci 0000:00:1d.0: target 3 wakeup 1 error 0
> [ 9419.814064] pci 0000:00:1a.0: target 3 wakeup 1 error 0
> [ 9419.830031] pci 0000:00:16.0: target 3 wakeup 0 error 0

Evidently the script unbinds xhci-hcd too.  Did you check to make
sure it is unrelated to the suspend problem?

Anyway, this shows that the EHCI controllers are being set to the same 
power state with the same wakeup settings in both cases.  And yet one 
hangs the computer while the other doesn't.

Here's another rather drastic test you can do.  In 
drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), call ehci_reset(ehci) 
just before the final return statement.  That should leave the hardware 
in exactly the same state as if ehci-hcd had been unbound.

Alan Stern
