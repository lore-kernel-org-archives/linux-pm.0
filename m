From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: qcom-bam-dma: Add pm_runtime support
Date: Tue, 3 May 2016 15:21:39 +0530
Message-ID: <CAKDJKT6q7bg7UTDex_S_+nG-3q16H0Fe0UE_hp2VvFm60ZYQgQ@mail.gmail.com>
References: <1462268237-29508-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:32905 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbcECJvk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 05:51:40 -0400
In-Reply-To: <1462268237-29508-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: vinod.koul@intel.com, andy.gross@linaro.org, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, stanimir.varbanov@linaro.org, okaya@codeaurora.org

Hi Pramod

> @@ -715,10 +724,13 @@ static int bam_resume(struct dma_chan *chan)
>         struct bam_device *bdev = bchan->bdev;
>         unsigned long flag;
>
> +       pm_runtime_get_sync(bdev->dev);
>         spin_lock_irqsave(&bchan->vc.lock, flag);
>         writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_HALT));
>         bchan->paused = 0;
>         spin_unlock_irqrestore(&bchan->vc.lock, flag);
> +       pm_runtime_mark_last_busy(bdev->dev);
> +       pm_runtime_put_autosuspend(bdev->dev);
>
>         return 0;
>  }

Why this function simply return 'success' without any error capture?

> @@ -1252,16 +1278,76 @@ static int bam_dma_remove(struct platform_device *pdev)
>
>         tasklet_kill(&bdev->task);
>
> +       pm_runtime_get_sync(&pdev->dev);
>         clk_disable_unprepare(bdev->bamclk);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +
> +       return 0;
> +}

Why this function simply return 'success' without any error capture?

> +static int bam_dma_runtime_suspend(struct device *dev)
> +{
> +       struct bam_device *bdev = dev_get_drvdata(dev);
> +
> +       clk_disable(bdev->bamclk);
> +
> +       return 0;
> +}

Why this function simply return 'success' without any error capture?


> +#ifdef CONFIG_PM_SLEEP
> +static int bam_dma_suspend(struct device *dev)
> +{
> +       struct bam_device *bdev = dev_get_drvdata(dev);
> +
> +       pm_runtime_force_suspend(dev);
> +
> +       clk_unprepare(bdev->bamclk);
>
>         return 0;
>  }

Why this function simply return 'success' without any error capture?

Regards
Manish Badarkhe
