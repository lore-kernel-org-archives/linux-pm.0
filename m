From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable
	of	generating run-time wake-up events
Date: Mon, 16 Nov 2009 21:05:45 +0000
Message-ID: <20091116210545.GA29696__33361.201969865$1258405635$gmane$org@srcf.ucam.org>
References: <200911162152.38333.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0911161557130.2971-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0911161557130.2971-100000@iolanthe.rowland.org>
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

On Mon, Nov 16, 2009 at 04:00:49PM -0500, Alan Stern wrote:
> On Mon, 16 Nov 2009, Rafael J. Wysocki wrote:
> > Yes, in general.  The platform.
> 
> And for non-platform devices (hot-pluggable, for example)?  Presumably 
> you would want the driver that detects and registers the device to set 
> this flag.

Are there any cases where the bus code won't know this?

> > > What if the kernel can't tell whether or not the device can generate 
> > > runtime wake-up events?
> > 
> > Do you have any specific examples in mind?
> 
> What about Matthew's example of an ACPI GPE which might or might not 
> cause a runtime wake-up event, depending on the AML code in the BIOS?

The platform knows whether or not that's the case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
