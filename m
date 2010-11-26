From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Power Hibernate: hibernation_ops->leave
	should be checked as well.
Date: Fri, 26 Nov 2010 23:08:49 +0100
Message-ID: <201011262308.49577.rjw@sisk.pl>
References: <1290748003-26125-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1290748003-26125-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, kyungmin.park@samsung.com, myungjoo.ham@gmail.com, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, November 26, 2010, MyungJoo Ham wrote:
> Because hibernate calls hibernation_ops->leave() without checking
> whether hibernation_ops->leave is NULL or not, hiberantion_set_ops
> should WARN_ON if hibernation_ops->leave is NULL.
> 
> This patch added one more condition to check hibernation_ops->leave.

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  kernel/power/hibernate.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 8dc31e0..e6c498d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -61,7 +61,7 @@ void hibernation_set_ops(struct platform_hibernation_ops *ops)
>  {
>  	if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
>  	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
> -	    && ops->restore_cleanup)) {
> +	    && ops->restore_cleanup && ops->leave)) {
>  		WARN_ON(1);
>  		return;
>  	}
> 
