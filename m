From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Add missing header file
Date: Sat, 27 Sep 2014 00:07:29 +0200
Message-ID: <1798331.sYPFUlDYVR@vostro.rjw.lan>
References: <1411725443-17328-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49783 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754811AbaIZVri (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 17:47:38 -0400
In-Reply-To: <1411725443-17328-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>

On Friday, September 26, 2014 11:57:23 AM Ulf Hansson wrote:
> The commit below, starts using errno values in pm.h header file. But it
> didn't include the header for these, let's add it.
> 
> 46420dd73b800f87a19af13af5883855cf38cb08
> (PM / Domains: Add APIs to attach/detach a PM domain for a device)
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Rafael, feel free to squash this change into the commit that was causing the
> issue.

First, it's more convenient for me to apply a fix at this point.

Second ->

> ---
>  include/linux/pm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index c4cbf48..69df420 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -27,6 +27,7 @@
>  #include <linux/wait.h>
>  #include <linux/timer.h>
>  #include <linux/completion.h>
> +#include <linux/errno.h>

-> Can you please move the dev_pm_domain_attach/detach() headers to
include/linux/pm_domain.h instead?

>  /*
>   * Callbacks for platform drivers to implement.
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
