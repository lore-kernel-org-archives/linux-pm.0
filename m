From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 20:23:56 +0200
Message-ID: <20100922182356.GB9058__38828.3080225394$1285180046$gmane$org@elte.hu>
References: <20100917162412.GB3341@elte.hu> <201009180026.59482.trenn@suse.de>
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	<4C9A21AD.1000800@linux.intel.com>
	<AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
	<4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
	<4C9A37AE.2010509@linux.intel.com>
	<1285176629.2275.1033.camel@laptop>
	<1285179355.26872.27.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285179355.26872.27.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> We could add a TRACE_EVENT_ABI() as Ingo has been suggesting. [...]

That would be rather useful.

We could still be flexible about experimental tracepoints (they dont 
hurt), but apps should stick to ABI bits - or at least not complain when 
non-ABI tracepoints change for good reasons. (arbitrary, avoidable 
changes are still bad obviously, regardless of the type of the 
tracepoint)

We'd be more stringent with marking tracepoints an ABI.

So yes, this would be lovely to have.

	Ingo
