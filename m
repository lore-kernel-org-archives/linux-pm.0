From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH] PCI / PCIe: Ask BIOS for control of all
	native	services simultaneously
Date: Tue, 27 Jul 2010 19:56:28 +0100
Message-ID: <20100727185628.GA17903__16596.4905325838$1280257061$gmane$org@srcf.ucam.org>
References: <201007250105.23610.rjw@sisk.pl> <4C4E2BBD.7080003@jp.fujitsu.com>
	<20100727171842.GB7324@srcf.ucam.org>
	<201007272042.39269.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201007272042.39269.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 27, 2010 at 08:42:39PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 27, 2010, Matthew Garrett wrote:
> > I've done some more testing of this and found that my intial belief 
> > (supported by Microsoft's documentation...) that all PCIe support had to 
> > be handed over for any to be used is incorrect. It turns out that the 
> > firmware must support native hotplug, native power management and PCI 
> > express capability structure control - ie, SHPC and AER aren't required.
> 
> But the ACPI spec says quite explicitly that PCIe capability control is
> necessary for AER as well.

I may not have been clear. If the firmware doesn't report AER, Windows 
will use PME and hotplug. If the firmware doesn't support hotplug, 
Windows will *not* use PME or AER, and ditto if it doesn't support PME.

> > (2) If any of bits 0, 2 and 4 are unsupported, disable all PCIe support 
> > via _OSC
> 
> I guess you mean "don't request control of that services at all"?

I mean pass 0 as the third dword in our _OSC call.

> > (3) Ask for the set of supported bits & 0x1d
> 
> Really, if we try to treat native PME, native hot-plug and AER separately
> (which is our current approach), we fall into a Catch 22 situation where
> each of them needs PCIe capability control and once we've received the
> control of that, we have no choice but to use the other native sevices as well.

It seems that it's valid to have hotplug and PME without AER. The 
behaviour of Windows for each bit is:

0 Hotplug             Required
1 SHPHC               Will never request
2 PME                 Required
3 AER                 Optional
4 capability control  Required

So firmware can refuse to support SHPHC and AER and still get PCIe 
support, but if any of the required bits aren't available Windows won't 
use *any* of the _OSC-provided functions.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
