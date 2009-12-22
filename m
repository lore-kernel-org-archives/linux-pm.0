From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Asynchronous suspend/resume of PCI devices
Date: Tue, 22 Dec 2009 20:10:27 +0100
Message-ID: <200912222010.28046.rjw__41145.8045979545$1261509045$gmane$org@sisk.pl>
References: <200912200031.38775.rjw@sisk.pl>
	<20091222083001.10ce3948@jbarnes-x200>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091222083001.10ce3948@jbarnes-x200>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 December 2009, Jesse Barnes wrote:
> On Sun, 20 Dec 2009 00:31:38 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > I'd like to know your opinions about the viability of suspending and
> > resuming PCI devices asynchronously during system-wide PM transitions
> > (suspend to RAM and hibernation).
> > 
> > Linus says it's generally dangerous, because some PCI devices may
> > indirectly depend on the others, but if that's the case, I wonder if
> > we really can power manage PCI devices at run time.
> > 
> > It follows from my experiments that suspending and resuming PCI
> > devices asynchronously doesn't lead to problems as long as we make
> > sure that every PCI device is suspended before and resumed after its
> > ACPI "shadow" partner. However, I'm not sure if this is generally
> > correct.
> > 
> > What are possible problems we can run into while doing asynchronous
> > suspend and resume of PCI devices?  What do we need to do in general
> > to avoid that problems?
> > 
> > Please tell me what you think.
> 
> AFAIK it should be *mostly* safe.  Individual drivers are generally
> independent of one another.  However, there are quite a few
> multifunction devices (some exposed as such, some exposed as multiple
> busses and devices on the same device) where interdependencies are
> possible.  In some cases, we just won't see power savings until the
> whole chip is powered down (which may require extra code in the form of
> a "bus" driver of some sort), in other cases a driver may inadvertently
> power down a piece of a device needed by another driver.
> 
> That said, the best practice for those sorts of devices is to create a
> bus driver anyway, that binds to the master device and has a few
> child drivers, so maybe even that case won't be much trouble...

My current idea is to mark all PCI devices as async and introduce mutexes
for the devices that shouldn't be suspended/resumed at the same time.
Perhaps we can start with just one mutex to be acquired in ->suspend() and
->resume() by the drivers that have to be serialized with respect to one
another.

What do you think?

Rafael
