From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable
	of generating run-time wake-up events
Date: Mon, 16 Nov 2009 21:52:38 +0100
Message-ID: <200911162152.38333.rjw__32548.0518084534$1258404757$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0911161436560.2971-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911161436560.2971-100000@iolanthe.rowland.org>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 November 2009, Alan Stern wrote:
> On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Apparently, there are devices that can wake up the system from sleep
> > states and yet are incapable of generating wake-up events at run
> > time.  Thus, introduce a flag indicating if given device is capable
> > of generating run-time wake-up events.
> 
> This raises the question: Who is responsible for setting the new 
> flag?  The code that registers the device?

Yes, in general.  The platform.

Actually, I needed it for PCI, but I thought it would be better to put it at
the core level.

> What if the kernel can't tell whether or not the device can generate 
> runtime wake-up events?

Do you have any specific examples in mind?

> What if the user wants to override the kernel's setting?  Should there 
> be a sysfs attribute controlling the flag?

I have no plans for adding anything like that.

Rafael
