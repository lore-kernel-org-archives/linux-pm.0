From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 00:48:36 +0200
Message-ID: <201106170048.37072.rjw__22008.5613117137$1308266271$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106161017310.2204-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106161017310.2204-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 16, 2011, Alan Stern wrote:
> On Wed, 15 Jun 2011, Kevin Hilman wrote:
> 
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > 
> > > On Wednesday, June 15, 2011, Kevin Hilman wrote:
> > 
> > [...]
> > 
> > >>
> > >> From a device driver perspective, system PM is just runtime
> > >> PM where the "idleness" was forced and only a subset of possible wakeup
> > >> sources are enabled.
> > >
> > > Oh well, I wonder how much of a difference would make you think those things
> > > are really different. ;-)
> > 
> > Seeing a description of the differences would help.  So far the list is
> > rather short: wakeups and forcibly quieting the hardware.
> 
> Another difference is that the user can forbid runtime power management 
> of any device through the power/control attribute, independently of 
> system sleeps.
> 
> Yet another difference arises because during system PM, the PM
> workqueue is frozen.  If a driver relies on asynchronous runtime PM
> then nothing will happen.  This may not apply to you, but it applies to
> plenty of other drivers.
> 
> > I guess I still don't see why system PM cannot be viewed as a special
> > case of runtime PM, so how about a specific question: From a device
> > driver perspective, how is system PM anything other than
> > manually/forcibly creating the right conditions for a runtime PM
> > transition to happen?
> 
> What you're missing is that runtime PM has two separate aspects: a 
> hardware/power aspect and an administrative aspect.  In terms of 
> hardware/power it is very similar to system PM, but in administrative 
> terms it is quite different.
> 
> Another thing you need to realize: Rafael is open to the idea that
> subsystems may be designed specifically to allow drivers to use runtime
> PM during their ->suspend and ->resume callbacks.  However in the
> period between ->suspend returning and ->resume being called, runtime
> PM should _not_ be used.  In particular, this includes the times when
> ->suspend_noirq and ->resume_noirq are called -- and these are the
> routines which are often expected to do the real work of setting the
> device's power state.

To be precise, my opinion is that calling pm_runtime_suspend() or
pm_runtime_put_sync() from a driver's .suspend() callback always is a bad
idea, because it leads to unnecessary complications and doesn't guarantee
that the desired action will take place at all.  That said I don't really
think that the PM core should actively prevent that from being done,
because it's not a direct correctness issue.  Using the runtime PM framework
after suspend_device_irqs() has run is a different problem, though, and
in my opinion the PM core should prevent that from being done, this way or
another.

Moreover, I don't have any problems with subsystems calling pm_runtime_resume()
or pm_runtime_get_sync() from their .prepare() callbacks, because that simply
causes devices to be put into a well known state before the "real" system
suspend callbacks are run.  In principle, drivers can do the same thing if
their subsystems don't, but that's not so obviously clean (given that the
same driver may be used with a few different PM domain implementations, for
example).

Thanks,
Rafael
