From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] perf: add calls to suspend trace point
Date: Tue, 4 Jan 2011 12:29:20 +0100
Message-ID: <20110104112919.GB9879__47969.6469534703$1294140644$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
	<1294138109-24679-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1294138109-24679-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: Len Brown <len.brown@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> Uses the machine_suspend trace point, called from the
> generic kernel suspend_enter function.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> CC: Thomas Renninger <trenn@suse.de>
> ---
>  kernel/power/suspend.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index ecf7705..0650596 100644
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
> +			trace_machine_suspend(PWR_EVENT_EXIT);
>  			events_check_enabled = false;
>  		}
>  		sysdev_resume();

Ok... why this place? I mean, perhaps suspend time should include
device suspend?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
