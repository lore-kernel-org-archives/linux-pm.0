From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v3 1/2] dmaengine: qcom-bam-dma: Add pm_runtime support
Date: Wed, 4 May 2016 15:57:56 -0500
Message-ID: <20160504205756.GA6533@hector.attlocal.net>
References: <1462351323-29530-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34170 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcEDU56 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 16:57:58 -0400
Received: by mail-oi0-f43.google.com with SMTP id k142so80752936oib.1
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2016 13:57:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462351323-29530-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: vinod.koul@intel.com, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, stanimir.varbanov@linaro.org, okaya@codeaurora.org

On Wed, May 04, 2016 at 02:12:02PM +0530, Pramod Gurav wrote:
> Adds pm_runtime support for BAM DMA so that clock
> is enabled only when there is a transaction going on to help
> save power.
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
> Changes in v2:
> - Handled return values of pm_runtime_get_sync to return error
> - Rework remove function
> 
>  drivers/dma/qcom/bam_dma.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 5b427c4..da64511 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -48,6 +48,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/clk.h>
>  #include <linux/dmaengine.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
> @@ -58,6 +59,8 @@ struct bam_desc_hw {
>  	u16 flags;
>  };
>  
> +#define BAM_DMA_AUTOSUSPEND_DELAY 100
> +
>  #define DESC_FLAG_INT BIT(15)
>  #define DESC_FLAG_EOT BIT(14)
>  #define DESC_FLAG_EOB BIT(13)
> @@ -528,11 +531,14 @@ static void bam_free_chan(struct dma_chan *chan)
>  	u32 val;
>  	unsigned long flags;
>  
> +	if (pm_runtime_get_sync(bdev->dev))
> +		return;
> +
>  	vchan_free_chan_resources(to_virt_chan(chan));
>  
>  	if (bchan->curr_txd) {
>  		dev_err(bchan->bdev->dev, "Cannot free busy channel\n");
> -		return;
> +		goto err;
>  	}
>  
>  	spin_lock_irqsave(&bchan->vc.lock, flags);
> @@ -550,6 +556,10 @@ static void bam_free_chan(struct dma_chan *chan)
>  
>  	/* disable irq */
>  	writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_IRQ_EN));
> +
> +err:
> +	pm_runtime_mark_last_busy(bdev->dev);
> +	pm_runtime_put_autosuspend(bdev->dev);
>  }
>  
>  /**
> @@ -695,11 +705,18 @@ static int bam_pause(struct dma_chan *chan)
>  	struct bam_chan *bchan = to_bam_chan(chan);
>  	struct bam_device *bdev = bchan->bdev;
>  	unsigned long flag;
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(bdev->dev);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock_irqsave(&bchan->vc.lock, flag);
>  	writel_relaxed(1, bam_addr(bdev, bchan->id, BAM_P_HALT));
>  	bchan->paused = 1;
>  	spin_unlock_irqrestore(&bchan->vc.lock, flag);
> +	pm_runtime_mark_last_busy(bdev->dev);
> +	pm_runtime_put_autosuspend(bdev->dev);
>  
>  	return 0;
>  }
> @@ -714,11 +731,17 @@ static int bam_resume(struct dma_chan *chan)
>  	struct bam_chan *bchan = to_bam_chan(chan);
>  	struct bam_device *bdev = bchan->bdev;
>  	unsigned long flag;
> +	int ret;
>  
> +	ret = pm_runtime_get_sync(bdev->dev);
> +	if (ret)
> +		return ret;
>  	spin_lock_irqsave(&bchan->vc.lock, flag);
>  	writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_HALT));
>  	bchan->paused = 0;
>  	spin_unlock_irqrestore(&bchan->vc.lock, flag);
> +	pm_runtime_mark_last_busy(bdev->dev);
> +	pm_runtime_put_autosuspend(bdev->dev);
>  
>  	return 0;
>  }
> @@ -967,6 +990,9 @@ static void dma_tasklet(unsigned long data)
>  			bam_start_dma(bchan);
>  		spin_unlock_irqrestore(&bchan->vc.lock, flags);
>  	}
> +
> +	pm_runtime_mark_last_busy(bdev->dev);
> +	pm_runtime_put_autosuspend(bdev->dev);

I think we shouldnt be doing this unless we have nothing else on the lists.
Perhaps the bam_start_dma function can be the place where we decide to do the
get_sync and the autosuspend.

>  }
>  
>  /**
> @@ -978,8 +1004,13 @@ static void dma_tasklet(unsigned long data)
>  static void bam_issue_pending(struct dma_chan *chan)
>  {
>  	struct bam_chan *bchan = to_bam_chan(chan);
> +	struct bam_device *bdev = bchan->bdev;
>  	unsigned long flags;
>  
> +	if (pm_runtime_status_suspended(bdev->dev))
> +		if (pm_runtime_get_sync(bdev->dev))
> +			return;
> +

We should only do this if our lists were empty before.  That means we weren't
doing any work.

>  	spin_lock_irqsave(&bchan->vc.lock, flags);
>  
>  	/* if work pending and idle, start a transaction */
> @@ -1210,6 +1241,13 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_dma;
>  
> +	pm_runtime_irq_safe(&pdev->dev);

I wonder if this is really necessary.  We don't directly access any pm runtime
calls from irq context.

> +	pm_runtime_set_autosuspend_delay(&pdev->dev, BAM_DMA_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);

If we use the autosuspend, we have to make sure we never pull the rug out from
under the device if there is a pending transaction.  So that being the case, I
think if we only do the autosuspend after the lists are empty, we are going to
be ok.  But we can't be allowing autosuspend while the controller is working.


> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	return 0;
>  
>  err_unregister_dma:
> @@ -1230,6 +1268,8 @@ static int bam_dma_remove(struct platform_device *pdev)
>  	struct bam_device *bdev = platform_get_drvdata(pdev);
>  	u32 i;
>  
> +	pm_runtime_force_suspend(&pdev->dev);
> +
>  	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&bdev->common);
>  
> @@ -1257,11 +1297,67 @@ static int bam_dma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int bam_dma_runtime_suspend(struct device *dev)
> +{
> +	struct bam_device *bdev = dev_get_drvdata(dev);
> +
> +	clk_disable(bdev->bamclk);
> +
> +	return 0;
> +}
> +
> +static int bam_dma_runtime_resume(struct device *dev)
> +{
> +	struct bam_device *bdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_enable(bdev->bamclk);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#ifdef CONFIG_PM_SLEEP
> +static int bam_dma_suspend(struct device *dev)
> +{
> +	struct bam_device *bdev = dev_get_drvdata(dev);
> +
> +	pm_runtime_force_suspend(dev);
> +
> +	clk_unprepare(bdev->bamclk);
> +
> +	return 0;
> +}
> +
> +static int bam_dma_resume(struct device *dev)
> +{
> +	struct bam_device *bdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare(bdev->bamclk);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_force_resume(dev);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops bam_dma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(bam_dma_suspend, bam_dma_resume)
> +	SET_RUNTIME_PM_OPS(bam_dma_runtime_suspend, bam_dma_runtime_resume,
> +				NULL)
> +};
> +
>  static struct platform_driver bam_dma_driver = {
>  	.probe = bam_dma_probe,
>  	.remove = bam_dma_remove,
>  	.driver = {
>  		.name = "bam-dma-engine",
> +		.pm = &bam_dma_pm_ops,
>  		.of_match_table = bam_of_match,
>  	},
>  };
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
