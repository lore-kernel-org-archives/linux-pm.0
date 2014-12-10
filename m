From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: remove double calls to find_device_opp()
Date: Thu, 11 Dec 2014 00:02:26 +0100
Message-ID: <1584369.zJO5LU1Dm4@vostro.rjw.lan>
References: <ad3feb97e2a3c80e8b3897a9ca17d682034e6de6.1418026567.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64616 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750744AbaLJWku (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 17:40:50 -0500
In-Reply-To: <ad3feb97e2a3c80e8b3897a9ca17d682034e6de6.1418026567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Monday, December 08, 2014 01:46:18 PM Viresh Kumar wrote:
> By mistake we called find_device_opp() twice in of_free_opp_table(), fix it.
> 
> Generated diff doesn't show the problem well and so here is the code snippet:
> 
> void of_free_opp_table(struct device *dev)
> {
> 	struct device_opp *dev_opp = find_device_opp(dev);
> 	struct dev_pm_opp *opp, *tmp;
> 
> 	/* Check for existing list for 'dev' */
> 	dev_opp = find_device_opp(dev);
> 
> 	...
> }
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

> ---
>  drivers/base/power/opp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 2d195f3..16c59f4 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -768,7 +768,7 @@ EXPORT_SYMBOL_GPL(of_init_opp_table);
>   */
>  void of_free_opp_table(struct device *dev)
>  {
> -	struct device_opp *dev_opp = find_device_opp(dev);
> +	struct device_opp *dev_opp;
>  	struct dev_pm_opp *opp, *tmp;
>  
>  	/* Check for existing list for 'dev' */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
