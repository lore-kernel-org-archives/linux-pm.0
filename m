From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 01 Oct 2010 18:08:35 -0400
Message-ID: <1285970915.6750.30.camel__39819.4810179577$1285971149$gmane$org@gandalf.stny.rr.com>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<1285945464-10884-2-git-send-email-trenn@suse.de>
	<4CA60385.6040405@linux.intel.com>
	<1285969466.6750.18.camel@gandalf.stny.rr.com>
	<4CA656F7.70703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA656F7.70703@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Frank@smtp1.linux-foundation.org, jean.pihet@newoldbits.com, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-10-01 at 14:47 -0700, Arjan van de Ven wrote:
> On 10/1/2010 2:44 PM, Steven Rostedt wrote:
> >
> > What ABI is broken? Trace points have not been declared an ABI. They
> > expose too much of the internals of the system to be considered one. Any
> > tool that can not cope with a tracepoint change is fundamentally broken.
> 
> what you are saying that any tool using tracepoints is fundamentally 
> broken...

I did not say that. I said a tool that can not cope with a change is.
There's a difference.

> 
> these tracepoints are used to get information for tools that do power 
> analysis (like powertop).
> while the absence of these named tracepoints does not cause a crash; 
> these tools have no longer
> any useful function left at that point.

What about adding a config file or script to the tool that can map
tracepoints, and how to read them based on the availability of a
tracepoint?

Once we start saying that a tracepoint is a fixed abi, we just stopped
innovation of the kernel. Tracepoints are too intrusive to guarantee
their stability. Tools that need to get information from a tracepoint
should either be bound to a given kernel, or have a easy way to update
the tool (config file or script) that can cope with a change.

When the user runs the tool, it would examine what tracepoints are
available and if it does not find anything it could use, it could output
to the user, a message like "Can not find necessary tracepoints. Either
the running kernel does not have them configured, or you need to update
your config file. Please check for new updates at <your url here>".

Tracepoints took a long time to get into the kernel namely because
people were worried that we were exposing events that could never
change. When we proposed these events, it was always presented as "these
may change without notice. Cope with it".

-- Steve
