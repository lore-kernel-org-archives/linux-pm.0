From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [RFC/RFT 04/10] i2c: brcmstb: use core helper to mark adapter suspended
Date: Tue, 11 Dec 2018 11:44:01 -0500
Message-ID: <CAC=U0a2cvdhAdBPyowR3i=wpnONDHjBWMZ56D_pJYfhYL=DTbg@mail.gmail.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com> <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, hdegoede@redhat.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 4:03 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 826d32049996..05c822e5a3f6 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
>         struct bsc_regs *bsc_regmap;
>         struct i2c_adapter adapter;
>         struct completion done;
> -       bool is_suspended;
>         u32 clk_freq_hz;
>         int data_regsz;
>  };
> @@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>         int xfersz = brcmstb_i2c_get_xfersz(dev);
>         u32 cond, cond_per_msg;
>
> -       if (dev->is_suspended)
> -               return -EBUSY;
> -
>         /* Loop through all messages */
>         for (i = 0; i < num; i++) {
>                 pmsg = &msgs[i];
> @@ -689,10 +685,7 @@ static int brcmstb_i2c_suspend(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, true);
>         return 0;
>  }
>
> @@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
>         brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, false);
>
>         return 0;
>  }
> --
> 2.11.0
>
