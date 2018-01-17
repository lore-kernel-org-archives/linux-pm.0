From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 2/9] mmc: sdhci-pci: Use device wakeup capability
 to determine MMC_PM_WAKE_SDIO_IRQ capability
Date: Wed, 17 Jan 2018 12:48:24 +0100
Message-ID: <CAPDyKFo=_dB4ezcJKkTx0gOiL86tWOL9V9aqqSOjg_ZQ6uBhKg@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <1515484346-800-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1515484346-800-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-pm@vger.kernel.org

On 9 January 2018 at 08:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
> PCI and ACPI determine if a device is wakeup capable, so use that to
> determine the MMC_PM_WAKE_SDIO_IRQ capability correctly.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1711b1815630..baedb2624e36 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -50,9 +50,9 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>                         pm_flags |= slot->host->mmc->pm_flags;
>         }
>
> -       return device_init_wakeup(&chip->pdev->dev,
> -                                 (pm_flags & MMC_PM_KEEP_POWER) &&
> -                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
> +       return device_set_wakeup_enable(&chip->pdev->dev,
> +                                       (pm_flags & MMC_PM_KEEP_POWER) &&
> +                                       (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
>  }
>
>  static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> @@ -1680,10 +1680,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>                 }
>         }
>
> -       host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
> +       host->mmc->pm_caps = MMC_PM_KEEP_POWER;
>         host->mmc->slotno = slotno;
>         host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
>
> +       if (device_can_wakeup(&pdev->dev))
> +               host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +
>         if (slot->cd_idx >= 0) {
>                 ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
>                                            slot->cd_override_level, 0, NULL);
> --
> 1.9.1
>
