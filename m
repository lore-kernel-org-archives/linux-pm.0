From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 19:01:55 -0600
Message-ID: <20070401010155.GA10151@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703310952.43696.david-b@pacbell.net>
	<20070331181612.GD8091@cosmic.amd.com>
	<200703311157.03975.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <200703311157.03975.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On 31/03/07 11:57 -0700, David Brownell wrote:
> The other part is the platform code.  On embedded hardware that's usually
> just calling device_init_wakeup() before registering the platform devices,
> and supporting enable_irq_wake().  On x86 that gets messy; ACPI is there,
> and PCI initialization can't set device_init_wakeup() because of conflicts
> with how PPC initializes PCI.

enable_irq_wake() looks like it integrates very well with the AT91, since
it seems that there is a 1:1 mapping of interrupts to wakeup sources.  The
story is much more muddled for x86 - there is no direct mapping of interrupts
to wakeup sources, and the PIC has nothing to do with handling wake events.

On the Geode, we have 17 possible wake sources, all of which are ORed
together to form the SCI interrupt. Some of the events, like the RTC,
UART, and USB wakeup sources are associated with devices that have their
own interrupts, but there is no correlation between the RTC interrupt, 
for example, and enabling it as a wakeup source.  It seems overly complex
to try to map these to individual interrupts, and certainly seems wasteful
to get the PIC involved in something it just doesn't understand.

> As in "echo enabled > /sys/devices/.../power/wakeup" (to get the default),
> or "echo disabled > ..." to disable it.  For PCs, with ACPI, that involves
> two patches I just posted to the RTC list (and CC'd Len on), and replacing
> the ancient/legacy/ACPI-only /proc/acpi/alarm interface.

The link is here for the interested:

http://groups.google.com/group/rtc-linux/browse_thread/thread/ae7fe3436e01e7fa

This looks very good, and is pretty close to what I was proposing.  
Replace the acpi_*_event() calls with a generic pm_ infrastructure, and
add hooks to the pm_ops for each individual PM system to handle the wakeups
in whatever way they see fit, and we're there.  It would be slightly more
complex for AT91 and friends to match this (since they have the advantage
of a 1:1 mapping right now), but in the long run, I think everybody would
benefit.

The only other issue then, is how we could define and manage wakeup events
for events that aren't associated with specific devices, like power button
and lid events.  We'll need some way to control those somewhere in sysfs -
if not in /sys/power/wakeup like I had proposed, then somewhere under the
platform or system hierarchy .

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>
