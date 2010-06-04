From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Fri, 04 Jun 2010 11:43:39 +0200
Message-ID: <1275644619.27810.39462.camel__16171.3549671278$1275644776$gmane$org@twins>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603232302.GA16184@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-04 at 01:23 +0200, Ingo Molnar wrote:
> Btw., i'd like to summarize the scheduler based suspend scheme proposed by
> Thomas Gleixner, Peter Zijlstra and myself. I found no good summary of it in
> the big thread, and there are also new elements of the proposal:

Just to clarify, my proposition doesn't go much further than treating
'suspend' as a genuine idle state (on suitable hardware, which x86 isn't).

> - Create a 'deep idle' mode that suspends. This, if all constraints
>    are met, is triggered by the scheduler automatically: just like the other
>    idle modes are triggered currently. This approach fixes the wakeup
>    races because an incoming wakeup event will set need_resched() and
>    abort the suspend.
>

Right, so 'suspend' as idle seems (at least on UP/arm) a very sensible
idea.  On SMP current suspend hot-unplugs all but the boot cpu, I'm not
sure we need to do that, since if the system is genuinely idle, what races
are there?

And if its not idle...

>   ( This mode can even use the existing suspend code to bring stuff down,
>      therefore it also solves the pending timer problem and works even on
>      PC style x86. )

You cannot solve the pending timer issue from idle, unless you allow idle
to stop clock_monotonic, which would change idle semantics, and that is not
something I can say is a good idea.

You want all idle states to have the same semantics, otherwise things just
get way too confusing.

> - Solve crappy app confinement via the scheduler:
>
>    A first proposal was to use the existing cgroup mechanism,

I still believe containment is a cgroup problem. The freeze/snapshot/resume
container folks seem to face many of the same problems. Including the
pending timer one I suspect. Lets solve it there.

>  - Controlled auto-suspend: drivers (such as input) could on wakeup
>    automatically set the 'minimum wakeup latency' value of wakee tasks to a
>    lower value. This automatically prevents another auto-suspend in the near
>    future: up to the point the wakee task increases its latency (via the
>    scheduler syscall) again and allows suspend again.

I think treating wakeups special like that is a mistake. I also think the
kernel should never adjust a task's QoS attributes, the user set them in
the expectation of them being respected.

I'm not really sure about the interaction between wakeups and untrusted
apps. It seems to me that an untrusted app needs a trusted intermediate
anyway, that intermediate can be responsible for freezing/unfreezing of the
untrusted app.

So either the app asks for suspend blockers through the intermediate, or it's
cgroup is managed by the intermediate -- should work out to the same end
result, right?
