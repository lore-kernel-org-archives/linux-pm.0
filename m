From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Sat, 17 Apr 2010 09:40:05 -0700
Message-ID: <20100417094005.449443be__23337.4926647686$1271522428$gmane$org@infradead.org>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman <sqazi@google.com>
Cc: ranjitm@google.com, peterz@infradead.org, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Apr 2010 17:08:18 -0700
Salman <sqazi@google.com> wrote:

> As we discussed earlier this year, Google has an implementation that
> it would like to share.  I have finally gotten around to porting it to
> v2.6.33 and cleaning up the interfaces.  It is provided in the
> following messages for your review.  I realize that when we first
> discussed this idea, a lot of ideas were presented for enhancing it.
> Thanks alot for your suggestions.  I haven't gotten around to
> implementing any of them.

again I'll chime in to support this effort; it's the right thing to do
for power limiting (as opposed to taking cores offline), and I'm happy
to see progress being made.

I'll start playing with your patches and use timechart to see how well
it works, including to see how well things align... 

> The ones that I still find appealing are:
> 
> 0. Providing approximate synchronization between cores, regardless
> of their independant settings in order to improve power savings.   We
> have to balance this with eager injection (i.e. avoiding injection
> when an interactive task needs to run).

I still would like to see this ;-)
It's a *HUGE* instant power delta.

But it does not have to be perfect. As long as "on average" we align
we're good enough.

the easiest way is to round the time of the start of idle injection
up to, say, double the duration of the injection period...
and maybe to whole seconds or some round value of jiffies as well.

It could even be done by "creeping" towards an aligned situation...
rather than forcing instant alignment, as long as each time we inject
idle time we get a step closer to being aligned.. very soon we WILL be
aligned.
(for example, if a cpu notices it's on the late side of an alignment
window, it could inject a little shorter than usual, while if it
notices it's a little early, it can inject a little longer)
 
> A stricter synchronization between cores is needed to make idle cycle
> injector work on hyperthreaded systems.  This is a some what separate
> issue, as there should only be one idle cycle injector minimum idle
> setting per physical core.

actually... while the HT case is clearly required to be solved to get
actual power limits, ideally we can solve it using the same tricks we
use for the above, just with a stronger bias...

I don't think we need to force the admin to set the same value per se,
it's something that's just a matter of having the policy guy do this
right... (but if you want to do "effective injection %age is minimum of
the two" or so, I can live with that)




> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
