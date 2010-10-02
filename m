From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Sat, 2 Oct 2010 02:33:44 +0200
Message-ID: <201010020233.45926.trenn__47380.4549001672$1285979704$gmane$org@suse.de>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<201010011829.53523.trenn@suse.de> <20101001164736.GE5338@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101001164736.GE5338@nowhere>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Friday 01 October 2010 06:47:39 pm Frederic Weisbecker wrote:
> On Fri, Oct 01, 2010 at 06:29:53PM +0200, Thomas Renninger wrote:
> > On Friday 01 October 2010 17:58:25 Frederic Weisbecker wrote:
> >
> > Please suggest another way to get this cleaned up then.
>
> I know you're going to beat me, but the older solution
> that brought the new tracepoint and kept the old ones looked
> better to me (although definetly ugly). 
Not really ugly, the compatibility stuff can vanish after a deprecation time.
If it is considered as a stable interface, there is not much that can be done 
if something needs modification.
Either the one or the other event subset is used and as tracepoints should 
have zero/low overhead if disabled, it shouldn't be that bad to carry double
events for some time.

> > > Yeah. I wish we can keep power_start and power_end events,
> > > at least for some time.
> >
> > Try to document these events and their attributes.
> > You will then see that the whole interfaces absolutely make
> > no sense and you can't even put their meaning into words.
>
> May be, I'm not a power expert, but they seemed to make enough
> sense to make perf timechart working.
These are three events, with 1-3 attributes.
Try to describe each with a sentence or two. You will quickly realize that
that the _start/_end events do not make sense and the attributes as well.
You cannot even document this, I mean you can like: Just ignore the type
attribute, it does not make sense, it was never used and never will be.

Do you want to get this broken stuff get spread more and more?

> > I'd like to have a decision how this will get cleaned up!
>
> I know. Trace event are not supposed to be ABI, but once a
> tool gets broken, the reality catches up.
Not sure about how sever that would be.
Reality is:
The ordinary user would always have a matching kernel with
compatible packages in his distribution.

This is about debugging/monitoring tools, or say if these tools
are used for debugging/monitoring a newer kernel with uncompatible
packages, the guy installed, probably compiled on his own, an
unsupported test kernel on his system.

If he can do above, he should be capable of downloading the latest
adjusted userspace version and type a:
make; make install
and get this stuff compiled as well.

> So my personal opinion is: we should keep both tracepoints
> versions and schedule the older for obsolescence in several
> releases.
I do not have a personal opinion how this should get done.
My opinion is: This cleanup should be done asap, before the broken
interface is widely used.

> > As ARM is going to make use of this stuff, there may show up
> > some more tools and they should not make use of an insane interface.
>
> OTOH, you don't need to provide the insane tracepoints on archs
> that did not have them before, because there is nothing to break
> there.
Correct, they can already use the new interface.
That is my point why the change has to be done now.

Also Jean has put quite some time into this and it would be great if this
discussion comes to a conclusion, a decision is made and this worthful
work finally is picked up in the one way or the other.

> > So can someone who is going to merge this then, telling me how
> > the cleanup will be done.
> >
> > I'd prefer this approach over the one I posted before which allows
> > compatibility with old userspace apps.
>
> How this new version is backward compatible?
Why exactly do you need it?
In a distribition your packages will fit to the kernel.
If you get  a newer kernel, you also have to compile the tools to debug it.

       Thomas
