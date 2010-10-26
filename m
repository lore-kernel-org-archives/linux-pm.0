From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 22:38:42 +0200
Message-ID: <201010262238.42536.rjw__21889.1646284193$1288125739$gmane$org@sisk.pl>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<201010262108.23537.rjw@sisk.pl>
	<AANLkTinJh-hOUs_YySvnXABYKt1_yO8bZUEJ5vDcYv0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinJh-hOUs_YySvnXABYKt1_yO8bZUEJ5vDcYv0K@mail.gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 26, 2010, Pierre Tardy wrote:
> On Tue, Oct 26, 2010 at 2:08 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, October 26, 2010, Pierre Tardy wrote:
> >> On Tue, Oct 26, 2010 at 12:58 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> >> >>
> >> >> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >> >>         atomic_inc(&dev->power.usage_count);
> >> >
> >> > That's terribly racy..
> >> >
> >> I know. I'm not proud of this.. As I said, this is preliminary patch.
> >> We dont really need to have this prev_usage. This is just for debug.
> >> It mayprobably endup with something like:
> >>
> >>          atomic_inc(&dev->power.usage_count);
> >> +       trace_power_device_usage(dev);
> >
> > Well, please tell me what you're trying to achieve.
> 
> Please see attached the kind of pytimechart output I'm trying to
> achieve (yes, this chart is not coherent, seems I'm still missing some
> traces)
> 
> We basically want to have a trace point eachtime the usage_counter
> changes, so that I can display nice timecharts, and Arjan can have the
> comm of the process that eventually generated the rpm_get, in order to
> pinpoint it in powertop.
> 
> What you dont see in the above two lines is that
> trace_power_device_usage(dev); actually reads the usage_count, as well
> as the driver and device name.

I'm afraid that for this to really work you'd need to put usage_count under a
spinlock along with your trace point, which I'm not really sure I like.

Besides, I'm not really sure the manipulations of usage_count are worth
tracing.

Thanks,
Rafael
