From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 15:14:40 -0400
Message-ID: <20100922191440.GE2727__23250.0028716915$1285273370$gmane$org@redhat.com>
References: <201009180026.59482.trenn@suse.de>
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	<4C9A21AD.1000800@linux.intel.com>
	<AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
	<4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
	<4C9A37AE.2010509@linux.intel.com>
	<1285176629.2275.1033.camel@laptop>
	<1285179355.26872.27.camel@gandalf.stny.rr.com>
	<1285180000.2275.1036.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285180000.2275.1036.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi -

On Wed, Sep 22, 2010 at 08:26:40PM +0200, Peter Zijlstra wrote:
> [...]
> > Not sure what you mean by "double tracepoints"
> Two different tracepoints in the same location.

Another possibility may be to provide a backward-compatibility module
that maps new tracepoints to old ones.  On demand, it could attach to
the new tracepoints, and export those callbacks as clones of the old
pseudo-ABI: same old names & parameters.  If the new ones supply a
superset of events & data, this is technically possible.

- FChE
