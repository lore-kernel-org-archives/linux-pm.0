From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 09:04:19 -0700
Message-ID: <4CC6FC03.708__45374.4010338143$1288109237$gmane$org@linux.intel.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>	<1288049630-10947-1-git-send-email-trenn@suse.de>	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On 10/26/2010 8:32 AM, Pierre Tardy wrote:
> On Tue, Oct 26, 2010 at 2:10 AM, Ingo Molnar<mingo@elte.hu>  wrote:
>
>> How will future PCI (or other device) power saving tracepoints be called?
>>
>> Might be more consistent to use:
>>
>>   power:cpu_idle
>>   power:machine_idle
>>   power:device_idle
> Agree with this.
>
> FYI, I have a runtime_pm tracepoint currently cooking. Here is
> preliminary patch.
> Can this be a candidate for a "power:device_idle" tracepoint?


I would like to see a slightly more advanced tracepoint do the runtime 
pm framework;
specifically I'd like to see the "comm" of the process that's taking a 
refcount on a device
(that way, powertop can track which process keeps a device busy)
