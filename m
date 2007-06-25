From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Sun, 24 Jun 2007 17:01:52 -0700
Message-ID: <200706241701.53971.david-b__48127.8131287128$1182731804$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
	<200706241457.21237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706241457.21237.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 24 June 2007, Rafael J. Wysocki wrote:
> On Sunday, 24 June 2007 02:28, Alan Stern wrote:
> > On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:
> > 
> > > > Right now the states we have are On, Standby, and Suspend, and the CPU
> > > > runs only in the On state.  But on some platforms there could be
> > > > multiple states in which the CPU is able to run, albeit with degraded 
> > > > performance.

That starts to get into those cpufreq/"operating point" discussions".


> > > I wouldn't call those system sleep states.  For example, ACPI defines system
> > > sleep states as the states in which no instructions are executed by any CPUs
> > > and I think that's reasonable.

Its Embedded Controller surely executes instructions!


> > > Moreover, the ACPI spec insists that transitions between different sleep
> > > states should be made through the On state.

Not that the world should feel compelled to restrict itself to what
ACPI envisions of course...


> > Okay.  But on non-ACPI systems, do we want to restrict the 
> > /sys/power/state interface to sleep states?  How then should the user 
> > tell the system to go to a low-performance run state?  Or should that 
> > be handled automatically within the kernel?
> 
> I think that the /sys/power/state interface should be restricted to system
> sleep states only and we should introduce another one for handling non-sleep
> low-power states.

Then /sys/power/state would more accurately be named something
like /sys/power/sleep_state, right?

The core reason it would make sense to have such a bifurcation is
IMO that those lower power operating states mostly shouldn't involve
walking the device tree and suspending everything.  They involve some
set of hardware (possibly including CPUs) entering low power states.
But not *every* bit of hardware.

Another aspect here is what idle state is used.  Sometimes that
can be all but indistinguishable from a "sleep" state.


> IMHO, the kernel can automatically transition to non-sleep low-power states,
> but the users should be able to define the conditions for that.  Also, the user
> should be able to force the transition if necessary/desired.

There are several ways those lowpower run states can be entered.
But I'm not keen on userspace being able to "force" transitions
like that.

IMO it's strongly preferable if the platform code -- perhaps its
custom idle loop -- inventories the system regularly to see if
it's eligible to enter one of the states.

As a rule, if certain resources are in use that means related
power states can't be entered.  If they're in use, then userspace
trying to force a transition means breaking something -- else
those resources would stay used!

The similarity with cpufreq is obvious:  cpufreq inventories the
CPU usage regularly to see if the CPU should be revved up or down.

Now, inputs to that inventory can come from userspace ... there's
information about upcoming usage that the kernel could otherwise
only guess at.  User exiting the video playback app, vs just pausing
it, might suggest more aggressive savings are appropriate; etc.
Userspace can also provide tuning parameters.  I have no problems
with that model.

- Dave
