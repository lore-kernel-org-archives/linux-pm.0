From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 1/5] PM/Freezer: Disable OOM
	killer	whentasks are frozen
Date: Wed, 6 May 2009 17:36:03 -0700
Message-ID: <20090507003603.GD17680__45401.8730357804$1241658123$gmane$org@us.ibm.com>
References: <200905070040.08561.rjw@sisk.pl> <200905070041.04787.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905070041.04787.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 07, 2009 at 12:41:04AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The OOM killer is not really going to work while tasks are frozen, so
> we can just give up calling it in that case.
> 
> This will allow us to safely use memory allocations for decreasing
> the number of saveable pages in the hibernation core code instead of
> using any artificial memory shriking mechanisms for this purpose.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>


> ---
>  include/linux/freezer.h |    2 ++
>  kernel/power/process.c  |   12 ++++++++++++
>  mm/page_alloc.c         |    5 +++++
>  3 files changed, 19 insertions(+)
> 
> Index: linux-2.6/kernel/power/process.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/process.c
> +++ linux-2.6/kernel/power/process.c
> @@ -19,6 +19,8 @@
>   */
>  #define TIMEOUT	(20 * HZ)
> 
> +static bool tasks_frozen;
> +
>  static inline int freezeable(struct task_struct * p)
>  {
>  	if ((p == current) ||
> @@ -120,6 +122,10 @@ int freeze_processes(void)
>   Exit:
>  	BUG_ON(in_atomic());
>  	printk("\n");
> +
> +	if (!error)
> +		tasks_frozen = true;
> +

It's not really about whether some tasks are frozen -- that can 
happen using the cgroup freezer too. The flag really indicates if
all killable tasks are frozen. That can't happen using the cgroup
freezer since the root cgroup can't be frozen. So I think some name changes 
are in order but otherwise the patch looks fine.

Cheers,
	-Matt Helsley
