From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 07:29:51 -0700
Message-ID: <AANLkTik2VJewvER0WPwb5vKELq+S8_xqPsAiidc1aRCD__31759.2624378905$1281020268$gmane$org@mail.gmail.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<201008050220.51805.rjw@sisk.pl>
	<AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
	<20100805134057.GB20565@srcf.ucam.org>
	<alpine.DEB.2.00.1008050717260.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008050717260.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 7:22 AM,  <david@lang.hm> wrote:
>
> Ok, it is now sounding to me like there are two different (but somewhat
> related) purposes that wakelocks are being used for
>
> 1. deciding if the system should go to sleep now or not (what most of the
> discussion has been about)
>
> 2. narrowing the race between going to sleep and wakeup events.
>
> I'm not sure it's possible to completely eliminate the race, even with
> wakelocks there is some time between the time you last check if the wakelock
> is set and when the hardware finishes responding to your commands to go to
> sleep (Unless you can set a level-based interrupt that will wake you up as
> soon as you finish going to sleep)

The transition into sleep is race-free in the wakelock model -- either
the wakeup event happens during the kernel suspend (and grabs a
wakelock), in which case suspend is aborted (and not attempted again
until there are once again no more wakelocks held), or the system
fully suspends to its lowest power mode until a wakeup event brings it
back out again.  Entry to lowest power mode must abort if a wakeup
event/interrupt occurs while it's in process -- exactly how the
handoff happens here is hardware dependent but in practice this is
doable on just about any modern system.

Brian
