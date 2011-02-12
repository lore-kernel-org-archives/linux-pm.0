From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: fix return value when alloc fail
Date: Sat, 12 Feb 2011 21:09:15 +0100
Message-ID: <201102122109.15966.rjw@sisk.pl>
References: <20110212172603.GA2721@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110212172603.GA2721@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stanislaw Gruszka <stf_xl@pop3.wp.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, February 12, 2011, Stanislaw Gruszka wrote:
> Currently we return 0 in swsusp_alloc() when alloc_image_page() fail.
> Patch fixes that. Also remove unneeded "error" variable since only
> possible error is -ENOMEM.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Good catch, thanks!  Patch applied to suspend-2.6/linux-next.

Rafael


> ---
>  kernel/power/snapshot.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 0dac75e..64db648 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1519,11 +1519,8 @@ static int
>  swsusp_alloc(struct memory_bitmap *orig_bm, struct memory_bitmap *copy_bm,
>  		unsigned int nr_pages, unsigned int nr_highmem)
>  {
> -	int error = 0;
> -
>  	if (nr_highmem > 0) {
> -		error = get_highmem_buffer(PG_ANY);
> -		if (error)
> +		if (get_highmem_buffer(PG_ANY))
>  			goto err_out;
>  		if (nr_highmem > alloc_highmem) {
>  			nr_highmem -= alloc_highmem;
> @@ -1546,7 +1543,7 @@ swsusp_alloc(struct memory_bitmap *orig_bm, struct memory_bitmap *copy_bm,
>  
>   err_out:
>  	swsusp_free();
> -	return error;
> +	return -ENOMEM;
>  }
>  
>  asmlinkage int swsusp_save(void)
> 
