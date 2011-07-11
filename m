From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC] Unprepare callback for cpuidle_device
Date: Tue, 12 Jul 2011 00:38:56 +0530
Message-ID: <20110711190856.GC25533@dirshya.in.ibm.com>
References: <a619d8bbefd2f390a13d09084583dd39.squirrel@www.codeaurora.org>
	<4E15516E.5040209@gmail.com>
	<82b596dce7b84db206d3afb6da564fb9.squirrel@www.codeaurora.org>
	<4E170010.2000403@linux.vnet.ibm.com>
	<473338c2d56302337f83871ce1c201e4.squirrel@www.codeaurora.org>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <473338c2d56302337f83871ce1c201e4.squirrel@www.codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: asinghal@codeaurora.org
Cc: linux-pm@lists.linux-foundation.org, johlstei@codeaurora.org
List-Id: linux-pm@vger.kernel.org

* asinghal@codeaurora.org <asinghal@codeaurora.org> [2011-07-11 10:26:56]:

> hello Deepthi,
>           please see my replies inline:
> 
> 
> > Hi Amar,
> >
> > On Friday 08 July 2011 01:22 AM, asinghal@codeaurora.org wrote:
> >> Hello Trinabh,
> >>               i cannot use the enter callback due to the following
> >> reason:
> >>
> >> the residency calculation(tick)nohz_get_sleep_length) and the idle state
> >> selection happens in the menu governor. The enter callback is called
> >> with
> >> the selected state.
> >
> >   One would first execute prepare then call select and enter .
> >   So in the newer proposed code, there is no prepare routine. One would
> >   just execute select() and then enter() (Prepare functionality is part of
> > the
> >   enter routine itself) Is it not possible to cancel the timer,
> >   calculate the execute nohz_get_sleep in enter routine again,
> >   then select the idle state depending on the time . Automatically promote
> > or demote
> >   idle state based on the latest value returned in the driver ?
> >
> Cancelling the timer and calculating the sleep length again in the enter
> callback is possible; but what does not make sense is calling the select
> routine again ; definitely the select routine of the governor needs to be
> called only once.  And actually, the sleep length is calculated in the

Can you promote the idle state within the driver based on the new
information provided by tick_nohz_get_sleep_length() after canceling
the timer?  This will be a hack... but better than calling select()
again.  You are right, we need to design in such a way that select()
makes the right choice.

> function tick_nohz_stop_sched_tick.( so shld the prepare callback be moved
> before that in cpu_idle ??)

The prepare callback is in the right place now... if you cancel the
timer in prepare, then subsequent select() which calls
tick_nohz_get_sleep_length() will get the correct idle time.  Your
problem is in restarting the timer in case we abort the idle.  The
current place of prepare is fine and more over we are heading in the
direction to deprecate the prepare itself.

> I am looking for a nice way to cancel and restart the high resolution
> timers in the idle code; even if that means rearranging the cpu_idle code.

Slight difference, you can cancel and restart within the driver, the
problem is that you want the ->select() to be executed _after_
canceling your hrtimer because it will predict idle much shorter
otherwise.  This is where the cpuidle framework should help.

> Another way i was looking to solve this issue was add deferrable feature
> to HR timers; if someone has thoughts on that please chime in.

This seems to be a much better idea, where the
tick_nohz_get_sleep_length() can automatically skip your deferred
hrtimer with a hope that it will be canceled.  We don't have
a mechanism to actually defer it.

You can try to add deferred flag in hrtimer_mode { } similar to how
pinned was added.  Enhance tick_nohz_get_sleep_length() to skip over
deferred hrtimer as well.

But the number of users for this feature will be very little to
justify the complexity.

--Vaidy
