From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Tue, 26 Jun 2007 00:14:20 +0200
Message-ID: <200706260014.21642.rjw__29139.9737274789$1182809293$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
	<200706241457.21237.rjw@sisk.pl>
	<200706241701.53971.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706241701.53971.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 25 June 2007 02:01, David Brownell wrote:
> On Sunday 24 June 2007, Rafael J. Wysocki wrote:
> > On Sunday, 24 June 2007 02:28, Alan Stern wrote:
> > > On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:
> > > 
> > > > > Right now the states we have are On, Standby, and Suspend, and the CPU
> > > > > runs only in the On state.  But on some platforms there could be
> > > > > multiple states in which the CPU is able to run, albeit with degraded 
> > > > > performance.
> 
> That starts to get into those cpufreq/"operating point" discussions".
> 
> 
> > > > I wouldn't call those system sleep states.  For example, ACPI defines system
> > > > sleep states as the states in which no instructions are executed by any CPUs
> > > > and I think that's reasonable.
> 
> Its Embedded Controller surely executes instructions!

Oh, I don't think that they regard the EC as a CPU, but never mind. :-)

> > > > Moreover, the ACPI spec insists that transitions between different sleep
> > > > states should be made through the On state.
> 
> Not that the world should feel compelled to restrict itself to what
> ACPI envisions of course...

Sure, but if ACPI does something in a reasonable way, then why not?
 
> > > Okay.  But on non-ACPI systems, do we want to restrict the 
> > > /sys/power/state interface to sleep states?  How then should the user 
> > > tell the system to go to a low-performance run state?  Or should that 
> > > be handled automatically within the kernel?
> > 
> > I think that the /sys/power/state interface should be restricted to system
> > sleep states only and we should introduce another one for handling non-sleep
> > low-power states.
> 
> Then /sys/power/state would more accurately be named something
> like /sys/power/sleep_state, right?

Yes, but there's user land that uses this interface.  Let's not confuse it.

> The core reason it would make sense to have such a bifurcation is
> IMO that those lower power operating states mostly shouldn't involve
> walking the device tree and suspending everything.  They involve some
> set of hardware (possibly including CPUs) entering low power states.
> But not *every* bit of hardware.
> 
> Another aspect here is what idle state is used.  Sometimes that
> can be all but indistinguishable from a "sleep" state.

Yes.  I think we can define a 'system sleep state' as a state that requires
the main code path in kernel/power/main.c (starting from enter_state()) to be
executed in order for the system to enter it.

> > IMHO, the kernel can automatically transition to non-sleep low-power states,
> > but the users should be able to define the conditions for that.  Also, the user
> > should be able to force the transition if necessary/desired.
> 
> There are several ways those lowpower run states can be entered.
> But I'm not keen on userspace being able to "force" transitions
> like that.
> 
> IMO it's strongly preferable if the platform code -- perhaps its
> custom idle loop -- inventories the system regularly to see if
> it's eligible to enter one of the states.
> 
> As a rule, if certain resources are in use that means related
> power states can't be entered.  If they're in use, then userspace
> trying to force a transition means breaking something -- else
> those resources would stay used!
> 
> The similarity with cpufreq is obvious:  cpufreq inventories the
> CPU usage regularly to see if the CPU should be revved up or down.
> 
> Now, inputs to that inventory can come from userspace ... there's
> information about upcoming usage that the kernel could otherwise
> only guess at.  User exiting the video playback app, vs just pausing
> it, might suggest more aggressive savings are appropriate; etc.
> Userspace can also provide tuning parameters.  I have no problems
> with that model.

OK

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
