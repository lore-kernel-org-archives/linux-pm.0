From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 07/10] i2c: sprd: use core helper to mark adapter suspended
Date: Fri, 21 Dec 2018 17:03:09 +0800
Message-ID: <CAMz4kuLv_s6t6n0OfRP8EW3=z8QD0ezn2=45sKg9aXJs5Agrbg@mail.gmail.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com> <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Great to see the I2C core can handle this issue.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index e266d8a713d9..961123529678 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -86,7 +86,6 @@ struct sprd_i2c {
>         u32 count;
>         int irq;
>         int err;
> -       bool is_suspended;
>  };
>
>  static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
> @@ -284,9 +283,6 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
>         struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
>         int im, ret;
>
> -       if (i2c_dev->is_suspended)
> -               return -EBUSY;
> -
>         ret = pm_runtime_get_sync(i2c_dev->dev);
>         if (ret < 0)
>                 return ret;
> @@ -590,10 +586,7 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adap);
>         return pm_runtime_force_suspend(dev);
>  }
>
> @@ -601,10 +594,7 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_resumed(&i2c_dev->adap);
>         return pm_runtime_force_resume(dev);
>  }
>
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
