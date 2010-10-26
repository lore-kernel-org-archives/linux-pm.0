From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 19:58:14 +0200
Message-ID: <1288115894.3673.12.camel__20729.1508712389$1288116120$gmane$org@laptop>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	<4CC6FC03.708@linux.intel.com>
	<AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org, Jean Pihet <jean.pihet@newoldbits.com>, Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven@smtp1.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> 
> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
>         atomic_inc(&dev->power.usage_count); 

That's terribly racy..
