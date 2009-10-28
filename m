From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] PM / Hibernate: swap, use KERN_CONT
Date: Wed, 28 Oct 2009 23:08:52 +0100
Message-ID: <200910282308.52955.rjw__14804.4687383392$1256768036$gmane$org@sisk.pl>
References: <1255176024-12420-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255176024-12420-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 10 October 2009, Jiri Slaby wrote:
> Use KERN_CONT in save_image for printks. So that anybody won't
> try to add a loglevel.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  kernel/power/swap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 47586d9..4c0f80b 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -437,7 +437,7 @@ static int save_image(struct swap_map_handle *handle,
>  		if (ret)
>  			break;
>  		if (!(nr_pages % m))
> -			printk("\b\b\b\b%3d%%", nr_pages / m);
> +			printk(KERN_CONT "\b\b\b\b%3d%%", nr_pages / m);
>  		nr_pages++;
>  	}
>  	err2 = wait_on_bio_chain(&bio);
> @@ -445,9 +445,9 @@ static int save_image(struct swap_map_handle *handle,
>  	if (!ret)
>  		ret = err2;
>  	if (!ret)
> -		printk("\b\b\b\bdone\n");
> +		printk(KERN_CONT "\b\b\b\bdone\n");
>  	else
> -		printk("\n");
> +		printk(KERN_CONT "\n");
>  	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
>  	return ret;
>  }
> 
