From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable
 of generating run-time wake-up events
Date: Mon, 16 Nov 2009 16:00:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911161557130.2971-100000__15157.8258410611$1258405311$gmane$org@iolanthe.rowland.org>
References: <200911162152.38333.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911162152.38333.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:

> On Monday 16 November 2009, Alan Stern wrote:
> > On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Apparently, there are devices that can wake up the system from sleep
> > > states and yet are incapable of generating wake-up events at run
> > > time.  Thus, introduce a flag indicating if given device is capable
> > > of generating run-time wake-up events.
> > 
> > This raises the question: Who is responsible for setting the new 
> > flag?  The code that registers the device?
> 
> Yes, in general.  The platform.

And for non-platform devices (hot-pluggable, for example)?  Presumably 
you would want the driver that detects and registers the device to set 
this flag.

> Actually, I needed it for PCI, but I thought it would be better to put it at
> the core level.
> 
> > What if the kernel can't tell whether or not the device can generate 
> > runtime wake-up events?
> 
> Do you have any specific examples in mind?

What about Matthew's example of an ACPI GPE which might or might not 
cause a runtime wake-up event, depending on the AML code in the BIOS?

> > What if the user wants to override the kernel's setting?  Should there 
> > be a sysfs attribute controlling the flag?
> 
> I have no plans for adding anything like that.

So if the kernel makes a mistake here, the user won't be able to 
correct it.

Alan Stern
