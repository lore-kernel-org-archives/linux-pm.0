From: Alan Stern <stern@rowland.harvard.edu>
Subject: System sleep vs. runtime PM
Date: Wed, 2 Dec 2009 13:35:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912021143250.2668-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael and Oliver:

I'm in the midst of converting USB over to the runtime PM framework,
and I'm getting stuck on the interaction between system sleep and
runtime PM.  In fact, I'm so confused about it that it's hard to
formulate a coherent set of questions.  So bear with me...

If a driver gets an output request and its device is runtime-suspended,
then the driver should do a runtime-resume before sending the output to
the device.  If the output request arrives during a system sleep
transition then the output should be refused or left to sit in a queue
(presumably this won't happen, but it might).

However this requires the driver to know when a system sleep is in
progress -- it's not enough merely to know whether the device is
suspended.  We could make things easier for the driver by failing
runtime-resume requests when the device's power.status isn't DPM_ON or
DPM_RESUMING.  Does that make sense?

But then what about remote wakeup?  The arrival of a remote-wakeup
request during a sleep transition has always been problematic.  Should
the request be allowed to abort the sleep transition?  (Once the kernel
is aware of the request, it is probably no longer stored in the
hardware so it won't wake the system back up as soon as we go to
sleep.)

What if the device is enabled for runtime remote wakeup and not for
wakeup from system sleep?  There will be a window during which the
wakeup settings are wrong.  Should a wakeup request from such a device
be allowed to abort a sleep transition?

If a remote-wakeup request should abort the system sleep, how do we
make this happen?

If a remote-wakeup request doesn't abort the system sleep, then what 
happens to it?  Obviously it should get serviced when the system wakes 
up again.  But what if the device was runtime-suspended when the sleep 
began?  How do we make sure it gets runtime-resumed when the sleep 
ends?

I can see two possibilities here.  One is that the remote-wakeup
request triggered an asynchronous pm_request_wakeup().  In this case
the request is sitting on the PM workqueue and it will automatically be
satisfied after the system wakes back up.  The other possibility is
that the request triggered a synchronous pm_runtime_resume().  If this
fails because a sleep transition is in progress, the request will get
lost.  (The same sort of thing happens when output requests get stuck
in a queue and the runtime-resume fails.)

This suggests that the safest course is for dpm_resume() to
automatically do a pm_runtime_resume() on every device.  Is this
drastic overkill?  Should we keep a record when we fail a
runtime-resume during a sleep transition and then runtime-resume only
those devices?

Then there's the whole sticky question about how to handle devices
whose runtime-wakeup and system-sleep-wakeup settings need to be
different.  In many cases the setting can't be changed unless the
device is at full power.  Such devices would always need to be
runtime-resumed both before and after every system sleep (during 
the prepare and complete phases).  Should the bus subsystem be 
responsible for this?  (Don't forget that during the prepare phase, the 
device's state will be DPM_PREPARING and so the bus subsystem won't be 
allowed to do a runtime resume.)

There's probably a good deal more to discuss, but this is all I can 
think of at the moment.

Alan Stern
