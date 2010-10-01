From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 1 Oct 2010 18:47:39 +0200
Message-ID: <20101001164736.GE5338__11862.9921730191$1285951803$gmane$org@nowhere>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<4CA60385.6040405@linux.intel.com> <20101001155823.GD5338@nowhere>
	<201010011829.53523.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201010011829.53523.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 01, 2010 at 06:29:53PM +0200, Thomas Renninger wrote:
> On Friday 01 October 2010 17:58:25 Frederic Weisbecker wrote:
> > On Fri, Oct 01, 2010 at 08:51:33AM -0700, Arjan van de Ven wrote:
> > >
> > > As before, strong NACK from me before, this is an ABI break.
> Please suggest another way to get this cleaned up then.


I know you're going to beat me, but the older solution
that brought the new tracepoint and kept the old ones looked
better to me (although definetly ugly).


 
> > Yeah. I wish we can keep power_start and power_end events,
> > at least for some time.
> Try to document these events and their attributes.
> You will then see that the whole interfaces absolutely make
> no sense and you can't even put their meaning into words.


May be, I'm not a power expert, but they seemed to make enough
sense to make perf timechart working.



> > I know this is very ugly, but this is the only solution if
> > we want to conciliate forward progress and backward
> > compatibility.
> So you vote for the double event solution in kernel I posted
> previously?


Yep.

 
> I'd like to have a decision how this will get cleaned up!


I know. Trace event are not supposed to be ABI, but once a
tool gets broken, the reality catches up.

Since Arjan nacks your last solution, we need to find
something.

So my personal opinion is: we should keep both tracepoints
versions and schedule the older for obsolescence in several
releases. Now I'm not going to nack either of the
appproaches, the end result will be bad either ways :)



> As ARM is going to make use of this stuff, there may show up
> some more tools and they should not make use of an insane interface.


OTOH, you don't need to provide the insane tracepoints on archs
that did not have them before, because there is nothing to break
there.


 
> So can someone who is going to merge this then, telling me how
> the cleanup will be done.
> 
> I'd prefer this approach over the one I posted before which allows
> compatibility with old userspace apps.


How this new version is backward compatible?
