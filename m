From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [Resend][PATCH] PM: Move disabling/enabling runtime PM to late suspend/early resume
Date: Fri, 21 Dec 2012 11:52:56 -0800
Message-ID: <87d2y3dvxj.fsf@deeprootsystems.com>
References: <1988667.JSHu2WyJuF@vostro.rjw.lan>
	<3307221.dy6xvn45xe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3307221.dy6xvn45xe@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Sat, 15 Dec 2012 01:25:58 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jan-Matthias Braun <jan_braun@gmx.net>, Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Currently, the PM core disables runtime PM for all devices right
> after executing subsystem/driver .suspend() callbacks for them
> and re-enables it right before executing subsystem/driver .resume()
> callbacks for them.  This may lead to problems when there are
> two devices such that the .suspend() callback executed for one of
> them depends on runtime PM working for the other.  In that case,
> if runtime PM has already been disabled for the second device,
> the first one's .suspend() won't work correctly (and analogously
> for resume).
>
> To make those issues go away, make the PM core disable runtime PM
> for devices right before executing subsystem/driver .suspend_late()
> callbacks for them and enable runtime PM for them right after
> executing subsystem/driver .resume_early() callbacks for them.  This
> way the potential conflitcs between .suspend_late()/.resume_early()
> and their runtime PM counterparts are still prevented from happening,
> but the subtle ordering issues related to disabling/enabling runtime
> PM for devices during system suspend/resume are much easier to avoid.
>
> Reported-and-tested-by: Jan-Matthias Braun <jan_braun@gmx.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Yes!  

Of course if there are dependencies between drivers late/early
callbacks, we'll still have the same problems, but those should be
*very* rare compared to the suspend/resume dependencies.  

I haven't been able to do any testing with this yet (I'm away from my
hardware for a bit), but I totally support this change.  

Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks!

Kevin
