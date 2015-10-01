From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 1/2] dmaengine: usb-dmac: Fix crash on runtime suspend
Date: Thu, 1 Oct 2015 10:53:22 +0000
Message-ID: <SG2PR06MB091969749911331385AB7E83D84C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
 <1443684138-32252-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1443684138-32252-2-git-send-email-geert+renesas@glider.be>
Content-Language: ja-JP
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert-san,

> Sent: Thursday, October 01, 2015 4:22 PM
> 
> If CONFIG_PREEMPT=y:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 00000014
>     pgd = c0003000
>     [00000014] *pgd=80000040004003, *pmd=00000000
>     Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>     Modules linked in:
>     CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W       4.3.0-rc3-koelsch-022
>     71-g705498fc5e6a5da8-dirty #1789
>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>     Workqueue: pm pm_runtime_work
>     task: ef578e40 ti: ef57a000 task.ti: ef57a000
>     PC is at usb_dmac_chan_halt+0xc/0xc0
>     LR is at usb_dmac_runtime_suspend+0x28/0x38
>     pc : [<c023c880>]    lr : [<c023c95c>]    psr: 80000113
>     sp : ef57bdf8  ip : 00000008  fp : 00000003
>     r10: 00000008  r9 : c06ab928  r8 : ef49e810
>     r7 : 00000000  r6 : 000000ac  r5 : ef770010  r4 : 00000000
>     r3 : 00000000  r2 : 8ffc2b84  r1 : 00000000  r0 : ef770010
>     Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>     Control: 30c5307d  Table: 40003000  DAC: fffffffd
>     Process kworker/0:1 (pid: 17, stack limit = 0xef57a210)
>     Stack: (0xef57bdf8 to 0xef57c000)
> 
>     [...
> 
>     [<c023c880>] (usb_dmac_chan_halt) from [<c023c95c>] (usb_dmac_runtime_suspend+0x28/0x38)
>     [<c023c95c>] (usb_dmac_runtime_suspend) from [<c027b25c>] (pm_genpd_runtime_suspend+0x74/0x23c)
> 
> This happens because usb_dmac_probe() calls pm_runtime_put() before
> usb_dmac_chan_probe(), leading to the device being suspended before the
> DMA channels are initialized, causing a NULL pointer dereference.
> 
> Move the call to pm_runtime_put() to the end of usb_dmac_probe() to fix
> this.
> 
> Add a check to usb_dmac_runtime_suspend() to prevent the crash from
> happening in the error path.
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I could not duplicate this issue completely on Lager.
Even if I enabled ealyprintk, I didn't see the panic log.
(Several kernel message appeared, and then the kernel hung.)

Anyway, I tested this patch that kernel could boot correctly even if CONFIG_PREEMPT=y.
So,
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/dma/sh/usb-dmac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index ebd8a5f398b08ee2..f305738b5adf8cc9 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -679,8 +679,11 @@ static int usb_dmac_runtime_suspend(struct device *dev)
>  	struct usb_dmac *dmac = dev_get_drvdata(dev);
>  	int i;
> 
> -	for (i = 0; i < dmac->n_channels; ++i)
> +	for (i = 0; i < dmac->n_channels; ++i) {
> +		if (!dmac->channels[i].iomem)
> +			break;
>  		usb_dmac_chan_halt(&dmac->channels[i]);
> +	}
> 
>  	return 0;
>  }
> @@ -803,7 +806,6 @@ static int usb_dmac_probe(struct platform_device *pdev)
>  	}
> 
>  	ret = usb_dmac_init(dmac);
> -	pm_runtime_put(&pdev->dev);
> 
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to reset device\n");
> @@ -851,10 +853,12 @@ static int usb_dmac_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto error;
> 
> +	pm_runtime_put(&pdev->dev);
>  	return 0;
> 
>  error:
>  	of_dma_controller_free(pdev->dev.of_node);
> +	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
> --
> 1.9.1

