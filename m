From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 13:18:10 +0200
Message-ID: <20100529131810.5bb51bdd__15102.9588575058$1275131946$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
	<1275032623.32462.30.camel@laptop> <201005290011.32543.rjw@sisk.pl>
	<20100529110426.077cba47@schatten.dmk.lab>
	<1275129757.27810.13205.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275129757.27810.13205.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas@smtp1.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 May 2010 12:42:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, 2010-05-29 at 11:04 +0200, Florian Mickler wrote:
> > On Sat, 29 May 2010 00:11:32 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > 
> > > Having reconsidered the suspend blockers idea I came to the conclusion that
> > > in fact it was a workaround for three different problems.
> > 
> > But it is also a change of paradigm. The scheduler should strive to
> > have the system idle as long as possible to conserve battery. And
> > everything that does not serve the purpose of the device has to be
> > considered as not worth running, except if there are other
> > purpose-fullfilling tasks to run anyway.
> 
> No the purpose of the scheduler is to run tasks when they are runnable.
> Not to second guess whatever caused them to become runnable.
> 
> If you start to randomly not run tasks, the inversion chaos that ensues
> is terrible. You can apply the regular means of alleviating that and
> that entails adding *-inheritance to all blockable resources. The -rt
> patch set is doing that in part.

Yes. In the scheduler it becomes a hard problem. But if
you have a clear definition of "purpose" (I mean, after all it is a
phone) and you can annotate this in a way that makes sense. (Suspend
blockers?) Then stopping the scheduler and suspend the device is at
least an easily understandable, maybe naive, approach.

> 
> You really need to make applications not want to run and block on their
> own volition (in a resource free point) and otherwise make them block on
> something forcefully and disregard any malfunctioning that would result
> from that, and in extreme cases terminate (releasing all resources).

I can see why this would be the best solution. But it would also be just
dodging the problem, wouldn't it?
 
> But really Android shouldn't even need kernel support to do all this,
> since its hosted on this massive middle-ware that intercepts everything,
> called a Java Virtual Machine.

Here also, dodging the problem. 

Maybe there is no good solution for this. And maybe it even is not a
generic problem. Suspend blockers block suspend. So that is what they
do. And they have a userspace API (which of course has to be
acceptable and not be borken). And they are optional. 

But having a way in the drivers to annotate some kind of constraints
seems to be a worthwile change in all cases. So this at least should go
in. 

And while there are differing opinions about the android approach
(feature vs misfeature) of suspending all the time, i think this is
addressed by having them configurable. 

Also the fear that userspace becomes infected with platform knowledge
is, in my eyes, only a secondary problem, because it is confined to
the android framework. The android framework guarantess applications
that they run as long as the user interacts with the device.
Applications have to deal with suspend in every case. So no special
knowledge needs to be there.

> Now, all I'm interested in is providing interfaces from the kernel where
> needed, so that userspace can be optimally frugal with power usage, and
> can monitor/contain badly behaving tasks.
> 

I think this is a sensible approach.

Cheers,
Flo
