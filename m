From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression (was: Re: 2.6.14-rc1-mm1:
 usb breaks suspend)
Date: Wed, 19 Oct 2005 12:18:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510191204090.5049-100000@iolanthe.rowland.org>
References: <200510191514.00186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200510191514.00186.rjw@sisk.pl>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

[Trimmed the CC: list]

On Wed, 19 Oct 2005, Rafael J. Wysocki wrote:

> Hi,
> 
> On Tuesday, 18 of October 2005 03:01, Alan Stern wrote:
> > On Mon, 17 Oct 2005, Rafael J. Wysocki wrote:
> > > On Monday, 17 of October 2005 20:54, Alan Stern wrote:
> > > > On Mon, 17 Oct 2005, Pavel Machek wrote:
> > > > 
> > > > > Hi!
> > > > > 
> > > > > In -mm, usb breaks suspend to disk. Compiled without
> > > > > CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
> > > > > actually tries to suspend USB, but it fails and machine refuses to
> > > > > suspend. Is it known or is it worth debugging?
> > > > 
> > > > More details please.
> > > 
> > > Fails for me too on x86-64, with the following messages:
> > > 
> > > Stopping tasks: ========================|
> > > Freeing memory... done (14642 pages freed)
> > > Suspending device card0-0
> > > Suspending device 2-2:1.0
> > > Suspending device 2-2
> > > Suspending device 3-0:1.0
> > > hub 3-0:1.0: no suspend?

This line is the puzzle.  It indicates that the driver bound to the
3-0:1.0 device (which is a root hub interface for one of your USB
controllers) doesn't have a suspend or resume method.  But the hub driver
_does_ have these methods!

Unless you somehow screwed up the build.  Take a look inside
drivers/usb/core/hub.c and make sure that the hub_suspend() and
hub_resume() routines are listed in the hub_driver table, and that they
haven't been preprocessed away into NULLs.  You might end up needing to do
a clean rebuild.

> > > Suspending device usb3
> > > Could not suspend device usb3: error -16
> > > Some devices failed to suspend

These errors occurred, naturally enough, because the driver for usb3 
refused to suspend since one of the children -- namely 3-0:1.0 -- wasn't 
suspended.

> Thanks a lot for all the information.
> 
> Still I'd rather like to figure out what causes the problem to appear
> in -rc4-mm1.  So far I have identified the offending patch which is:
> 
> gregkh-usb-usb-power-state-03.patch
> 
> (ie. with the patch the problem occurs 100% of the time and without
> the patch it doesn't).  I don't know which change in the patch is at
> fault (yet).  [Note: the patch didn't revert cleanly so I changed the
> 7th chunk in drivers/usb/core/hub.c a bit.]

I don't think this is as simple as finding an offending line in a 
particular patch.  As you can see from the numbering, that patch was part 
of a large series; it wasn't meant to be applied or removed in isolation.

> The devices that refuse to suspend (with the above patch) are:
> 
> usb usb3: Product: EHCI Host Controller
> usb usb3: Manufacturer: Linux 2.6.14-rc4-mm1 ehci_hcd
> usb usb3: SerialNumber: 0000:00:02.2
> 
> usb usb2: Product: OHCI Host Controller
> usb usb2: Manufacturer: Linux 2.6.14-rc4-mm1 ohci_hcd
> usb usb2: SerialNumber: 0000:00:02.1

Maybe if you solve the riddle above (suspend method not present in the hub 
driver) it will clear up these issues as well.

Alan Stern



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
