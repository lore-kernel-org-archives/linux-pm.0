From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:23:43 +0200
Message-ID: <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO__25391.3039494821$1286467021$gmane$org@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101007150825.GB12581@Krystal>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 7, 2010 at 5:08 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> [ Adding a few more CCs, since this discussion is about a tracepoint
> =A0userspace ABI policy, which is a topic of general interest. ]

To add a little more comment, this is not the first time that
tracepoints ABI changes. You can look at pytimechart sourcecode:
http://gitorious.org/pytimechart/pytimechart/blobs/master/timechart/ftrace.=
py

from 2.6.31 which is the first kernel I support,

sched_switch:  'task %s:%d [%d] =3D=3D> %s:%d [%d]',
changed to:
sched_switch:  'prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=3D%s
=3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d',

workqueue_execution: 'thread=3D%s
func=3D%s\\+%s/%s','thread','func','func_offset','func_size'),
changed to:
workqueue_execution: 'thread=3D%s func=3D%s','thread','func'),


actually, over all the events pytimechart supports, only power traces
are stable...

Regards,
-- =

Pierre
