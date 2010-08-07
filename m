From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 7 Aug 2010 11:01:24 +0200
Message-ID: <201008071101.25384.rjw__6979.76892483911$1281183253$gmane$org@sisk.pl>
References: <20100805230304.GQ2447@linux.vnet.ibm.com>
	<20100807001431.GA3252@opensource.wolfsonmicro.com>
	<alpine.DEB.2.00.1008061741460.30564@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008061741460.30564@asgard.lang.hm>
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
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, August 07, 2010, david@lang.hm wrote:
> On Sat, 7 Aug 2010, Mark Brown wrote:
> 
> > On Fri, Aug 06, 2010 at 04:35:59PM -0700, david@lang.hm wrote:
> >> On Fri, 6 Aug 2010, Paul E. McKenney wrote:
... 
> What we want to have happen in an ideal world is
> 
> when the storage isn't needed (between reads) the storage should shutdown 
> to as low a power state as possible.
> 
> when the CPU isn't needed (between decoding bursts) the CPU and as much of 
> the system as possible (potentially including some banks of RAM) should 
> shutdown to as low a power state as possible.

Unfortunately, the criteria for "not being needed" are not really
straightforward and one of the wakelocks' roles is to work around this issue.

> today there are two ways of this happening, via the idle approach (on 
> everything except Android), or via suspend (on Android)
> 
> Given that many platforms cannot go to into suspend while still playing 
> audio, the idle approach is not going to be able to be eliminated (and in 
> fact will be the most common approach to be used/deugged in terms of the 
> types of platforms), it seems to me that there may be a significant amount 
> of value in seeing if there is a way to change Android to use this 
> approach as well instead of having two different systems competing to do 
> the same job.

There is a fundamental obstacle to that, though.  Namely, the Android
developers say that the idle-based approach doesn't lead to sufficient energy
savings due to periodic timers and "polling applications".  Technically that
boils down to the interrupt sources that remain active in the idle-based case
and that are shut down during suspend.  If you found a way to deactivate all of
them from the idle context in a non-racy fashion, that would probably satisfy
the Android's needs too.

Thanks,
Rafael
