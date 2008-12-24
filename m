From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 2/3] PCI: parallel resume for pci	devices
	on bus 0
Date: Wed, 24 Dec 2008 10:36:10 +0800
Message-ID: <1230086170.562.210.camel__41600.9915214547$1230086445$gmane$org@rzhang-dt>
References: <Pine.LNX.4.44L0.0812221038010.17981-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812221038010.17981-100000@netrider.rowland.org>
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2008-12-22 at 23:52 +0800, Alan Stern wrote:
> On Mon, 22 Dec 2008, Zhang Rui wrote:
> 
> > On Fri, 2008-12-19 at 23:09 +0800, Alan Stern wrote:
> > > On Fri, 19 Dec 2008, Zhang Rui wrote:
> > > 
> > > > device parallel resume support for PCI devices
> > > 
> > > There are some PCI devices which won't work right if they are resumed
> > > in parallel.  The example I have in mind is a USB host controller
> > > device with both a high-speed EHCI controller function and some
> > > companion low/full-speed UHCI or OHCI controller functions.  The EHCI
> > > driver relies on the fact that the EHCI controller has a higher
> > > function number and therefore is resumed _after_ the companion
> > > controllers.
> > > 
> > well, I never got this problem before.
> > is this normal? does this exist on the Intel hardware?
> > I'd like to do some test if I have chance.
> 
> Yes, it is normal, and it does exist on Intel hardware.  It isn't a 
> _problem_ (or at least, it hasn't been a problem up until now) because 
> the order of resuming devices is always the same as the order of 
> registration, which in turn is the same as the order of discovery.
> 
> You can see this on any Intel ICHx chipset.  I don't have an example 
> right here, but take a look at the machines you have lying around.  
> There are PCI UHCI controllers at 1d.0, 1d.1, ... and a PCI EHCI 
> controller at 1d.7.
> 
> The issue arises when you have a low-speed or full-speed device plugged 
> in.  The device is handed over from the EHCI controller to one of the 
> companion UHCI controllers, because EHCI manages only high-speed 
> devices.
> 
> Now consider what happens when the system wakes up from hibernation.  
> The controllers are re-initialized, and when ehci-hcd sees the
> low/full-speed device, it tries to hand the device over to the
> companion controller again.  But if the EHCI controller's resume method
> runs first then the handover will fail, because the companion
> controller has not yet been initialized.  As a result, the device will
> be lost and will have to go through rediscovery and re-enumeration.  
> This could be very annoying if, for example, the device contains a
> mounted filesystem.
> 
> > Just like the case above, can you give me a lspci output and show me
> > what exactly the dependency is?
> 
> The dependency is simple: The 1d.7 device must be resumed _after_ 1d.0, 
> 1d.1, ..., 1d.6.
Then I have a question, what if the uchi_hcd is not loaded?
the ehci host controller doesn't work in this case?

thanks,
rui
