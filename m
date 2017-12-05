From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: In kernel power management domain_pm created for async schedules
Date: Tue, 5 Dec 2017 14:27:00 +0100
Message-ID: <20171205132700.GA13746@kroah.com>
References: <CGME20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
 <20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdLEN0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 08:26:53 -0500
Content-Disposition: inline
In-Reply-To: <20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikas Bansal <vikas.bansal@samsung.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Dec 05, 2017 at 09:24:18AM +0000, Vikas Bansal wrote:
> >From 8e948f8c697d661f38c2c3a85787e4c48b165adc Mon Sep 17 00:00:00 2001
> From: Vikas Bansal <vikas.bansal@samsung.com>
> Date: Tue, 5 Dec 2017 01:14:41 -0800

Why is all of this here in the patch itself?

> Subject: [PATCH] Put all the async schdules in PM core in domain with name
>  domain_pm. This avoids pm core to wait for async schedules
>  in system other than PM core.

Something went wrong with your commit, you have a very long subject and
no change log text :(

> Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
> ---
>  drivers/base/power/main.c |   25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index db2f044..2d19dfb 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -39,6 +39,7 @@
>  #include "power.h"
>  
>  typedef int (*pm_callback_t)(struct device *);
> +ASYNC_DOMAIN(domain_pm);

Why is this a global symbol?

I don't understand why this is needed, please explain the problem you
are having with the existing code.

thanks,

greg k-h
