From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 07:22:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008050717260.25170__23991.618367336$1281018471$gmane$org@asgard.lang.hm>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<201008050220.51805.rjw@sisk.pl>
	<AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
	<20100805134057.GB20565@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805134057.GB20565@srcf.ucam.org>
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

On Thu, 5 Aug 2010, Matthew Garrett wrote:

> On Wed, Aug 04, 2010 at 06:02:28PM -0700, Arve Hj?nnev?g wrote:
>
>> Which makes the driver and/or network stack changes identical to using
>> wakelocks, right?
>
> I think we're resigned to the fact that we need to indicate wakeup
> events in a manner that's pretty equivalent to wakelocks. The only real
> issue is what the API looks like. Anyone who's still talking about
> cgroups seems to be trying to solve a different problem.

Ok, it is now sounding to me like there are two different (but somewhat 
related) purposes that wakelocks are being used for

1. deciding if the system should go to sleep now or not (what most of the 
discussion has been about)

2. narrowing the race between going to sleep and wakeup events.

I'm not sure it's possible to completely eliminate the race, even with 
wakelocks there is some time between the time you last check if the 
wakelock is set and when the hardware finishes responding to your commands 
to go to sleep (Unless you can set a level-based interrupt that will wake 
you up as soon as you finish going to sleep)

David Lang
