From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: check sysdev_suspend(PMSG_FREEZE) return
	value
Date: Fri, 15 May 2009 23:07:08 +0200
Message-ID: <200905152307.08977.rjw@sisk.pl>
References: <20090515113349.3659.20040.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090515113349.3659.20040.stgit@bob.kio>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 15 May 2009, Bjorn Helgaas wrote:
> Check the return value of sysdev_suspend().  I think this was a typo.

Yes, it was, good catch!

I'm going to push that to Linus for .30.

> Without this change, the following "if" check is always false.
> I also changed the error message so it's distinguishable from the
> similar message a few lines above.

Thanks,
Rafael

 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  kernel/power/disk.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> index 2616832..6674722 100644
> --- a/kernel/power/disk.c
> +++ b/kernel/power/disk.c
> @@ -242,9 +242,9 @@ static int create_image(int platform_mode)
>  
>  	local_irq_disable();
>  
> -	sysdev_suspend(PMSG_FREEZE);
> +	error = sysdev_suspend(PMSG_FREEZE);
>  	if (error) {
> -		printk(KERN_ERR "PM: Some devices failed to power down, "
> +		printk(KERN_ERR "PM: Some system devices failed to power down, "
>  			"aborting hibernation\n");
>  		goto Enable_irqs;
>  	}
> 
