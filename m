From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 07:11:10 -0700
Message-ID: <4CC58FFE.2050700__30439.5650433891$1288015923$gmane$org@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
	<201010251303.04019.trenn@suse.de> <20101025115525.GB2237@elte.hu>
	<201010251455.17421.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010251455.17421.trenn@suse.de>
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
Cc: linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-pm@vger.kernel.org

On 10/25/2010 5:55 AM, Thomas Renninger wrote:


>> But the actual code does not actually deal with any 'state 0', does it?
> It does. Not being idle is tracked by cpuidle driver as state 0
> (arch independent):
> /sys/devices/system/cpu/cpu0/cpuidle/state0/
> halt/C1 on X86 is:
> /sys/devices/system/cpu/cpu0/cpuidle/state1/
> ...
state0 is still OS idle!


the API is just weird for this, from a userspace perspective

if the kernel picks this state 0 for the idle handler, the userspace app 
gets
two events

one for going to state 0 to enter the idle state
one for going to state 0 to exit idle

but they're the exact same event in your API.

rather unpleasant from a userspace program perspective....
now I need to start tracking even more state on top in powertop to be 
able to make a guess at which of the two meanings a state 0 entry has.
