From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Ottawa Linux Power Management Summit, June 25-26,
	2007
Date: Fri, 1 Jun 2007 14:45:35 -0700
Message-ID: <20070601214535.GA8108__7827.32790471545$1180734606$gmane$org@linux.intel.com>
References: <200705310037.07367.lenb@kernel.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705310037.07367.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Kenneth <kenroz@us.ibm.com>, linux-acpi@vger.kernel.org, Tariq Shureih <tariq.shureih@intel.com>, "Pedersen Klaus.K (Nokia-M/Helsinki)" <klaus.k.pedersen@nokia.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 31, 2007 at 12:37:06AM -0400, Len Brown wrote:
> Logistics: 
> 
> Monday, June 25th
> Tuesday, June 26th
> 
> We have the "Garden Suite" in Les Suites Ottawa at our disposal 9AM - 6PM (thanks Intel).
> The room has 20 seats.  It also has natural light:-)
> 
> Format:
> 
> Hopefully small enough that we can hold single threaded round-table discussions.
> 
> We'll also have a projector so folks can make some short presentations to get people
> in the room on the same page.
> 
> Record:
> 
> I volunteer to take notes.
> After the meetings I'll send them to the attendees for review.
> With Mark, I also volunteer to present them at the OLS PM BOF,
> and send them to linux-pm, and LWN.
> 
> Attendees:
> 
> I believe the 12 below will attend -- please correct me if I'm mistaken.
> I didn't include folks who said "maybe," or folks who "might drop-in."
> (order is arbitrary here, based on copy/paste from my mailbox)
> If you want a better "personal summary" for the notes than
> I conjured up here, please sent it to me and I'll get it right next time.
> 
> Len Brown <len.brown@intel.com>
> 	Linux Kernel ACPI Maintainer
> 	Willing to give a 30-min ACPI PM presentation,
> 	though if attendees are mostly focused on non-ACPI embedded,
> 	happy to skip doing so.
> 
> Dave Jones <davej@redhat.com>
> 	Fedora Maintainer, Linux Kernel Cpufreq Maintainer
> 	Len wants Dave to lead a candid discussion on
> 	the lessons learned from cpufreq.
> 
> Mark Gross <mgross@linux.intel.com>
> 	Intel OTC embedded Linux team

	I will be ready to talk about user mode guided power management,
	where (when needed) user mode identifies its latency,
	throughput, and perhaps a very small number of other nuggets, as
	constraints to the subsystems in the form of "hints" or requests
	such that the subsystems can can use to set optimal power
	savings without violating the requests passed down.

	--mgross
> 
> Tariq Shureih <tariq.shureih@intel.com>
> 	Intel OTC MID power policy manager
> 
> "Pedersen Klaus.K (Nokia-M/Helsinki)" <klaus.k.pedersen@nokia.com>
> Igor Stoppa <igor.stoppa@nokia.com>
> Poussa Sakari <sakari.poussa@nokia.com>
> 	Will make a short presentation about latest developments
> 	in Nokia N800 power management area.
> 
> Matthew Locke <matt@nomadgs.com>
> "Eugeny S. Mints" <eugeny.mints@gmail.com>
> 
> 	Our primary interest is unified 
> 	cross platforms pm API to control pm hardware (covering both x86 and embedded), 
> 	constraints (including  latencies) engine, pm subsystem/drivers interface, API 
> 	for use case driven pm.
> 
> "Scott E. Preece" <preece@motorola.com>
> 
> 	I would love to see agreement on a way to structure PM so that different
> 	kinds of systems could better meet their different goals...
> 
> Vivek Kashyap <kashyapv@us.ibm.com>
> Kenneth <kenroz@us.ibm.com>
> 	We are interested in cross 
> 	platform (PowerPC, x86) power management, pm controls and policies, 
> 	pm based scheduling, pm in presence of hypervisors, and power scaled 
> 	cpu utilization statistics.
> 
> 
> Agenda Suggestions:
> 
> With 3+ weeks to go, it is time to firm up the agenda.
> To seed the discussion, here are some notes from my mailbox:
> 
> From: Poussa Sakari <sakari.poussa@nokia.com>
> we in this context mean people involved in Nokia Internet Tablet
> power management development (Igor, Klaus and myself).
> 
> - Presentation of DVFS in Nokia N800 including
>   - integration with clock framework and needed enhancements
>   - role of the voltage and other frameworks
> 
> - Future power management challenges in Nokia Internet Tablets
>   - next omap and new requirements 
>   - power aware applications and policies
>   - pm interface between kernel and pm aware applications
> 
> - Current budgeting in embedded USB host
>   - how to balance the current flow from battery to usb peripheral
>  
> - How to use the clk fw to express constraints
>   - between clocks
>   - between clocks and voltages
> 
> - How to address power domains with timeouts
>   - simple bitfields management example
> 
> 
> From: Amit Kucheria
> 1. Unified interface to dynamic/runtime PM for laptop/server and
> embedded platforms - Does it make sense?
> 2. Enhancements to Linux driver model to handle dynamic PM
> 3. Where should policy be located? Drivers or userspace or a mix of both?
> 4. Interfaces to userspace policy manager
> 5. Can x86 device drivers and bus drivers do more runtime PM? Similar
> to some of the USB work being carried on by Alan/David.
> 6. What can be done to ensure Suspend To RAM _always_ works? Video
> drivers are the big problem now, anything else?
> 7. Using wakeup latency as a parameter to decide how deep we want to sleep
