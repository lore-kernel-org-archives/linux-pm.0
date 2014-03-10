From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/8] mmc: mmci: Mask IRQs for all variants during runtime suspend
Date: Mon, 10 Mar 2014 13:46:31 +0100
Message-ID: <CAPDyKFr3fjuZa1mDK-FV5gEBynos5ox7LtKf-kMgiSupPiKpJw@mail.gmail.com>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
	<1393671371-2398-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:41966 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaCJMqc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Mar 2014 08:46:32 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so7443144qcx.24
        for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2014 05:46:31 -0700 (PDT)
In-Reply-To: <1393671371-2398-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 1 March 2014 11:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In runtime suspended state, we are not expecting IRQs and thus we can
> safely mask them, not only for pwrreg_nopower variants but for all.
>
> Obviously we then also need to make sure we restore the IRQ mask while
> becoming runtime resumed.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Russell,

I suppose we have discussed and sorted out the concerns you had around
this patch!?

It's available in your patch tracker, would be nice to get it merged
for 3.15, if that's possible.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c |   23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b931226..178868a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1758,35 +1758,34 @@ static void mmci_save(struct mmci_host *host)
>  {
>         unsigned long flags;
>
> -       if (host->variant->pwrreg_nopower) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
>
> -               writel(0, host->base + MMCIMASK0);
> +       writel(0, host->base + MMCIMASK0);
> +       if (host->variant->pwrreg_nopower) {
>                 writel(0, host->base + MMCIDATACTRL);
>                 writel(0, host->base + MMCIPOWER);
>                 writel(0, host->base + MMCICLOCK);
> -               mmci_reg_delay(host);
> -
> -               spin_unlock_irqrestore(&host->lock, flags);
>         }
> +       mmci_reg_delay(host);
>
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static void mmci_restore(struct mmci_host *host)
>  {
>         unsigned long flags;
>
> -       if (host->variant->pwrreg_nopower) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
>
> +       if (host->variant->pwrreg_nopower) {
>                 writel(host->clk_reg, host->base + MMCICLOCK);
>                 writel(host->datactrl_reg, host->base + MMCIDATACTRL);
>                 writel(host->pwr_reg, host->base + MMCIPOWER);
> -               writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> -               mmci_reg_delay(host);
> -
> -               spin_unlock_irqrestore(&host->lock, flags);
>         }
> +       writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> +       mmci_reg_delay(host);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static int mmci_runtime_suspend(struct device *dev)
> --
> 1.7.9.5
>
