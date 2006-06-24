From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:33:37 -0700
Message-ID: <200606232033.37911.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 4:44 pm, Linus Torvalds wrote:
> =

> We can't do that right now, but I think we can split up "->suspend()" the =

> other way: split the remains into two, similarly to how "save_state()" is =

> for "stuff that can be done without any side effects". We would have =

> "early suspend with interrupts enabled" and "late suspend with interrupts =

> disabled".

That would certainly get rid of the bizarre disjunction that now
exists for the "irqs enabled" and "irqs disabled" paths.  Though
it's unclear to me how many drivers would actually _use_ that
second "irqs off" method.

In terms of API migration, it would seem like the former should
just be today's suspend() -- though other changes might follow,
later on -- and the new method should be late_suspend() ... maybe
without that annoying pm_message_t/PM_EVENT_* parameter.


> This, btw, is something we can (and probably should) do on the resume sid=
e =

> too. Again, "early_resume()" would be done before interrupts are enabled =

> and other cores are brought up. And "late_resume()" would be done with =

> interrupts on.
> =

> (And I think Ben is right, we might want to have a "final_resume()" which =

> is called when user mode has resumed).

All those seem like plausible API changes, though it's not clear to me
what drivers would need them ... or the overall benefit.


> I really don't understand people who think that one routine is better tha=
n =

> five routines.

Complete and implementable proposals (not necessarily patches) seem to have
been lacking.  I've seen "refactor one into five" type changes that have be=
en
wins ... and ones that have been huge loses.

- Dave


> I pretty much _guarantee_ that most devices will still just  =

> have one or two routines, but they'll be simpler, just because they can b=
e =

> more directed rather than flailing around wildly and aimlessly because of =

> having just one interface that needs to make everybody happy.
> =

> Five simple routines are _superior_ to one complicated routine. That is =

> true even if the five simple routines end up having more lines of code.
> =

> 			Linus
> =
