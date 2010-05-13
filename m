From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 15:26:36 -0700
Message-ID: <AANLkTikrRZtMDHqgHmQsxxUoSdS4nXV02byX-hdslNSU__42066.4768120789$1273789712$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
	<20100513191717.GA3428@atomide.com>
	<20100513192522.GA19256@srcf.ucam.org>
	<20100513194205.GC3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513194205.GC3428@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 12:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Matthew Garrett <mjg@redhat.com> [100513 12:20]:
>> On Thu, May 13, 2010 at 12:17:17PM -0700, Tony Lindgren wrote:
>> > The suspend blocks seems like a hack to spam filter good and bad
>> > apps from timer usage point of view. Applications are categorized
>> > as good or bad depending if they grab a susped blocker or not.
>> >
>> > I believe categorizing the apps should be instead done with some
>> > timer flags or cgroups instead.
>>
>> I agree, but we have no mechanism for implementing that in a race-free
>> way. We don't even have a realistical proposal for what that mechanism
>> would look like. Should we refuse bread today for the promise of cake
>> tomorrow?
>
> Well this is an interesting problem, and once solved will be handy
> for all kind of things. My worry is that if it's integrated in it's
> current form it will be totally out of control all over the place :(
>
> Still hoping we can come up with some clean way that avoid the patching
> all over the place part.. How about the following, can you please check
> if it would help with your example of guaranteed handling of event:
>
> 1. In the kernel, we add one more timer queue for critical timers.
> =A0 The current timer queue(s) stay as it is.
>
> 2. We allow selecting the timer based on some flag, the default
> =A0 behaviour being the current default timer queue.
>
> 3. Then we add next_timer_interupt_critical() to only query the
> =A0 critical timers along the lines of the current next_timer_interrupt().
>
> 4. We implement a custom pm_idle that suspends the system based on
> =A0 some logic and checking if next_timer_interrupt_critical() is
> =A0 empty. If the next_timer_interrupt_critical() does not return
> =A0 anything, we assume it's OK to suspend the system.
>

I think trying to solve this at the timer level requires more patching
than using suspend blockers. With suspend blocker you block suspend
until some work has finished, or an event has been consumed. You can
safely use any existing synchronous api.

> Now to me it sounds if your the input layer and userspace handle
> both grab the timers with the critical flags, it should be guaranteed
> that the events get handled before the system is suspended.
>

There are no timers used in this path. However any critical section
used from this path could cause the system to enter idle. Instead of
blocking suspend while there are unprocessed input event you now have
to make sure all code that can block any of the threads involved in
processing those event don't wait on a non critical timer.

-- =

Arve Hj=F8nnev=E5g
