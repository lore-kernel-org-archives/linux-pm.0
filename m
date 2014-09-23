From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq
 re-enable on resume
Date: Tue, 23 Sep 2014 19:26:31 +0200
Message-ID: <CAPDyKFrGiEJqHe2+SSNpUhBKfhGraqfomskUbemFmucszv8ukw@mail.gmail.com>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-fbdev@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23 September 2014 14:21, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> When the PM domain containing the HDMI hardware block is powered down,
> the HDMI register values (incl. interrupt polarity settings) are lost.
> During resume, after powering up the PM domain, interrupts are
> re-enabled, and an interrupt storm happens due to incorrect interrupt
> polarity settings:
>
>     irq 163: nobody cared (try booting with the "irqpoll" option)
>     ...
>     Disabling IRQ #163
>
> To fix this, re-initialize the interrupt polarity settings, and the
> htop1 register block (if present), during resume.
>
> As the .suspend_noirq() and .resume_noirq() callbacks are not called
> when using the generic PM domain, the normal .resume() callback is used,
> and the device interrupt needs to be disabled/enabled manually.
>
> This fixes resume from s2ram with power down of the A4MP PM domain on
> r8a7740/Armadillo.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is there a specific reason why the .suspend_noirq() and .resume_noirq()
> callbacks are not called when using genpd, unlike .suspend(),
> .suspend_late(), .resume_early(), and .resume()?

Hi Geert,

Interesting issue you are trying to fix here.

In principle I consider the *noirq() callbacks in genpd as workarounds
to handle the corner cases we had when using runtime PM and system PM
together. This is at least how the OMAP PM domain uses them.

Today, there are a better option which is to use
pm_runtime_force_suspend|resume() and to declare the runtime PM
callbacks within CONFIG_PM instead of CONFIG_PM_RUNTIME. I am actually
working on a patchset that tries this approach, do you think that
could solve your issue?

That said, I also think it's a bug in genpd to not invoke
pm_generic_suspend|resume_noirq() from its corresponding callbacks. I
think we should add them, but let's see if its trivial to do that. :-)

Kind regards
Uffe

> ---
>  drivers/video/fbdev/sh_mobile_hdmi.c | 44 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/sh_mobile_hdmi.c b/drivers/video/fbdev/sh_mobile_hdmi.c
> index 9a33ee0413fb584d..7c72a3f02056445d 100644
> --- a/drivers/video/fbdev/sh_mobile_hdmi.c
> +++ b/drivers/video/fbdev/sh_mobile_hdmi.c
> @@ -281,6 +281,7 @@ struct sh_hdmi {
>         u8 edid_block_addr;
>         u8 edid_segment_nr;
>         u8 edid_blocks;
> +       int irq;
>         struct clk *hdmi_clk;
>         struct device *dev;
>         struct delayed_work edid_work;
> @@ -1299,6 +1300,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
>         hdmi->dev = &pdev->dev;
>         hdmi->entity.owner = THIS_MODULE;
>         hdmi->entity.ops = &sh_hdmi_ops;
> +       hdmi->irq = irq;
>
>         hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
>         if (IS_ERR(hdmi->hdmi_clk)) {
> @@ -1415,12 +1417,11 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
>  {
>         struct sh_hdmi *hdmi = entity_to_sh_hdmi(platform_get_drvdata(pdev));
>         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       int irq = platform_get_irq(pdev, 0);
>
>         snd_soc_unregister_codec(&pdev->dev);
>
>         /* No new work will be scheduled, wait for running ISR */
> -       free_irq(irq, hdmi);
> +       free_irq(hdmi->irq, hdmi);
>         /* Wait for already scheduled work */
>         cancel_delayed_work_sync(&hdmi->edid_work);
>         pm_runtime_put(&pdev->dev);
> @@ -1435,10 +1436,49 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int sh_hdmi_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sh_hdmi *hdmi = entity_to_sh_hdmi(platform_get_drvdata(pdev));
> +
> +       disable_irq(hdmi->irq);
> +       /* Wait for already scheduled work */
> +       cancel_delayed_work_sync(&hdmi->edid_work);
> +       return 0;
> +}
> +
> +static int sh_hdmi_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sh_mobile_hdmi_info *pdata = dev_get_platdata(dev);
> +       struct sh_hdmi *hdmi = entity_to_sh_hdmi(platform_get_drvdata(pdev));
> +
> +       /* Re-init interrupt polarity */
> +       if (pdata->flags & HDMI_OUTPUT_PUSH_PULL)
> +               hdmi_bit_set(hdmi, 0x02, 0x02, HDMI_SYSTEM_CTRL);
> +
> +       if (pdata->flags & HDMI_OUTPUT_POLARITY_HI)
> +               hdmi_bit_set(hdmi, 0x01, 0x01, HDMI_SYSTEM_CTRL);
> +
> +       /* Re-init htop1 */
> +       if (hdmi->htop1)
> +               sh_hdmi_htop1_init(hdmi);
> +
> +       /* Now it's safe to enable interrupts again */
> +       enable_irq(hdmi->irq);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops sh_hdmi_pm_ops = {
> +       .suspend        = sh_hdmi_suspend,
> +       .resume         = sh_hdmi_resume,
> +};
> +
>  static struct platform_driver sh_hdmi_driver = {
>         .remove         = __exit_p(sh_hdmi_remove),
>         .driver = {
>                 .name   = "sh-mobile-hdmi",
> +               .pm     = &sh_hdmi_pm_ops,
>         },
>  };
>
> --
> 1.9.1
>
