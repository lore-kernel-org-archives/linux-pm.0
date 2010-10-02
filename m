From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Sat, 2 Oct 2010 12:50:07 -0400
Message-ID: <20101002165006.GA22389__48909.9903185435$1286216402$gmane$org@Krystal>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<1285969466.6750.18.camel@gandalf.stny.rr.com>
	<4CA656F7.70703@linux.intel.com> <201010020243.09928.trenn@suse.de>
	<4CA704D2.3040505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CA704D2.3040505@linux.intel.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

* Arjan van de Ven (arjan@linux.intel.com) wrote:
>  On 10/1/2010 5:43 PM, Thomas Renninger wrote:
>> On Friday 01 October 2010 11:47:35 pm Arjan van de Ven wrote:
>>>    On 10/1/2010 2:44 PM, Steven Rostedt wrote:
>> ...
>>> these tracepoints are used to get information for tools that do power
>>> analysis (like powertop).
>> I just had a look at the very latest git code of powertop:
>> git://git.moblin.org/powertop
>> File system tracepoints are used, but the affected power events seem *not* to
>> be used yet.
>> Looks like the right time to get this cleaned up.
>
> you're looking at the old powertop.
>
>> If you know of any other code making use of these, please point me to the
>> code, I'd like to analyze whether this would be as easy to adjust as the
>> perf timechart code was.
>
> I think you are making the fundamentally incorrect assumption that all  
> users of these are open source.
> Sorry, not the whole world is open source.

I think that looking at the current open source users is a reasonably thorough
effort. Closed source software should be able to adapt, and at the very least be
able to print a warning if it does not find the tracepoints it is looking for.

The fact that this interface should not be expected to be cast in stone has been
heavily publicized since its creation. It simply exposes too much information
about the kernel internals to stay fixed. The userspace tools unable to cope
with that should therefore be considered as broken and fixed.

About the tracepoint stable "ABI", I'd be very cautious about providing this
kind of guarantee too soon, e.g. before time have shown that the names and
fields chosen were actually right. This power event cleanup is actually a very
good example of a case where some more thought was needed before these
tracepoints can be made a "stable ABI". If we choose to start providing this
kind of stability guarantee for some tracepoints at some point, I propose that
we deal with changes to these tracepoints with a "deprecation" process, which
would leave both the old and new ABIs for 1-2 kernel versions and print a
warning when a program is using the old ABI. But I would not bother adding
overhead to the current tracepoint cleanup by giving ABI stability guarantees
that we clearly and repeatedly stated did not exist.

Thank you,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
