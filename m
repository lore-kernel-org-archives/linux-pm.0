From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND] PM/Hibernate: use rb_entry
Date: Wed, 24 Oct 2012 23:57:46 +0200
Message-ID: <6750099.YBevmVYGux@vostro.rjw.lan>
References: <1349086372.2721.1.camel@offbook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349086372.2721.1.camel@offbook>
Sender: linux-kernel-owner@vger.kernel.org
To: dave@gnu.org
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 01 of October 2012 12:12:52 Davidlohr Bueso wrote:
> Since the software suspend extents are organized in an rbtree, use rb_entry
> instead of container_of, as it is semantically more appropriate in order to
> get a node as it is iterated.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


> ---
>  kernel/power/swap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 3c9d764..7c33ed2 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -126,7 +126,7 @@ static int swsusp_extents_insert(unsigned long swap_offset)
>  
>  	/* Figure out where to put the new node */
>  	while (*new) {
> -		ext = container_of(*new, struct swsusp_extent, node);
> +		ext = rb_entry(*new, struct swsusp_extent, node);
>  		parent = *new;
>  		if (swap_offset < ext->start) {
>  			/* Try to merge */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
