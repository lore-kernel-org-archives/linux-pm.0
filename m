From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 06/27] power: wakeup: Remove use of seq_printf return
 value
Date: Sun, 22 Feb 2015 22:38:35 +0100
Message-ID: <20150222213835.GA7817@amd>
References: <cover.1424573328.git.joe@perches.com>
 <1b5eb664ab9313f1c5b9868819e1960d5dc597ac.1424573328.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1b5eb664ab9313f1c5b9868819e1960d5dc597ac.1424573328.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat 2015-02-21 18:53:33, Joe Perches wrote:
> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
> 
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")

You've just removed overflow handling from
print_wakeup_source_stats. Can you explain why that is good idea?

								Pavel

> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -842,7 +842,6 @@ static int print_wakeup_source_stats(struct seq_file *m,
>  	unsigned long active_count;
>  	ktime_t active_time;
>  	ktime_t prevent_sleep_time;
> -	int ret;
>  
>  	spin_lock_irqsave(&ws->lock, flags);
>  
> @@ -865,17 +864,16 @@ static int print_wakeup_source_stats(struct seq_file *m,
>  		active_time = ktime_set(0, 0);
>  	}
>  
> -	ret = seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t"
> -			"%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
> -			ws->name, active_count, ws->event_count,
> -			ws->wakeup_count, ws->expire_count,
> -			ktime_to_ms(active_time), ktime_to_ms(total_time),
> -			ktime_to_ms(max_time), ktime_to_ms(ws->last_time),
> -			ktime_to_ms(prevent_sleep_time));
> +	seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
> +		   ws->name, active_count, ws->event_count,
> +		   ws->wakeup_count, ws->expire_count,
> +		   ktime_to_ms(active_time), ktime_to_ms(total_time),
> +		   ktime_to_ms(max_time), ktime_to_ms(ws->last_time),
> +		   ktime_to_ms(prevent_sleep_time));
>  
>  	spin_unlock_irqrestore(&ws->lock, flags);
>  
> -	return ret;
> +	return 0;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
