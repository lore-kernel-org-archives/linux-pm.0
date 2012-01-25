From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: PM: cannot hibernate -- BUG
	at	kernel/workqueue.c:3659
Date: Wed, 25 Jan 2012 23:00:12 +0100
Message-ID: <4F207B6C.9090504@gmail.com>
References: <4F1EC8D5.5040102@suse.cz> <201201250002.37916.rjw@sisk.pl>
	<4F1F4717.2090704@gmail.com> <201201250110.44360.rjw@sisk.pl>
	<4F20204F.6040606@linux.vnet.ibm.com>
	<4F202721.6050900@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F202721.6050900@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Baohua.Song@csr.com, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

On 01/25/2012 05:00 PM, Srivatsa S. Bhat wrote:
> So, Jiri, can you please try the following patch and see if it works for
> you as expected? I'll be happy to provide a formal patch with a changelog
> if this works.

FWIW it works, thanks. If you want me test a proper fix, jsut let me know.

> ---
>  kernel/workqueue.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bec7b5b..cb26c5d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3656,7 +3656,9 @@ void freeze_workqueues_begin(void)
>  
>  	spin_lock(&workqueue_lock);
>  
> -	BUG_ON(workqueue_freezing);
> +	if (workqueue_freezing)
> +		goto out_unlock;
> +
>  	workqueue_freezing = true;
>  
>  	for_each_gcwq_cpu(cpu) {
> @@ -3678,6 +3680,7 @@ void freeze_workqueues_begin(void)
>  		spin_unlock_irq(&gcwq->lock);
>  	}
>  
> +out_unlock:
>  	spin_unlock(&workqueue_lock);
>  }
>  


-- 
js
