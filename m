From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 11:16:35 +0200
Message-ID: <201010271116.35546.rjw__30064.0675043271$1288171193$gmane$org@sisk.pl>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<201010262057.02218.rjw@sisk.pl> <201010270200.57748.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010270200.57748.trenn@suse.de>
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
Cc: Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 27, 2010, Thomas Renninger wrote:
> On Tuesday 26 October 2010 08:57:01 pm Rafael J. Wysocki wrote:
> > On Tuesday, October 26, 2010, Thomas Renninger wrote:
> > > > 
> > > > Ok, that's at least generic. Needs the review of Rafael, to determine
> > > > whether this state value is all we want to know when we enter suspend.
> > > He already gave an acked-by on this generic one here:
> > > Re: [PATCH 3/4] perf: add calls to suspend trace point
> > > Oh now, that was on the X86 specific part which depends on this one.
> > > One should expect that he's fine with the generic part as well then,
> > > but I agree that he should definitely have a look at this and sign it off.
> > 
> > What patch exactly do you mean?  I'm not quite sure from your comment above.
> 
> Eh, Jean's patch, sorry about that.
> Needs a tiny change to use PWR_EVENT_EXIT instead of 0 with
> my new patch series:

No problem with that as far as I'm concerned.

Thanks,
Rafael


> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> CC: Thomas Renninger <trenn@suse.de>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ---
>  kernel/power/suspend.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 7335952..10cad5c 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> +#include <trace/events/power.h>
>  
>  #include "power.h"
>  
> @@ -164,7 +165,9 @@ static int suspend_enter(suspend_state_t state)
>         error = sysdev_suspend(PMSG_SUSPEND);
>         if (!error) {
>                 if (!suspend_test(TEST_CORE) && pm_check_wakeup_events()) {
> +                       trace_machine_suspend(state);
>                         error = suspend_ops->enter(state);
> +                       trace_machine_suspend(0);
>                         events_check_enabled = false;
>                 }
>                 sysdev_resume();
> 
> 
