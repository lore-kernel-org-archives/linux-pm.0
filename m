From: Oliver Neukum <oliver@neukum.org>
Subject: Re: System sleep vs. runtime PM
Date: Wed, 2 Dec 2009 22:16:18 +0100
Message-ID: <200912022216.18620.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0912021143250.2668-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912021143250.2668-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 2. Dezember 2009 19:35:34 schrieb Alan Stern:
> Rafael and Oliver:
> 
> I'm in the midst of converting USB over to the runtime PM framework,
> and I'm getting stuck on the interaction between system sleep and
> runtime PM.  In fact, I'm so confused about it that it's hard to
> formulate a coherent set of questions.  So bear with me...
> 
> If a driver gets an output request and its device is runtime-suspended,
> then the driver should do a runtime-resume before sending the output to
> the device.  If the output request arrives during a system sleep
> transition then the output should be refused or left to sit in a queue
> (presumably this won't happen, but it might).

How can it happen? As the freezer has run before drivers learn
about a sleep transition, the request would come from a kernel thread.

> However this requires the driver to know when a system sleep is in
> progress -- it's not enough merely to know whether the device is
> suspended.  We could make things easier for the driver by failing
> runtime-resume requests when the device's power.status isn't DPM_ON or
> DPM_RESUMING.  Does that make sense?

That is not a good idea as it needs error handling in all drivers
for a rare corner case. That's bound to cause many bugs.

> But then what about remote wakeup?  The arrival of a remote-wakeup
> request during a sleep transition has always been problematic.  Should
> the request be allowed to abort the sleep transition?  (Once the kernel
> is aware of the request, it is probably no longer stored in the
> hardware so it won't wake the system back up as soon as we go to
> sleep.)

It should abort the sleep if the device would wake the system from sleep.

> What if the device is enabled for runtime remote wakeup and not for
> wakeup from system sleep?  There will be a window during which the
> wakeup settings are wrong.  Should a wakeup request from such a device
> be allowed to abort a sleep transition?

The core should prevent that window. If necessary devices with
different wakeup settings should be resumed before starting system sleep.
 
> If a remote-wakeup request should abort the system sleep, how do we
> make this happen?

Good question. I have no answer.

> If a remote-wakeup request doesn't abort the system sleep, then what
> happens to it?  Obviously it should get serviced when the system wakes
> up again.  But what if the device was runtime-suspended when the sleep
> began?  How do we make sure it gets runtime-resumed when the sleep
> ends?
> 
> I can see two possibilities here.  One is that the remote-wakeup
> request triggered an asynchronous pm_request_wakeup().  In this case
> the request is sitting on the PM workqueue and it will automatically be

That sounds very reasonable.

> satisfied after the system wakes back up.  The other possibility is
> that the request triggered a synchronous pm_runtime_resume().  If this
> fails because a sleep transition is in progress, the request will get
> lost.  (The same sort of thing happens when output requests get stuck
> in a queue and the runtime-resume fails.)

That must not happen.

	Regards
		Oliver
