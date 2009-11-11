From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1]: Thaws refrigerated bdi flusher threads
 before invoking kthread_stop on them
Date: Wed, 11 Nov 2009 11:34:44 +0100
Message-ID: <20091111103444.GD26423__31982.4328100824$1257935749$gmane$org@elf.ucw.cz>
References: <1257928216.15415.57.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1257928216.15415.57.camel@boson>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Romit Dasgupta <romit@ti.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com
List-Id: linux-pm@vger.kernel.org

On Wed 2009-11-11 14:00:16, Romit Dasgupta wrote:
> Kicks out frozen bdi flusher task out of the refrigerator when the flusher task
> needs to exit.


> Signed-off-by: Romit Dasgupta <romit@ti.com>

Ok, its slightly "interesting", but better than modifying common
code. Looks ok to me.

ACK.
								Pavel

> ---
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 5a37e20..c757b05 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -606,8 +606,11 @@ static void bdi_wb_shutdown(struct backing_dev_info *bdi)
>  	 * Finally, kill the kernel threads. We don't need to be RCU
>  	 * safe anymore, since the bdi is gone from visibility.
>  	 */
> -	list_for_each_entry(wb, &bdi->wb_list, list)
> +	list_for_each_entry(wb, &bdi->wb_list, list) {
> +		if (unlikely(frozen(wb->task)))
> +			wb->task->flags &= ~PF_FROZEN;
>  		kthread_stop(wb->task);
> +	}
>  }
>  
>  void bdi_unregister(struct backing_dev_info *bdi)
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
