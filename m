From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] uswsusp: automatically free the in-memory
	image once s2disk has finished with it
Date: Wed, 2 Dec 2009 22:47:24 +0100
Message-ID: <200912022247.24705.rjw__44335.0531430498$1259790550$gmane$org@sisk.pl>
References: <4B1575AC.6080904@tuffmail.co.uk> <20091202122019.GD1457@csn.ul.ie>
	<4B16797C.3010304@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B16797C.3010304@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Mel Gorman <mel@csn.ul.ie>, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 December 2009, Alan Jenkins wrote:
> The original in-kernel suspend (swsusp) frees the in-memory hibernation
> image before powering off the machine.  s2disk doesn't, so there is
> _much_ less free memory when it tries to power off.
> 
> This is a gratuitous difference.  The userspace suspend interface
> /dev/snapshot only allows the hibernation image to be read once.
> Once the s2disk program has read the last page, we can free the entire
> image.
> 
> This avoids a hang after writing the hibernation image which was
> triggered by commit 5f8dcc21211a3d4e3a7a5ca366b469fb88117f61
> "page-allocator: split per-cpu list into one-list-per-migrate-type":
> 
>     [top of trace lost due to screen height]
>     ? shrink_zone
>     ? try_to_free_pages
>     ? isolate_pages_global
>     ? __alloc_pages_nodemask
>     ? kthread
>     ? __get_free_pages
>     ? copy_process
>     ? kthread
>     ? do_fork
>     ...
> 
>     INFO: task s2disk:2036 blocked for more than 120 seconds
>     ...
>     Call Trace:
>     ...
>     ? wait_for_common
>     ? default_wake_function
>     ? kthread_create
>     ? worker_thread
>     ? create_workqueue_thread
>     ? worker_thread
>     ? __create_workqueue_key
>     ? stop_machine_create
>     ? disable_nonboot_cpus
>     ? hibernation_platform_enter
>     ? snapshot_ioctl
>     ...
>     ? sys_ioctl
>     ...
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Thanks for tracking this, great job!

I'm going to push this patch to Linus in the next batch (before 2.6.32 if I
manage to).

Best,
Rafael


> ---
>  kernel/power/user.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index bf0014d..94d0210 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -165,6 +165,10 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
>  			res = -EFAULT;
>  		else
>  			*offp = data->handle.offset;
> +	} else {
> +		swsusp_free();
> +		memset(&data->handle, 0, sizeof(struct snapshot_handle));
> +		data->ready = 0;
>  	}
>  
>   Unlock:
> 
