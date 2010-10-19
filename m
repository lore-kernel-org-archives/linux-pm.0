From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Tue, 19 Oct 2010 13:47:21 +0200
Message-ID: <1287488841.1994.5.camel__47263.0735989243$1287489009$gmane$org@twins>
References: <201010062334.46971.trenn@suse.de>
	<4CB095FA.8060803@linux.intel.com> <20101010121928.GA2688@elte.hu>
	<201010191331.03080.trenn@suse.de>  <20101019114501.GA25371@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101019114501.GA25371@elte.hu>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-10-19 at 13:45 +0200, Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
> > > Most definitely. It's no accident that it took such a long time for this issue 
> > > to be raised in the first place. It's a rare occurance -
> >
> > Do you agree that this occurance happened now and these events should get cleaned 
> > up before ARM and other archs make use of the broken interface?
> >
> > If not, discussing this further, is a big waste of time... and Jean would have to 
> > try to adapt his ARM code on the broken ABI...
> 
> The discussion seems to have died down somewhat. Please re-send to lkml the latest 
> patches you have to remind everyone of the latest state of things - the merge window 
> is getting near.
> 
> My only compatibility/ABI point is basically that it shouldnt break _existing_ 
> tracepoints (and users thereof). If your latest bits meet that then it ought to be a 
> good first step. You are free to (and encouraged to) introduce more complete sets of 
> events.

Can we deprecate and eventually remove the old ones, or will we be
forever obliged to carry the old ones too?
