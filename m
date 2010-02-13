From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [PATCH 8/9] PCI / ACPI / PM: Platform support for
	PCI PME	wake-up (rev. 7)
Date: Fri, 12 Feb 2010 17:27:11 -0800
Message-ID: <20100213012711.GA18009__32564.7411322736$1266024510$gmane$org@us.ibm.com>
References: <201001101431.38630.rjw@sisk.pl>
	<20100212015508.GD10298@us.ibm.com>
	<201002121219.36350.rjw@sisk.pl> <201002130120.29385.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002130120.29385.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore,
	Robert" <robert.moore@intel.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 13, 2010 at 01:20:29AM +0100, Rafael J. Wysocki wrote:
> On Friday 12 February 2010, Rafael J. Wysocki wrote:
> > On Friday 12 February 2010, Gary Hade wrote:
> ... 
> > > There seems to be a problem.
> > > 
> > > The first time I booted I was able to successfully hot-remove
> > > a PCIe card and then successfully hot-add it to a different slot.
> > > When I tried to hot-remove a PCI-X card that was also present
> > > during boot I saw that lingering blinking amber LED issue.
> > > 
> > > After rebooting I tried the same thing but this time I did
> > > not see the lingering blinking amber LED after removing the
> > > PCI-X card but I did see it when removing the PCIe card.
> > > I then tried to hot-add the PCIe card to a different slot
> > > and noticed the below messages.
> > > 
> > > I don't think I will be able to try to characterize this
> > > better or test any more patches until Monday.  
> > 
> > OK, thanks for testing.
> > 
> > It seems we have a deadlock on pci_acpi_notify_mtx, but I'm yet to understand
> > the exact mechanism of it.
> 
> In fact there are two problems in there.  First, the bridge event notification
> calls handle_bridge_insertion() which attempts to install a PM notifier for
> the bridge and that deadlocks, because it tries to acquire the mutex
> recursively.  Second, apparently, init_bridge_misc() may be called in the
> notification code path and it attempts to unregister the notifier and register
> it again, which can't be done with pci_acpi_notify_mtx held.
> 
> I guess there are similar problems on the hot remove notification path.
> 
> Anyway, I have a new version of the patch and I'm going to test it a bit
> over the weekend.  Unfortunately, I don't have hardware with PCI hotplug
> capability, so I'll send you the new patch for testing on Monday, if you don't
> mind.

I don't mind.  Although I am concerned that my acpiphp only
testing on our IBM System x boxes may not be sufficient to
assure that PCI hotplug will work well on other PCI hotplug
capable systems.  I hope that others will also do some early
testing of this code.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc
