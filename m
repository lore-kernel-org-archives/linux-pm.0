From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH 1/2] dmaengine: qcom-bam-dma: Add pm_runtime support
Date: Mon, 2 May 2016 18:08:12 +0530
Message-ID: <CANYu_0s-kb4KZ+E2rn+NW8qB-jxz8snLmSWON8mf3Ksbh47EBw@mail.gmail.com>
References: <1462191475-30904-1-git-send-email-pramod.gurav@linaro.org>
	<C246CAC1457055469EF09E3A7AC4E11A4A57D4C0@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A57D4C0@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>, "andy.gross@linaro.org" <andy.gross@linaro.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>, "okaya@codeaurora.org" <okaya@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Kedar,
Thanks for having a look and comments.

On 2 May 2016 at 17:58, Appana Durga Kedareswara Rao
<appana.durga.rao@xilinx.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
> > owner@vger.kernel.org] On Behalf Of Pramod Gurav
> > Sent: Monday, May 02, 2016 5:48 PM
> > To: vinod.koul@intel.com; andy.gross@linaro.org; ulf.hansson@linaro.org;
> > rjw@rjwysocki.net; linux-arm-msm@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > dmaengine@vger.kernel.org; stanimir.varbanov@linaro.org;
> > okaya@codeaurora.org; Pramod Gurav <pramod.gurav@linaro.org>
> > Subject: [PATCH 1/2] dmaengine: qcom-bam-dma: Add pm_runtime support
> >
> > Adds pm_runtime support for BAM DMA so that clock
> > is enabled only when there is a transaction going on to help
> > save power.
> >
> > Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> > ---
> >  drivers/dma/qcom/bam_dma.c | 88
> > +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 87 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 5b427c4..577f323 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/of_dma.h>
> >  #include <linux/clk.h>
> >  #include <linux/dmaengine.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include "../dmaengine.h"
> >  #include "../virt-dma.h"
> > @@ -58,6 +59,8 @@ struct bam_desc_hw {
> >       u16 flags;
> >  };
> >
> > +#define BAM_DMA_AUTOSUSPEND_DELAY 100
> > +
> >  #define DESC_FLAG_INT BIT(15)
> >  #define DESC_FLAG_EOT BIT(14)
> >  #define DESC_FLAG_EOB BIT(13)
> > @@ -535,6 +538,7 @@ static void bam_free_chan(struct dma_chan *chan)
> >               return;
> >       }
> >
> > +     pm_runtime_get_sync(bdev->dev);
> >       spin_lock_irqsave(&bchan->vc.lock, flags);
> >       bam_reset_channel(bchan);
> >       spin_unlock_irqrestore(&bchan->vc.lock, flags);
> > @@ -550,6 +554,8 @@ static void bam_free_chan(struct dma_chan *chan)
> >
> >       /* disable irq */
> >       writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_IRQ_EN));
> > +     pm_runtime_mark_last_busy(bdev->dev);
> > +     pm_runtime_put_autosuspend(bdev->dev);
> >  }
> >
> >  /**
> > @@ -696,10 +702,13 @@ static int bam_pause(struct dma_chan *chan)
> >       struct bam_device *bdev = bchan->bdev;
> >       unsigned long flag;
> >
> > +     pm_runtime_get_sync(bdev->dev);
> >       spin_lock_irqsave(&bchan->vc.lock, flag);
> >       writel_relaxed(1, bam_addr(bdev, bchan->id, BAM_P_HALT));
> >       bchan->paused = 1;
> >       spin_unlock_irqrestore(&bchan->vc.lock, flag);
> > +     pm_runtime_mark_last_busy(bdev->dev);
> > +     pm_runtime_put_autosuspend(bdev->dev);
> >
> >       return 0;
> >  }
> > @@ -715,10 +724,13 @@ static int bam_resume(struct dma_chan *chan)
> >       struct bam_device *bdev = bchan->bdev;
> >       unsigned long flag;
> >
> > +     pm_runtime_get_sync(bdev->dev);
> >       spin_lock_irqsave(&bchan->vc.lock, flag);
> >       writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_HALT));
> >       bchan->paused = 0;
> >       spin_unlock_irqrestore(&bchan->vc.lock, flag);
> > +     pm_runtime_mark_last_busy(bdev->dev);
> > +     pm_runtime_put_autosuspend(bdev->dev);
> >
> >       return 0;
> >  }
> > @@ -943,6 +955,7 @@ static void bam_start_dma(struct bam_chan *bchan)
> >       wmb();
> >       writel_relaxed(bchan->tail * sizeof(struct bam_desc_hw),
> >                       bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
> > +
>
> Unrelated change...
>
> >  }
> >
> >  /**
> > @@ -967,6 +980,9 @@ static void dma_tasklet(unsigned long data)
> >                       bam_start_dma(bchan);
> >               spin_unlock_irqrestore(&bchan->vc.lock, flags);
> >       }
> > +
> > +     pm_runtime_mark_last_busy(bdev->dev);
> > +     pm_runtime_put_autosuspend(bdev->dev);
> >  }
> >
> >  /**
> > @@ -978,8 +994,12 @@ static void dma_tasklet(unsigned long data)
> >  static void bam_issue_pending(struct dma_chan *chan)
> >  {
> >       struct bam_chan *bchan = to_bam_chan(chan);
> > +     struct bam_device *bdev = bchan->bdev;
> >       unsigned long flags;
> >
> > +     if (pm_runtime_status_suspended(bdev->dev))
> > +             pm_runtime_get_sync(bdev->dev);
> > +
> >       spin_lock_irqsave(&bchan->vc.lock, flags);
> >
> >       /* if work pending and idle, start a transaction */
> > @@ -1210,6 +1230,13 @@ static int bam_dma_probe(struct platform_device
> > *pdev)
> >       if (ret)
> >               goto err_unregister_dma;
> >
> > +     pm_runtime_irq_safe(&pdev->dev);
> > +     pm_runtime_set_autosuspend_delay(&pdev->dev,
> > BAM_DMA_AUTOSUSPEND_DELAY);
> > +     pm_runtime_use_autosuspend(&pdev->dev);
> > +     pm_runtime_mark_last_busy(&pdev->dev);
> > +     pm_runtime_set_active(&pdev->dev);
> > +     pm_runtime_enable(&pdev->dev);
> > +
> >       return 0;
> >
> >  err_unregister_dma:
> > @@ -1221,7 +1248,6 @@ err_tasklet_kill:
> >       tasklet_kill(&bdev->task);
> >  err_disable_clk:
> >       clk_disable_unprepare(bdev->bamclk);
> > -
>
> Unrelated change....
>
Will undo these two. Ended up in patch by mistake.
>
> >       return ret;
> >  }
> >
> > @@ -1252,16 +1278,76 @@ static int bam_dma_remove(struct
> > platform_device *pdev)
> >
> >       tasklet_kill(&bdev->task);
> >
> > +     pm_runtime_get_sync(&pdev->dev);
> >       clk_disable_unprepare(bdev->bamclk);
> > +     pm_runtime_disable(&pdev->dev);
> > +     pm_runtime_put_noidle(&pdev->dev);
> > +     pm_runtime_set_suspended(&pdev->dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int bam_dma_runtime_suspend(struct device *dev)
> > +{
> > +     struct bam_device *bdev = dev_get_drvdata(dev);
> > +
> > +     clk_disable(bdev->bamclk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int bam_dma_runtime_resume(struct device *dev)
> > +{
> > +     struct bam_device *bdev = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = clk_enable(bdev->bamclk);
>
> Instead of clk_enable why can't you call the clk_prepare_enable directly here?
> clk_disable_unprepare in the suspend.
>

The device may be resumed in interrupt context of the client and hence
should not sleep as clk_prepare might sleep.
Hence separated clk_enable and prepare.

>
> I mean in the probe remove the clk_prepare_enable and wherever you need to access the
> Device register call the pm_runtime_get_sync.
>
In case CONFIG_PM is disabled the device should still function hence
clk_prepare_enable in probe.

>
> Thanks,
> Kedar.
>
> > +     if (ret < 0) {
> > +             dev_err(dev, "clk_enable failed: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#ifdef CONFIG_PM_SLEEP
> > +static int bam_dma_suspend(struct device *dev)
> > +{
> > +     struct bam_device *bdev = dev_get_drvdata(dev);
> > +
> > +     pm_runtime_force_suspend(dev);
> > +
> > +     clk_unprepare(bdev->bamclk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int bam_dma_resume(struct device *dev)
> > +{
> > +     struct bam_device *bdev = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = clk_prepare(bdev->bamclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pm_runtime_force_resume(dev);
> >
> >       return 0;
> >  }
> > +#endif
> > +
> > +static const struct dev_pm_ops bam_dma_pm_ops = {
> > +     SET_LATE_SYSTEM_SLEEP_PM_OPS(bam_dma_suspend,
> > bam_dma_resume)
> > +     SET_RUNTIME_PM_OPS(bam_dma_runtime_suspend,
> > bam_dma_runtime_resume,
> > +                             NULL)
> > +};
> >
> >  static struct platform_driver bam_dma_driver = {
> >       .probe = bam_dma_probe,
> >       .remove = bam_dma_remove,
> >       .driver = {
> >               .name = "bam-dma-engine",
> > +             .pm = &bam_dma_pm_ops,
> >               .of_match_table = bam_of_match,
> >       },
> >  };
> > --
> > 1.8.2.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
