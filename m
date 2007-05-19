From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sun, 20 May 2007 01:20:45 +0200
Message-ID: <200705200120.45892.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705191714070.32062-100000@netrider.rowland.org>
	<200705200053.58388.rjw@sisk.pl>
	<464F8395.4080300@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F8395.4080300@s5r6.in-berlin.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 20 May 2007 01:09, Stefan Richter wrote:
> Rafael J. Wysocki wrote:
> > Can you please try to set CONFIG_SOFTWARE_SUSPEND and see if that helps?
> 
> I will do so.  BTW,
> 
> config SOFTWARE_SUSPEND
> 	bool "Software Suspend (Hibernation)"
> 	depends on PM && SWAP && (((X86 || PPC64_SWSUSP) && (!SMP ||
> 			SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
> 
> and
> 
> config SUSPEND_SMP
> 	bool
> 	depends on HOTPLUG_CPU && (X86 || PPC64) && PM
> 
> So, no HOTPLUG_CPU -> no SOFTWARE_SUSPEND.  I don't expect a
> single-processor, dual-core PC to require CPU hotplugging support.

We use the CPU hotplug code for disabling/enabling nonboot CPUs.

You need to enable it to be able to suspend (BTW, it's also necesary for
the suspend to RAM).

Greetings,
Rafael
