From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Sun, 18 Jan 2009 12:47:34 +1100
Message-ID: <1232243254.23611.40.camel__29019.1134009094$1232243422$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
	<200901171421.12389.rjw@sisk.pl> <1232227432.23611.33.camel@pasglop>
	<200901180130.02933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901180130.02933.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-01-18 at 01:30 +0100, Rafael J. Wysocki wrote:

> On PCs we have to restore the config spaces before calling pci_enable_device(),
> because otherwise we have a problem with unconfigured devices being enabled
> during resume.
> 
> Recently it's turned out that in fact we need to call pci_restore_state() with
> interrupts off and power up the device using the PCI PM native mechanism or we
> have a problem with shared interrupts.  A patch for that was sent yesterday.
> 
> At the same time we can't call pci_enable_device() with interrupts off.
> 
> If there are systems on which the standard config spaces of PCI devices are not
> accessible during resume, they are broken at the moment and quite frankly I
> don't know what to do to fix them.  I haven't seen any reports of this type of
> breakage yet, though.

Well, it's all a bit fishy...

Part of the problem is that pci_enable_device() is the only chance the
platform gets to do things like turn power or clocks on for devices that
aren't strictly following PCI D states.

For PowerMac, we get away with it I think mostly because all devices
that are in this case also have explicit calls to the platform code to
turn things on.

But I can very well see embedded systems having trouble in that area.

I suppose when it happens, it would be a matter of having the right arch
hook inside pci_restore_state() itself.

As for the problem with interrupts, maybe the right option here is to
have the PCI core always restore the state early ? 

Ben.
