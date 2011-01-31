From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] PM: use appropriate printk priority level
Date: Mon, 31 Jan 2011 11:12:29 +0100
Message-ID: <201101311112.29528.rjw__34781.6571746536$1296468953$gmane$org@sisk.pl>
References: <20110125235700.GR8008@google.com>
	<1296084570-31453-4-git-send-email-msb@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1296084570-31453-4-git-send-email-msb@chromium.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mandeep Singh Baines <msb@chromium.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 27, 2011, Mandeep Singh Baines wrote:
> printk()s without a priority level default to KERN_WARNING. To reduce
> noise at KERN_WARNING, this patch set the priority level appriopriately
> for unleveled printks()s. This should be useful to folks that look at
> dmesg warnings closely.
> 
> Changed these messages to pr_info. But might be more appropriate as
> pr_debug.
> 
> Signed-off-by: Mandeep Singh Baines <msb@chromium.org>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  drivers/base/power/trace.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index 9f4258d..c80e138 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -112,7 +112,7 @@ static unsigned int read_magic_time(void)
>  	unsigned int val;
>  
>  	get_rtc_time(&time);
> -	printk("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
> +	pr_info("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
>  		time.tm_hour, time.tm_min, time.tm_sec,
>  		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
>  	val = time.tm_year;				/* 100 years */
> @@ -179,7 +179,7 @@ static int show_file_hash(unsigned int value)
>  		unsigned int hash = hash_string(lineno, file, FILEHASH);
>  		if (hash != value)
>  			continue;
> -		printk("  hash matches %s:%u\n", file, lineno);
> +		pr_info("  hash matches %s:%u\n", file, lineno);
>  		match++;
>  	}
>  	return match;
> @@ -255,7 +255,7 @@ static int late_resume_init(void)
>  	val = val / FILEHASH;
>  	dev = val /* % DEVHASH */;
>  
> -	printk("  Magic number: %d:%d:%d\n", user, file, dev);
> +	pr_info("  Magic number: %d:%d:%d\n", user, file, dev);
>  	show_file_hash(file);
>  	show_dev_hash(dev);
>  	return 0;
> 
