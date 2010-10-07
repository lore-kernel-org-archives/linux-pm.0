From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 11:08:25 -0400
Message-ID: <20101007150825.GB12581__34283.1966969699$1286465321$gmane$org@Krystal>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201010062334.46971.trenn@suse.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

[ Adding a few more CCs, since this discussion is about a tracepoint
  userspace ABI policy, which is a topic of general interest. ]

* Thomas Renninger (trenn@suse.de) wrote:
> Hi,
> 
> On Monday 04 October 2010 17:20:57 Jean Pihet wrote:
> > Here is a re-spin of the patches after discussion.
> 
> what is going to happen here now?
> 
> Is this supposed to go through Ingo's tree?
> 
> Ingo: do you mind commenting on this.

Meanwhile, here are some ideas...


> I see 3 possibilities:
>   1) Power (or all) perf events are never going to change.

Persisting with bad interfaces (which were never meant to be stable, and were
actually explicitely said to be non-stable) for the sake of poorly written
proprietary userspace apps does not seem like viable to me. Since when did we
start designing kernel code for broken proprierary apps ? (see below for
solutions on how to fix the apps)

The only reason we have these tracepoints in there is because they can follow
kernel code changes, thanks to their flexible nature. Being stucked with
badly named tracepoints because of some monolithic analyzer app is just insane.

>   If they are going to change, then now is the right time and
>   2) Backward compatibility is provided in some way for some time.

I've looked at the resulting code, and, honestly, it's ugly and it complexifies
the test matrix. I would really prefer to move this compatibility crap out of
the kernel out into userspace libraries, where it belongs. It should have got
there in the first place when the developers of these propritary
tracepoint-consumers got the hint that those were going to change. Then you have
a sane design:

1) The kernel, providing a tracepoint ABI that *can change over time*, because
   tracepoints are too tied to kernel code to afford not being changed.
2) Adapdation libraries, some which could be provided with the perf userspace
   libraries, some which could be provided along with the tracepoint consumer
   application, so the proprietary application can link on an open-source
   library that can be upgraded when needed.
3) The trace analyzer. So if the analyzer is open source, then it's fine, it
   could follow the rare ABI breakups that are needed by a simple upgrade.
   Ideally we might want to keep backward compatibility code in there too, but
   it's OK to require users to upgrade their tools if the kernel is upgraded.
   If the analyzer is closed-source, then it should interact with an open source
   library rather than with the kernel tracepoints ABI.

So, given that I don't want to uglify kernel code based on some badly written
proprietary userspace tools, and given we've given all possible warnings telling
that the tracepoint ABI might change, I really don't see why we should bother
bloating the kernel with this. The analyzers should be changed to use adaptation
libraries instead.

>   3) The power events get cleaned up without compatibility to
>      former kernels versions.
> 
> There are patches for 2. and 3., for 1. there obviously are no
> needed.
> For 2., the patches (mine or Jeans), need some polishing. IMO
> these double events inside of general code aren't that bad.
> I trust Jean, that it's not that easy with all the include magic
> and macros, partly realized that myself already and it's not worth
> it to dig further for a temporary solution.
> 
> Votes so far:
> 1. Arjan
> 2. Myself, Jean
> 3. Peter Zijlstra and Mathieu Desnoyers
> 
> Jean's work got successfully blocked for weeks now.
> If there would be a final decision by a maintainer who is going to
> merge Jean's work, that would be great and it would finally be worth
> to send updated patches again which hopefully some day find their way into
> a linux-next kernel...

Yes, sadly this debate running in circles hurts contributors.

Thanks for the summary!

Mathieu

> 
> Thanks,
> 
>       Thomas

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
