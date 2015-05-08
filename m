From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / clock_ops: Fix clock error check in __pm_clk_add()
Date: Fri, 8 May 2015 10:19:55 -0700
Message-ID: <20150508171955.GA38039@dtor-ws>
References: <1431074863-19124-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37935 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbbEHRUA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 13:20:00 -0400
Content-Disposition: inline
In-Reply-To: <1431074863-19124-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 08, 2015 at 10:47:43AM +0200, Geert Uytterhoeven wrote:
> In the final iteration of commit 245bd6f6af8a62a2 ("PM / clock_ops: Add
> pm_clk_add_clk()"), a refcount increment was added by Grygorii Strashko.
> However, the accompanying IS_ERR() check operates on the wrong clock
> pointer, which is always zero at this point, i.e. not an error.
> This may lead to a NULL pointer dereference later, when __clk_get()
> tries to dereference an error pointer.
> 
> Check the passed clock pointer instead to fix this.

Frankly I would remove the check altogether. Why do we only check for
IS_ERR and not NULL or otherwise validate the pointer? The clk is passed
in and we do not call any API that would return ERR_PTR-encoded value to
us so we shoud lnot even try to handle IS_ERR here.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 245bd6f6af8a62a2 ("PM / clock_ops: Add pm_clk_add_clk()")
> ---
> Note that there are no users of pm_clk_add_clk() in next-20150508, so
> for now no in-tree code is affected.
> ---
>  drivers/base/power/clock_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 7fdd0172605afe1b..c7b0fcebf168cabe 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -93,7 +93,7 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
>  			return -ENOMEM;
>  		}
>  	} else {
> -		if (IS_ERR(ce->clk) || !__clk_get(clk)) {
> +		if (IS_ERR(clk) || !__clk_get(clk)) {
>  			kfree(ce);
>  			return -ENOENT;
>  		}
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
