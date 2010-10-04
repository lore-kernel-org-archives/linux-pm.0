From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] perf: add calls to suspend trace point
Date: Tue, 5 Oct 2010 00:52:36 +0200
Message-ID: <201010050052.36344.rjw__44934.9726005041$1286232932$gmane$org@sisk.pl>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<1286205661-24448-4-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1286205661-24448-4-git-send-email-jean.pihet@newoldbits.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Jean Pihet <j-pihet@ti.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Monday, October 04, 2010, Jean Pihet wrote:
> Uses the machine_suspend trace point, from the
> generic kernel suspend_enter function.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> CC: Thomas Renninger <trenn@suse.de>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

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
>  	error = sysdev_suspend(PMSG_SUSPEND);
>  	if (!error) {
>  		if (!suspend_test(TEST_CORE) && pm_check_wakeup_events()) {
> +			trace_machine_suspend(state);
>  			error = suspend_ops->enter(state);
> +			trace_machine_suspend(0);
>  			events_check_enabled = false;
>  		}
>  		sysdev_resume();
> 
