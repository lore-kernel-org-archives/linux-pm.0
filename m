From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 10:09:04 -0700
Message-ID: <20100806170904.GG2432__14038.1430196159$1281114674$gmane$org@linux.vnet.ibm.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<201008051734.06736.rjw@sisk.pl>
	<AANLkTi=kDx440MrLnQEcT46b3gkahU5ZGc0oWrWF-D2g@mail.gmail.com>
	<201008060141.46109.rjw@sisk.pl>
	<AANLkTin245wZsxeUh2HuONHqDNXFWpyzPsYv4PPuZYSb@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin245wZsxeUh2HuONHqDNXFWpyzPsYv4PPuZYSb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 05:29:24PM -0700, Brian Swetland wrote:
> 2010/8/5 Rafael J. Wysocki <rjw@sisk.pl>:
> >>
> >> Our wakelock stats currently have
> >> (name,)count,expire_count,wake_count,active_since,total_time,sleep_time,max_time
> >> and last_change. Not all of these are equally important (total_time is
> >> most important followed by active_since), but you only have count.
> >> Also as discussed before, many wakelocks/suspendblockers are not
> >> associated with a struct device.
> >
> > OK
> >
> > How much of that is used in practice and what for exactly?
> >
> > Do you _really_ have to debug the wakelocks in drivers that much?
> 
> Debugging power related issues is pretty critical to building
> competitive mobile devices.
> 
> Throughout the several months of this discussion I have been
> continually scratching my head at this "debugability considered
> harmful" attitude that I see in reaction to our interest in having the
> ability (gated behind a config option even -- really, that'd be fine,
> not everyone need enable it) to gather useful stats and examine the
> state of the system.

In my case, it has not been "debuggability considered harmful", but
rather my lack of understanding of the kinds of bugs that can arise and
what information is most helpful in tracking them down.  Arve's post
listing the meanings of the stats helped me quite a bit, although I am
sure that my understanding is still quite rudimentary.

> At this point it sounds like there's no interest in the solution we
> have, which works and has worked for a few years, and has been revised
> 10+ times based on feedback here, and no interest in providing a
> solution that accomplishes similar functionality, so perhaps it's time
> for us to cut our losses and just go back to maintaining our patches
> instead of having the same arguments over and over again.

And this brings up another aspect of Android requirements.  Mainlining
Android features is not necessarily an all-or-nothing proposition.  Here
is a prototype list of degrees of mainlining, along with at least a few
of the benefits and difficulties of each level:

o	Mainline that provides exactly what Android needs.

	This is of course the best case, but, as you may have noticed,
	might not be easy to achieve.  The plain fact is that Linux
	must support a wide variety of workloads, so some give-and-take
	is usually required.

o	Mainline that exactly matches the ideal API, but which fails
	to implement some feature or another.

	This is still not bad.  You have to carry a specific patch to
	provide the feature(s), but all the calling sites are carried
	upstream in mainline.

o	Mainline provides something that is close to the ideal API, but
	some additional constant arguments are required.

	This is not so good, but at least the drivers can be upstreamed
	and the changes required to get to an Android-ready kernel
	are fairly simple.

o	Mainline provides something, but Android requires changes to the
	supplied API which require additional data to be passed from
	call site to call site.

	Again, at least drivers can be upstreamed, but the changes required
	to get to an Android-ready kernel are a bit more involved.

o	Mainline provides a stubbed-out API.

	Once again, the drivers can at least be upstreamed, but Android
	is the only project validating the placement of calls to the
	API.   This means that changes to the drivers are likely to
	mess up the placement of the call sites.  Therefore, getting
	to an Android-ready kernel requires careful inspection of the
	drivers to adjust for bugs introduced by others.

o	Mainline provides nothing.

	Status quo.  This means that some other group will likely
	introduce the required functionality in an incremental fashion.
	This process will likely fail to take Android's needs into
	account, probably leading to...

o	Mainline provides functionality that is similar to what
	Android needs, but in a completely incompatible manner
	that cannot be used easily (or perhaps at all) by Android.

My guess is that there is value to Android in a number of the non-perfect
cases.

							Thanx, Paul
