From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 15:20:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041508040.6545__47346.8700344258$1280960555$gmane$org@asgard.lang.hm>
References: <20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
	<20100804192115.GA2946@srcf.ucam.org>
	<alpine.DEB.2.00.1008041222280.6545@asgard.lang.hm>
	<20100804195723.GA3553@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804195723.GA3553@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010, Matthew Garrett wrote:

> On Wed, Aug 04, 2010 at 12:29:36PM -0700, david@lang.hm wrote:
>
>> why would you trust it to take a wakelock, but not trust it the rest of
>> the time?
>
> Because I trust that when the application author says "I explicitly need
> the machine to stay awake" that they mean it, whereas I don't trust the
> application author to write an application that avoids consuming
> background CPU. The distinction is pretty important.

on the other hand, making an application avoid consuming inappropriate 
background resources helps everywhere. an explicit "don't let the machine 
sleep" only works if you are trusted by a system that implements this 
flag.

yes, it is painful to make the change, but the end result is better (and 
there are more tools out there to figure things out)

>> in my proposal I'm saying that if you would trust the application to take
>> a wakelock, you instead trust it to be sane in the rest of it's power
>> activity (avoiding polling, etc) and so you consider it for sleep
>> decisions.
>
> When we say "trust", we're not using the same meaning as we do with
> security. Yes, it's possible that an application that can block suspend
> will do so at inopportune times. But given that blocking suspend is an
> explicit act it's much more likely that the developer will only use it
> in reasonable ways, while it's still entirely plausible that the
> application will generate unnecessary wakeups. Pretending otherwise is
> unrealistic. I recently had to fix the fact that the kernel IPMI layer
> would generate a constant 1000 wakeups a second even if it had an
> interrupt-driven controller or was entirely idle.

I'm not sure I buy the distinction, but I'm not a maintainer so it's 
others you have to convince.

it's better to have one type of problem with one set of tools that 
document  why the machine isn't sleeping, than to have orthoginal ways of 
influencing power management.

but if you have an application in the mid-level trust situation, go ahead 
and have it talk to a 'keepalive' daemon that is in the 'trusted' set and 
let the rest of the app run untrusted. As I noted elsewhere, the keepalive 
daemon would need very little in the way of resources and can implement 
much more complex policies than anyone is going to be willing to put in 
the kernel.

>>> The second is that the incoming network packet causes
>>> the kernel to take a wakelock that will be released once userspace has
>>> processed the network packet. This ensures that at least one wakelock is
>>> held for the entire relevant period of time.
>>
>> how do you determine that userspace has processed the network packet so
>> that the kernel can release the wakelock (or is this one of the cases
>> where there is a timer related to the wakelock)
>
> The current implementation uses a timer, but Rafael's implementation
> should allow userspace to explicitly acknowledge it.

similar to the current implementation, the arrival of a packet could be 
counted as activity that keeps the system awake for a bit (your timeout)

>> two things here,
>>
>> on the dirty networks that I see as common, refusing to sleep if network
>> packets are arriving will mean that you never go to sleep.
>
> Cell networks typically have no background traffic, for obvious reasons.

but don't most new smartphones also connect up to wifi networks? those are 
FAR from quiet.

>> secondly, nothing stops the code doing the idle/suspend decision from
>> considering network activity. I would be surprised if there weren't
>> already options to support this today.
>
> If you proxy every potential wakeup event through some central server
> then this becomes much easier, but it's also a performance hit. The
> alternative is that you poll for network activity, but that's a power
> hit.

I'm not suggesting running all events through some central server (unless 
you count the kernel as that server),  I'm saying that the decision that 
the system is idle and therefor can be stopped should be able to take this 
infomation into account, and if there's a race here, it should be a race 
that exists everywhere else, so there should be a general solution, not 
something specific to one use-case. (and definantly not something that 
requires all software to be modified and trusted to implement)

David Lang
