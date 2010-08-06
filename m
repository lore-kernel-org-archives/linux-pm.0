From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 02:42:41 +0200
Message-ID: <201008060242.41595.rjw__15027.501495979$1281055555$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<201008060141.46109.rjw@sisk.pl>
	<AANLkTin245wZsxeUh2HuONHqDNXFWpyzPsYv4PPuZYSb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 06, 2010, Brian Swetland wrote:
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

Well, I don't think anyone will disagree with that.

> Throughout the several months of this discussion I have been
> continually scratching my head at this "debugability considered
> harmful" attitude that I see in reaction to our interest in having the
> ability (gated behind a config option even -- really, that'd be fine,
> not everyone need enable it) to gather useful stats and examine the
> state of the system.

The problem is what kind of stats would be actually sufficient and we haven't
seriously discussed that.  You said you'd need statistics and we took that for
granted, but we didn't really go into details here.

> At this point it sounds like there's no interest in the solution we
> have, which works and has worked for a few years, and has been revised
> 10+ times based on feedback here, and no interest in providing a
> solution that accomplishes similar functionality, so perhaps it's time
> for us to cut our losses and just go back to maintaining our patches
> instead of having the same arguments over and over again.

Please remember that I also have spent considerable amount of time trying to
push your solution upstream and defending it.  I might have spent that time
on other things instead, so please don't tell me about "losses".

If you want to stay in your ivory tower, that's perfectly fine by me, but
I guess that won't really benefit anyone in the long run.

Thanks,
Rafael
