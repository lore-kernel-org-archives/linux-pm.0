From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
Date: Mon, 17 Dec 2018 12:42:25 +0100
Message-ID: <3468793.EN3tBH1YX1@aspire.rjw.lan>
References: <20181211162048.21906-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211162048.21906-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 11, 2018 5:20:48 PM CET Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/power/main.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 35b50823d83b..98e76cad128b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -318,23 +318,12 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
>  
>  	return 0;
>  }
> -
> -static int suspend_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, suspend_stats_show, NULL);
> -}
> -
> -static const struct file_operations suspend_stats_operations = {
> -	.open           = suspend_stats_open,
> -	.read           = seq_read,
> -	.llseek         = seq_lseek,
> -	.release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(suspend_stats);
>  
>  static int __init pm_debugfs_init(void)
>  {
>  	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> -			NULL, NULL, &suspend_stats_operations);
> +			NULL, NULL, &suspend_stats_fops);
>  	return 0;
>  }
>  
> 

Applied, thanks!
