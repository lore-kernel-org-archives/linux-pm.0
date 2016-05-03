From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v2 1/2] dmaengine: qcom-bam-dma: Add pm_runtime support
Date: Tue, 3 May 2016 17:00:17 +0530
Message-ID: <CANYu_0uUE7Vtmx8ifLPNC9RpfSPPy-VqUNZAF+UzXCA68WnQcA@mail.gmail.com>
References: <1462268237-29508-1-git-send-email-pramod.gurav@linaro.org>
	<CAKDJKT6q7bg7UTDex_S_+nG-3q16H0Fe0UE_hp2VvFm60ZYQgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35123 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbcECLaS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 07:30:18 -0400
Received: by mail-lf0-f42.google.com with SMTP id j8so18002895lfd.2
        for <linux-pm@vger.kernel.org>; Tue, 03 May 2016 04:30:18 -0700 (PDT)
In-Reply-To: <CAKDJKT6q7bg7UTDex_S_+nG-3q16H0Fe0UE_hp2VvFm60ZYQgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: vinod.koul@intel.com, Andy Gross <andy.gross@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Stanimir Varbanov <stanimir.varbanov@linaro.org>, okaya@codeaurora.org

Hi Manish,

Thanks for review.

On 3 May 2016 at 15:21, Manish Badarkhe <badarkhe.manish@gmail.com> wrote:
> Hi Pramod
>
>> @@ -715,10 +724,13 @@ static int bam_resume(struct dma_chan *chan)
>>         struct bam_device *bdev = bchan->bdev;
>>         unsigned long flag;
>>
>> +       pm_runtime_get_sync(bdev->dev);
>>         spin_lock_irqsave(&bchan->vc.lock, flag);
>>         writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_HALT));
>>         bchan->paused = 0;
>>         spin_unlock_irqrestore(&bchan->vc.lock, flag);
>> +       pm_runtime_mark_last_busy(bdev->dev);
>> +       pm_runtime_put_autosuspend(bdev->dev);
>>
>>         return 0;
>>  }
>
> Why this function simply return 'success' without any error capture?
>
I should check return of pm_runtime_get_sync.

>> @@ -1252,16 +1278,76 @@ static int bam_dma_remove(struct platform_device *pdev)
>>
>>         tasklet_kill(&bdev->task);
>>
>> +       pm_runtime_get_sync(&pdev->dev);
>>         clk_disable_unprepare(bdev->bamclk);
>> +       pm_runtime_disable(&pdev->dev);
>> +       pm_runtime_put_noidle(&pdev->dev);
>> +       pm_runtime_set_suspended(&pdev->dev);
>> +
>> +       return 0;
>> +}
>
> Why this function simply return 'success' without any error capture?
Need to handle it better.

>
>> +static int bam_dma_runtime_suspend(struct device *dev)
>> +{
>> +       struct bam_device *bdev = dev_get_drvdata(dev);
>> +
>> +       clk_disable(bdev->bamclk);
>> +
>> +       return 0;
>> +}
>
> Why this function simply return 'success' without any error capture?
If probe has succeeded means bdev->bamclk is not NULL and error hence
clk_disable wont return anything.

>
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int bam_dma_suspend(struct device *dev)
>> +{
>> +       struct bam_device *bdev = dev_get_drvdata(dev);
>> +
>> +       pm_runtime_force_suspend(dev);
>> +
>> +       clk_unprepare(bdev->bamclk);
>>
>>         return 0;
>>  }
>
> Why this function simply return 'success' without any error capture?
Same logic applies here as well, as pm_runtime_force_suspend and
clk_unprepare may not return error in our case once probe is through.

>
> Regards
> Manish Badarkhe
