From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable
 of generating run-time wake-up events
Date: Mon, 16 Nov 2009 14:39:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911161436560.2971-100000__36714.1355913647$1258400408$gmane$org@iolanthe.rowland.org>
References: <200911160049.22717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911160049.22717.rjw@sisk.pl>
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

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Apparently, there are devices that can wake up the system from sleep
> states and yet are incapable of generating wake-up events at run
> time.  Thus, introduce a flag indicating if given device is capable
> of generating run-time wake-up events.

This raises the question: Who is responsible for setting the new 
flag?  The code that registers the device?

What if the kernel can't tell whether or not the device can generate 
runtime wake-up events?

What if the user wants to override the kernel's setting?  Should there 
be a sysfs attribute controlling the flag?

Alan Stern
