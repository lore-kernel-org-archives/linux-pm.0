From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] PM / clk: don't leave clocks enabled when driver not bound
Date: Sat, 09 Jan 2016 00:34:16 +0100
Message-ID: <1747871.WodLblVjL1@vostro.rjw.lan>
References: <1452163771-73303-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45233 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754468AbcAHXDb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 18:03:31 -0500
In-Reply-To: <1452163771-73303-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thursday, January 07, 2016 12:49:31 PM Andy Shevchenko wrote:
> There is a new notification BUS_NOTIFY_DRIVER_NOT_BOUND that is issued when
> driver fails during binding. In such case pm_clk_notify(), when PM_CLK=n,
> leaves clocks enabled. Undo operations that has been done in
> BUS_NOTIFY_BIND_DRIVER case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/clock_ops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 60ee559..c39b861 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -473,6 +473,7 @@ static int pm_clk_notify(struct notifier_block *nb,
>  			enable_clock(dev, NULL);
>  		}
>  		break;
> +	case BUS_NOTIFY_DRIVER_NOT_BOUND:
>  	case BUS_NOTIFY_UNBOUND_DRIVER:
>  		if (clknb->con_ids[0]) {
>  			for (con_id = clknb->con_ids; *con_id; con_id++)

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
