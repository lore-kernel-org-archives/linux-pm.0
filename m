From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3.0-rc3] PM: free memory bitmaps if opening
	/dev/snapshot fails
Date: Sat, 18 Jun 2011 22:44:36 +0200
Message-ID: <201106182244.36876.rjw__30588.2444758483$1308429885$gmane$org@sisk.pl>
References: <20110617175231.A80284030A@alaris.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110617175231.A80284030A@alaris.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2011, Michal Kubecek wrote:
> From: Michal Kubecek <mkubecek@suse.cz>
> 
> When opening /dev/snapshot device, snapshot_open() creates memory
> bitmaps which are freed in snapshot_release(). But if any of the
> callbacks called by pm_notifier_call_chain() returns NOTIFY_BAD, open()
> fails, snapshot_release() is never called and bitmaps are not freed.
> Next attempt to open /dev/snapshot then triggers BUG_ON() check in
> create_basic_memory_bitmaps(). This happens e.g. when vmwatchdog module
> is active on s390x.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Thanks, I'm going to push your patch for 3.0 + stable.

Rafael


> --- 
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 7d02d33..42ddbc6 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -113,8 +113,10 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>  		if (error)
>  			pm_notifier_call_chain(PM_POST_RESTORE);
>  	}
> -	if (error)
> +	if (error) {
> +		free_basic_memory_bitmaps();
>  		atomic_inc(&snapshot_device_available);
> +	}
>  	data->frozen = 0;
>  	data->ready = 0;
>  	data->platform_support = 0;
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> 
> 
