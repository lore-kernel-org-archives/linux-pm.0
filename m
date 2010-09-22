From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 20:30:33 +0200
Message-ID: <1285180233.2275.1038.camel__21265.6071213589$1285180344$gmane$org@laptop>
References: <20100917162412.GB3341@elte.hu> <201009180026.59482.trenn@suse.de>
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	<4C9A21AD.1000800@linux.intel.com>
	<AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
	<4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
	<4C9A37AE.2010509@linux.intel.com> <1285176629.2275.1033.camel@laptop>
	<1285179355.26872.27.camel@gandalf.stny.rr.com>
	<20100922182356.GB9058@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100922182356.GB9058@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-09-22 at 20:23 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > We could add a TRACE_EVENT_ABI() as Ingo has been suggesting. [...]
> 
> That would be rather useful.
> 
> We could still be flexible about experimental tracepoints (they dont 
> hurt), but apps should stick to ABI bits - or at least not complain when 
> non-ABI tracepoints change for good reasons. (arbitrary, avoidable 
> changes are still bad obviously, regardless of the type of the 
> tracepoint)
> 
> We'd be more stringent with marking tracepoints an ABI.
> 
> So yes, this would be lovely to have.

Why? As long as we mandate that apps need to fully parse the format
stuff anyway, it doesn't buy us much.
