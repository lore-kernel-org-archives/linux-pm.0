From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm] PM: Introduce set_target method
	in pm_ops
Date: Sun, 24 Jun 2007 15:04:40 +0200
Message-ID: <200706241504.41009.rjw__19111.9387666278$1182690064$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
	<1182685788.10929.28.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1182685788.10929.28.camel@Dogbert.NOE.nokia.com>
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
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Len Brown <len.brown@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 24 June 2007 13:49, Igor Stoppa wrote:
> Hi,
> On Sat, 2007-06-23 at 20:28 -0400, ext Alan Stern wrote:
> > On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:
> > 
> > > > Is this design okay with system states in which the CPU is able to
> > run?
> > > 
> > > Do you mean the patch or the suggestions above?
> > 
> > The suggestions.
> > 
> > > > Right now the states we have are On, Standby, and Suspend, and the
> > CPU
> > > > runs only in the On state.  But on some platforms there could be
> > > > multiple states in which the CPU is able to run, albeit with
> > degraded 
> > > > performance.
> > > 
> > > I wouldn't call those system sleep states.  For example, ACPI
> > defines system
> > > sleep states as the states in which no instructions are executed by
> > any CPUs
> > > and I think that's reasonable.
> > > 
> > > Moreover, the ACPI spec insists that transitions between different sleep
> > > states should be made through the On state.
> > 
> > Okay.  But on non-ACPI systems, do we want to restrict the 
> > /sys/power/state interface to sleep states?  How then should the user 
> > tell the system to go to a low-performance run state?  Or should that 
> > be handled automatically within the kernel?
> 
> That's how we do it since Nokia IT 770 where we have:
>  
> /sys/power/sleep_while_idle
> 
> and if that's set to 1 (default), then in the idle loop we try to hit
> SoC retention.
> 
> Retention can be achieved if all the clocks have been released by their
> respective users. If not all the clocks are free, the system oscillator
> is not stopped and thereffore only some part will be in clock stop mode.
> This, still, yelds significant power saving.
> 
> There is also an architecture specific (OMAP1 vs OMAP2) way to control
> latency.
> 
> It's very rudimental and partially hackish: in OMAP2 it's mostly used to
> workaround some missing wakeup dependencies (some are not provided by
> the hw, some are not implemented properly by sw and should be fixed).
> 
> OMAP1: select ARM idle vs Big Sleep vs Deep Sleep
> 
> OMAP2: select ARM idle vs ARM retention, vs SoC retention
> 
> That's nice both from user's perspective (no need to worry about runtime
> pm, it just works) and driver developer's perspective (if your driver is
> for hw that has been properly wired, then using the clock fw interface
> is enough).
> 
> So if you want to implement dependencies betweeen userspace and
> kernelspace because your architecture has them builtin, it's ok, but
> they should not be forced upon those arch that don't need them.

Sure, if your platform core is not going to give the user any control over
the runtime PM, it should be able to tell the PM core about that, in which case
the top-level runtime PM interface should be inactive.

This is one of the reasons why I think that /sys/power/state should cover
system sleep states only.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
