From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH TRIVIAL] PM / wakeup: only recommend "call"ing device_init_wakeup() once
Date: Tue, 19 Dec 2017 11:45:23 +0100
Message-ID: <2776612.L7VRzgYgOe@aspire.rjw.lan>
References: <20171218233048.156954-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55053 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933165AbdLSKqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 05:46:13 -0500
In-Reply-To: <20171218233048.156954-1-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tuesday, December 19, 2017 12:30:48 AM CET Brian Norris wrote:
> I'll admit admit it: I've written bad driver code that tries to
> configure a device's wake IRQ without having called device_init_wakeup()
> first. But do you really have to ask ask me twice?
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 38559f04db2c..cb72965b3281 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -298,7 +298,7 @@ int device_wakeup_attach_irq(struct device *dev,
>  
>  	ws = dev->power.wakeup;
>  	if (!ws) {
> -		dev_err(dev, "forgot to call call device_init_wakeup?\n");
> +		dev_err(dev, "forgot to call device_init_wakeup?\n");
>  		return -EINVAL;
>  	}
>  
> 

Applied, thanks!
