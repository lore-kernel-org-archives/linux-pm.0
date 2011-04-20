From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Core: suspend_again cb for
	syscore_ops
Date: Wed, 20 Apr 2011 12:36:41 +0200
Message-ID: <20110420103641.GA1789__28957.4557952166$1303305927$gmane$org@ucw.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> A system or a device may need to control suspend/wakeup events. It may
> want to wakeup the system after a predefined amount of time or at a
> predefined event decided while entering suspend for polling or delayed
> work. Then, it may want to enter suspend again if its predefined wakeup
> condition is the only wakeup reason and there is no outstanding events;
> thus, it does not wakeup the userspace unnecessary and keeps suspended
> as long as possible (saving the power).

Nice. Zaurus needs it, exactly due to this reason:

> 2. Execute critical "delayed work" at suspend.
>  A driver or a system/board may have a delayed work (or any similar
> things) that it wants to execute at the requested time.
>  For example, some chargers want to check the battery voltage some
> time (e.g., 30 seconds) after the battery is fully charged and the
> charger stops. Then, the charger restarts charging if the voltage has
> dropped more than a threshold, which is smaller than "restart-charger"
> voltage, which is a threshold to restart charging regardless of the
> time passed.

Yep, and zaurus also needs it to stop charging.

> The system enters the suspend again if and only if all of the following
> conditions are met:
> 1. None of suspend_again ops returned "I want to stop suspend"
> (suspend_again returns SUSPEND_AGAIN_STOP).
> 2. At least one of suspend_again ops returned "I want to suspend again"
> (suspend_again returns SUSPEND_AGAIN_CONTINUE)

Better naming  could be SUSPEND_AGAIN and VETO_RESUSPEND or
SUSPEND_AGAIN_VETO .

> Anyway, the following features may need to be added later:
> 1. An API to allow devices to express next desired wakeup-time. Then,
> the framework will combine them and setup RTC alarm accordingly and
> save/restore previously registered RTC alarms.

Yep.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
