From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/8] PM: Asynchronous suspend and resume of
	devices
Date: Mon, 25 Jan 2010 17:04:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001251653140.1733-100000__42679.1499056437$1264457212$gmane$org@iolanthe.rowland.org>
References: <201001252226.29289.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001252226.29289.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, USB list <linux-usb@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:

> > You may have to delay 6/8 as well, since the controllers are PCI
> > devices.  Writing the new code shouldn't take too long, though.
> 
> No problem with that.
> 
> Alternatively, if Greg agrees, I can add your patches modifying this into this
> series.  Greg?
> 
> I wonder, though.  Since the controllers are PCI devices, we put them into D0
> and restore their standard config spaces in the dpm_list order at the "early"
> resume stage.  Doesn't that help here?

No.  The problem is that the "late" resume routines in the host
controller drivers reinitialize the hardware, and existing connections
(i.e., from before the system sleep) may not be handled properly if the
controllers are initialized in the wrong order.


> > > I'll try that, but my mkinitrd automatically puts the USB drivers into
> > > initramfs.  I guess I'll need to do some research to really verify it. :-)
> > 
> > Then when you install the test kernel, mkinitrd should build a
> > corresponding initramfs image with the modified drivers, right?  
> > Otherwise there would be a version mismatch error when the init code
> > tried to load the old drivers into the new kernel.
> 
> Yes, but then they are loaded during restore before the image is read and
> the hardware is initialized.  Would it still fail in that case?

It wouldn't matter.  What the boot kernel does shouldn't affect what 
happens after the image starts running.

BTW, I should mention that these problems don't always occur 100% of 
the time, even when the order constraints are violated.  There may
still be other races that can affect the result.  But try it and see...

Alan Stern
