From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] introduce new interface schedule_work_on
Date: Thu, 3 Jul 2008 10:04:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807031001580.2410-100000__27482.0642815486$1215094046$gmane$org@iolanthe.rowland.org>
References: <1215071809.3214.0.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1215071809.3214.0.camel@rzhang-dt.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: harbour@sfinx.od.ua, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jul 2008, Zhang Rui wrote:

> This interface allows adding a job on a specific cpu.
> 
> Although a work struct on a cpu will be scheduled to other cpu if the cpu dies,
> there is a recursion if a work task tries to offline the cpu it's running on.
> we need to schedule the task to a specific cpu in this case.
> http://bugzilla.kernel.org/show_bug.cgi?id=10897
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Rus <harbour@sfinx.od.ua>
> ---
>  include/linux/workqueue.h |    1 +
>  kernel/workqueue.c        |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> Index: linux-2.6/include/linux/workqueue.h
> ===================================================================
> --- linux-2.6.orig/include/linux/workqueue.h	2008-07-03 11:13:23.000000000 +0800
> +++ linux-2.6/include/linux/workqueue.h	2008-07-03 11:13:25.000000000 +0800
> @@ -188,6 +188,7 @@
>  extern void flush_scheduled_work(void);
>  
>  extern int schedule_work(struct work_struct *work);
> +extern int schedule_work_on(int cpu, struct work_struct *work);
>  extern int schedule_delayed_work(struct delayed_work *work, unsigned long delay);
>  extern int schedule_delayed_work_on(int cpu, struct delayed_work *work,
>  					unsigned long delay);

Is there some reason you don't export queue_work_on?  After all, 
queue_delayed_work_on is exported.

Alan Stern
