From: David Brownell <david-b@pacbell.net>
Subject: Re: Wakeup requests during a system sleep transition
Date: Fri, 11 Nov 2005 18:29:13 -0800
Message-ID: <200511111829.13371.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0511081415490.4438-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96881399163333692=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0511081415490.4438-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============96881399163333692==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 08 November 2005 11:43 am, Alan Stern wrote:
> A question has come up recently in private conversations concerning remote 
> wakeup requests arriving while a system sleep transition is in progress.  
> How should they be handled?
> 
> There are at least three possibilities:
> 
>     (a) Carry out the wakeup request (i.e., resume the requesting device)
> 	and then abort the system sleep when the device's parent is told
> 	to suspend and it sees that its children aren't all suspended.

This probably makes the most sense to me ...


>     (b) Carry out the wakeup request, then sometime later try to recover
> 	by re-suspending the device that was just resumed, and continue
> 	the sleep transition.
> 
>     (c) Ignore the wakeup request and proceed with the sleep transition.
> 
> (a) is very simple and doesn't require any extra code, since drivers
> should already be checking to make sure that all the children are
> suspended before suspending their devices.  When the sleep transition is
> aborted, we can just return -ERESTARTSYS and force the user to try again
> -- exactly the same as would happen with any other interrupted system
> call.

That is, it requires faults on suspend to be handled reasonably.
Not a new requirement ... but quite possibly one that's not always
being satisfied.  And certainly one that's awkward to test.


> (b) is not a good solution, IMO.  It involves a pretty hairy recovery
> scheme that's not well defined.  It runs the risk of leaving some devices
> unsuspended while suspending their parents, or leaving data structures out
> of sync with the actual hardware state.  Furthermore I don't see any
> advantage in making the kernel do the re-suspend over making userspace
> restart the entire sleep transition, as in (a).

Although I'm not sure I'd see the point to having userspace try to
suspend again ... user said to wake up, after all!!

In general, (b) sounds complex and error prone.  Two things that
are IMO worth avoiding in the kernel.


> (c) seems like a reasonable approach.  It does, however, have a couple of
> problems.  First, drivers can't (currently) tell the difference between an
> overall system sleep and a device-specific runtime suspend.  Since we
> certainly _don't_ want to ignore device-wakeup requests during a runtime
> suspend, there's no way for a driver to ignore them during a system sleep
> transition.
> 
> The second thing to consider about (c) is that ignoring a wakeup request
> might not make it go away.  It will depend on the exact nature of the
> hardware and the type of request of course, but there's a good chance that
> the request will persist until the system finally goes to sleep.  At that
> point the request will immediately wake the system right back up.  The
> overall effect is the same as with (a) -- the system is awake at the end
> -- but you've wasted a lot of time and effort to get there.

Both are reasons I'd prefer (a).


> Now it's true that sometimes there will be no choice.  Once tasks are 
> frozen, there's no way to resume a device since doing so requires a 
> process context.  Then we'd be forced to adopt (c). 

On the other hand, a clean failure of the suspend would restart those
tasks nicely... I don't see that as an issue.


> However there are  
> situations where tasks are _not_ frozen during a sleep transition.  
> Suspend-To-RAM on PPC, for example.  What should happen in such cases?

Use (a).  ;)

- Dave

 
> Alan Stern
> 
> 

--===============96881399163333692==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96881399163333692==--
