From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 18:10:59 +0200
Message-ID: <AANLkTik1FULW6Fm7Dwgb+xW5GSDzgSdF_a8z86_-SRNd__2828.82742253623$1286468037$gmane$org@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101007155816.GA5351@nowhere>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

> I did told you that it would be better you make PyTimeChart use the perf
> scripting facilities, it handles all the above things + it would
> avoid you to handle a lot of things.

Actually, perf scripting  facility is already supported by pytimechart
but does not make it that easier to maintain.
event name changes => must update, event fields added/removed => must update

>
> Now it's up to you, but don't count on us to make the ascii formatting
> a stable ABI.
I'm not against adding 1 line in pytimechart each time there is some
change in ascii formatting

>
>
>> actually, over all the events pytimechart supports, only power traces
>> are stable...
>
>
> Now one problem is that we have really broken the workqueue tracepoints
> in this release. I thought nobody was using them so we could
> refactor this tracepoint subsystem, my bad.
No problem. I'll update pytimechart whenever someone sends me traces
that does not work (I'm okay with pre 2.6.31 traces too...)


Regards,
Pierre
