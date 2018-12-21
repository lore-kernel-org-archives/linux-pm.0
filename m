From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 06/10] i2c: sprd: don't use pdev as variable name for
 struct device *
Date: Fri, 21 Dec 2018 16:58:11 +0800
Message-ID: <CAMz4kuKSepzktF+ZUVsrxD-pAgRDiGUC_f0oLL2CTyBMz3tfoQ@mail.gmail.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com> <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The pointer to a device is usually named 'dev'. These 'pdev' here look
> much like copy&paste errors. Fix them to avoid confusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for fixing the copy&paste errors.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index a94e724f51dc..e266d8a713d9 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -586,40 +586,40 @@ static int sprd_i2c_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = true;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_suspend(pdev);
> +       return pm_runtime_force_suspend(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = false;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_resume(pdev);
> +       return pm_runtime_force_resume(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_suspend(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_suspend(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         clk_disable_unprepare(i2c_dev->clk);
>
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_resume(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>         int ret;
>
>         ret = clk_prepare_enable(i2c_dev->clk);
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
