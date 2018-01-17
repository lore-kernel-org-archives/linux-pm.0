From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 3/9] mmc: sdhci: Stop exporting sdhci_enable_irq_wakeups()
Date: Wed, 17 Jan 2018 12:48:30 +0100
Message-ID: <CAPDyKFpFRLEkDZfbsPeWNfMWzb73u8oXVmkAgShXs7UjFxMpJw@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <1515484346-800-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:41940 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeAQLsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 06:48:31 -0500
Received: by mail-io0-f194.google.com with SMTP id f6so20547476ioh.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2018 03:48:31 -0800 (PST)
In-Reply-To: <1515484346-800-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

On 9 January 2018 at 08:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Now that it is not being used by any drivers, stop exporting it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 +--
>  drivers/mmc/host/sdhci.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..8b2ccf7795ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2821,7 +2821,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>   * sdhci_disable_irq_wakeups() since it will be set by
>   * sdhci_enable_card_detection() or sdhci_init().
>   */
> -void sdhci_enable_irq_wakeups(struct sdhci_host *host)
> +static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
>  {
>         u8 val;
>         u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> @@ -2839,7 +2839,6 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
>         sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
>         sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
>  }
> -EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
>
>  static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 54bc444c317f..7393b3a54772 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -718,7 +718,6 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  #ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
> -void sdhci_enable_irq_wakeups(struct sdhci_host *host);
>  int sdhci_runtime_suspend_host(struct sdhci_host *host);
>  int sdhci_runtime_resume_host(struct sdhci_host *host);
>  #endif
> --
> 1.9.1
>
