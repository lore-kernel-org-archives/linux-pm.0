From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Sun, 24 Oct 2010 23:58:00 -0700
Message-ID: <4CC52A78.7060407__40708.7182546549$1287989948$gmane$org@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
	<1287488171-25303-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1287488171-25303-3-git-send-email-trenn@suse.de>
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
Cc: linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 10/19/2010 4:36 AM, Thomas Renninger wrote:
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
>    power:power_start
>    power:power_end
> are replaced with:
>    power:processor_idle
>
I think you need two trace points for this
one to enter idle
one to exit

because using magic encoding games to encode "exit"is a mistake; as can 
be seen in this patch.
You're currently trying to use "0" to signal "end of idle", but "0" is 
also a valid idle state (namely that of polling)
