From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/8] PM: Asynchronous suspend and resume of
	devices
Date: Sun, 24 Jan 2010 22:12:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001242155410.4189-100000__47851.5706643977$1264389315$gmane$org@netrider.rowland.org>
References: <201001250027.42621.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001250027.42621.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:

> > I intend to write this code, but merging it will be a little tricky.  
> > You'll have to coordinate with Greg KH.
> 
> OK, I don't think that's a big deal.  I can defer patch 7/8 until that code has
> been merged.

You may have to delay 6/8 as well, since the controllers are PCI
devices.  Writing the new code shouldn't take too long, though.

Is there a good way to iterate through all PCI devices in a particular
slot, or should it be done by going through all PCI devices and
ignoring those in other slots?  Calling pci_get_slot() multiple times
doesn't look very efficient.


> I'll try that, but my mkinitrd automatically puts the USB drivers into
> initramfs.  I guess I'll need to do some research to really verify it. :-)

Then when you install the test kernel, mkinitrd should build a
corresponding initramfs image with the modified drivers, right?  
Otherwise there would be a version mismatch error when the init code
tried to load the old drivers into the new kernel.

If nothing else works, you can simply unload the standard uhci-hcd,
ohci-hcd, and ehci-hcd drivers and then modprobe the modified versions
before starting the hibernation.

Alan Stern
