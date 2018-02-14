From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Update links_count also if !CONFIG_SRCU
Date: Wed, 14 Feb 2018 11:53:37 +0100
Message-ID: <28130344.VaHZHOhuzq@aspire.rjw.lan>
References: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:45513 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967159AbeBNKz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Feb 2018 05:55:27 -0500
In-Reply-To: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Saturday, February 10, 2018 7:13:58 PM CET Lukas Wunner wrote:
> Commit baa8809f6097 ("PM / runtime: Optimize the use of device links")
> added an invocation of pm_runtime_drop_link() to __device_link_del().
> However there are two variants of that function, one for CONFIG_SRCU and
> another for !CONFIG_SRCU, and the commit only modified the former.
> 
> Fixes: baa8809f6097 ("PM / runtime: Optimize the use of device links")
> Cc: stable@vger.kernel.org # v4.10+
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b2261f92f2f1..5847364f25d9 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -310,6 +310,9 @@ static void __device_link_del(struct device_link *link)
>  	dev_info(link->consumer, "Dropping the link to %s\n",
>  		 dev_name(link->supplier));
>  
> +	if (link->flags & DL_FLAG_PM_RUNTIME)
> +		pm_runtime_drop_link(link->consumer);
> +
>  	list_del(&link->s_node);
>  	list_del(&link->c_node);
>  	device_link_free(link);
> 

Applied, thanks!
