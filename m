From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] kernel: power: replacing printk
Date: Tue, 27 Oct 2015 12:00:43 -0700
Message-ID: <1445972443.2757.34.camel@perches.com>
References: <saurabh.truth@gmail.com>
	 <1445919397-6807-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445919397-6807-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-10-27 at 09:46 +0530, Saurabh Sengar wrote:
> replacing prink(s) with appropriate pr_info and pr_err
[]
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
[]
> @@ -486,9 +486,9 @@ static int enter_state(suspend_state_t state)
>  
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -	printk(KERN_INFO "PM: Syncing filesystems ... ");
> +	pr_info("PM: Syncing filesystems ... ");
>  	sys_sync();
> -	printk("done.\n");
> +	pr_info("done.\n");
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
>  

This isn't the same output.

The original code emits on a single line.

This new code emits on two lines, the second
line without a "PM: " prefix.
