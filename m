From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/9] PM / ACPI: Split code validating need for runtime
 resume in ->prepare()
Date: Wed, 21 Jun 2017 23:35:14 +0200
Message-ID: <CAJZ5v0j3oLUmg-8fW4372yE-uy0kM28E06jFQCPp14xb66aY+A@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org> <1498072888-14782-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Move the code dealing with validation of whether runtime resuming the
> device is needed during system suspend.
>
> In this way it becomes more clear for what circumstances ACPI is prevented
> from trying the direct_complete path.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/acpi/device_pm.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d38acbc..ee51e75 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -933,6 +933,27 @@ int acpi_dev_resume_early(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
>
> +static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
> +{
> +       u32 sys_target = acpi_target_system_state();
> +       int ret, state;
> +
> +       if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
> +               return true;
> +
> +       if (sys_target == ACPI_STATE_S0)
> +               return false;
> +
> +       if (adev->power.flags.dsw_present)
> +               return true;
> +
> +       ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
> +       if (ret)
> +               return true;
> +
> +       return !(state == adev->power.state);

Nit: I would write this as

  return state != adev->power.state;

Thanks,
Rafael
