From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: armada: fix incorrect check for drvdata
 allocation failure
Date: Mon, 20 Aug 2018 11:52:34 -0700
Message-ID: <20180820185232.GA16026@localhost.localdomain>
References: <20180730122716.6267-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180730122716.6267-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

hello Colin,

On Mon, Jul 30, 2018 at 01:27:16PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the drvdata allocation failure is being incorrectly checked by
> checking priv and not drvdata.  Fix this and also free priv to fix a
> memory leak.
> 
> Detected by Coverity Scan, CID#1472102 ("Logically dead code")
> 
> Fixes: c9899c183921 ("thermal: armada: use the resource managed registration helper alternative")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 4164a5a4e480..b164fd9f21ac 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -611,8 +611,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!priv)
> +	if (!drvdata) {

Thanks for the fix but, I already collected this patch:

84b64de597bc ("thermal: armada: fix copy-paste error in armada_thermal_probe()")

which fixes the same issue you are addressing here.

> +		devm_kfree(&pdev->dev, priv);

As already mentioned by Daniel, the above is not necessary, as it is a
devm_* helper.

BR,
>  		return -ENOMEM;
> +	}
>  
>  	priv->dev = &pdev->dev;
>  	priv->data = (struct armada_thermal_data *)match->data;
> -- 
> 2.17.1
> 
