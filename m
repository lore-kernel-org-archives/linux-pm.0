From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Date: Thu, 8 Nov 2018 10:15:03 +0530
Message-ID: <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
References: <20181107161346.9887-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107161346.9887-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07-11-18, 11:13, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c | 46 +++--------------------
>  1 file changed, 6 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> index 4d976e8dbb2f..0df87b6480fe 100644
> --- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> +++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> @@ -63,18 +63,7 @@ static int board_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_board_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, board_show, NULL);
> -}
> -
> -static const struct file_operations fops_board = {
> -	.open		= fops_board_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(board);
>  
>  static int info_show(struct seq_file *seq, void *p)
>  {
> @@ -105,18 +94,7 @@ static int info_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_info_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, info_show, NULL);
> -}
> -
> -static const struct file_operations fops_info = {
> -	.open		= fops_info_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(info);
>  
>  static int io_show(struct seq_file *seq, void *p)
>  {
> @@ -162,19 +140,7 @@ static int io_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_io_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, io_show, NULL);
> -}
> -
> -static const struct file_operations fops_io = {
> -	.open		= fops_io_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> -
> +DEFINE_SHOW_ATTRIBUTE(io);
>  
>  static int __init s3c_freq_debugfs_init(void)
>  {
> @@ -185,13 +151,13 @@ static int __init s3c_freq_debugfs_init(void)
>  	}
>  
>  	dbgfs_file_io = debugfs_create_file("io-timing", S_IRUGO, dbgfs_root,
> -					    NULL, &fops_io);
> +					    NULL, &io_fops);
>  
>  	dbgfs_file_info = debugfs_create_file("info", S_IRUGO, dbgfs_root,
> -					      NULL, &fops_info);
> +					      NULL, &info_fops);
>  
>  	dbgfs_file_board = debugfs_create_file("board", S_IRUGO, dbgfs_root,
> -					       NULL, &fops_board);
> +					       NULL, &board_fops);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
