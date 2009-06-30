From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC] Run-time PM framework (was: Re: [patch update] PM:
	Introduce core framework for run-time PM of I/O devices (rev. 6))
Date: Wed, 1 Jul 2009 00:30:12 +0200
Message-ID: <200907010030.13775.rjw__5970.90308224342$1246401565$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906301027540.3049-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906301027540.3049-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 June 2009, Alan Stern wrote:
... 
> That's enough to give you the general idea.  I think this design is 
> a lot cleaner than the current one.

Well, I'm not really happy with starting over, but if you think we should do
that, then let's do it.

I think we both agree that the callbacks, ->runtime_idle(), ->runtime_suspend()
and ->runtime_resume() make sense.  Now, the role of the framework, IMO, is to
provide a mechanism by which it is possible:
(1) to schedule a delayed execution of ->runtime_suspend(), possibly from
    interrupt context,
(2) to schedule execution of ->runtime_resume() or ->runtime_idle(), possibly
    from interrupt context,
(3) to execute ->runtime_suspend() or ->runtime_resume() directly in a
    synchronous way (I'm not sure about ->runtime_idle())
_and_ to ensure that these callbacks will be executed when it makes sense.
There's no other point, because the core has no information to make choices,
it can only prevent wrong things from happening, if possible.

I think you will agree that the users of the framework should be able to
prevent ->runtime_suspend() from being called and that's what the usage counter
is for.  Also, IMO it should be impossible to execute ->runtime_idle(), via the
framework, when the usage counter is nonzero.

BTW, I don't think resume_count is the best name; it used to be in the version
of my patch where it was automatically incremented when ->runtime_resume() was
about to called.  usage_count is probably better.

Next, I think that the framework should refuse to call ->runtime_suspend() and
->runtime_idle() if the children of the device are not suspended and the
"ignore children" flag is unset.  The counter of unsuspended children is used
for that.  I think the rule should be that it is decremented for the parent
whenever ->runtime_suspend() is called for a child and it is incremented
for the parent whenever ->runtime_resume() is called for a child.

Now, the question is what rules should apply to the ordering and possible
simultaneous execution of ->runtime_idle(), ->runtime_suspend() and
->runtime_resume().  I think the following rules make sense:

  * It is forbidden to run ->runtime_suspend() twice in a row.

  * It is forbidden to run ->runtime_suspend() in parallel with another instance
    of ->runtime_suspend().

  * It is forbidden to run ->runtime_resume() twice in a row.

  * It is forbidden to run ->runtime_resume() in parallel with another instance
    of ->runtime_resume().

  * It is allowed to run ->runtime_suspend() after ->runtime_resume() or after
    ->runtime_idle(), but the latter case is preferred. 

  * It is allowed to run ->runtime_resume() after ->runtime_suspend().

  * It is forbidden to run ->runtime_resume() after ->runtime_idle().

  * It is forbidden to run ->runtime_suspend() and ->runtime_resume() in
    parallel with each other.

  * It is forbidden to run ->runtime_idle() twice in a row.

  * It is forbidden to run ->runtime_idle() in parallel with another instance
    of ->runtime_idle().

  * It is forbidden to run ->runtime_idle() after ->runtime_suspend().

  * It is allowed to run ->runtime_idle() after ->runtime_resume().

  * It is allowed to execute ->runtime_suspend() or ->runtime_resume() when
    ->runtime_idle() is running.  In particular, it is allowed to (indirectly)
    call ->runtime_suspend() from within ->runtime_idle().

  * It is forbidden to execute ->runtime_idle() when ->runtime_resume() or
    ->runtime_suspend() is running.

  * If ->runtime_resume() is about to be called immediately after
    ->runtime_suspend(), the execution of ->runtime_suspend() should be
    prevented from happening, if possible, in which case the execution of
    ->runtime_resume() shouldn't happen.

  * If ->runtime_suspend() is about to be called immediately after
    ->runtime_resume(), the execution of ->runtime_resume() should be
    prevented from happening, if possible, in which case the execution of
    ->runtime_suspend() shouldn't happen.

[Are there any more rules related to these callbacks we should take into
account?]

Next, if we agree about the rules above, the question is what helper functions
should be provided by the core allowing these rules to be followed
automatically and what error codes should be returned by them in case it
wasn't possible to proceed without breaking the rules.

IMO, it is reasonable to provide:

  * pm_schedule_suspend(dev, delay) - schedule the execution of
    ->runtime_suspend(dev) after delay.

  * pm_runtime_suspend(dev) - execute ->runtime_suspend(dev) right now.

  * pm_runtime_resume(dev) - execute ->runtime_resume(dev) right now.

  * pm_request_resume(dev) - put a request to execute ->runtime_resume(dev)
    into the run-time PM workqueue.

  * pm_runtime_get(dev) - increment the device's usage counter.

  * pm_runtime_put(dev) - decrement the device's usage counter.

  * pm_runtime_idle(dev) - execute ->runtime_idle(dev) right now if the usage
    counter is zero and all of the device's children are suspended (or the
    "ignore children" flag is set).

  * pm_request_idle(dev) - put a request to execute ->runtime_idle(dev)
    into the run-time PM workqueue.  The usage counter and children will be
    checked immediately before executing ->runtime_idle(dev).

I'm not sure if it is really necessary to combine pm_runtime_idle() or
pm_request_idle() with pm_runtime_put().  At least right now I don't see any
real value of that.

I also am not sure what error codes should be returned by the above helper
functions and in what conditions.

Thanks,
Rafael
