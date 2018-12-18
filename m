From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
Date: Tue, 18 Dec 2018 12:23:49 +0100
Message-ID: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
        <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
        <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018-12-10 22:03, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on TM2e and OdroidXU3. The only minor issue is the following
warning:

WARNING: CPU: 4 PID: 28 at drivers/i2c/i2c-core-base.c:1869
__i2c_transfer+0x428/0x5e0
Modules linked in:
CPU: 4 PID: 28 Comm: cpuhp/4 Tainted: G        W        
4.20.0-rc1-00031-ga1c77790d03f #5130
Hardware name: Samsung TM2E board (DT)
pstate: 20000005 (nzCv daif -PAN -UAO)
pc : __i2c_transfer+0x428/0x5e0
lr : i2c_transfer+0x64/0xb8
...
Call trace:
 __i2c_transfer+0x428/0x5e0
 i2c_transfer+0x64/0xb8
 regmap_i2c_read+0x5c/0xa0
 _regmap_raw_read+0xac/0x2a8
 _regmap_bus_read+0x3c/0x70
 _regmap_read+0x64/0x1a0
 regmap_read+0x48/0x70
 regulator_is_enabled_regmap+0x38/0xb8
 _regulator_is_enabled.part.1+0x1c/0x30
 create_regulator+0x264/0x270
 _regulator_get+0x90/0x2b0
 regulator_get_optional+0x10/0x18
 dev_pm_opp_set_regulators+0xb8/0x1e8
 cpufreq_init+0xd0/0x2f8
 cpufreq_online+0xc0/0x660
 cpuhp_cpufreq_online+0xc/0x18
 cpuhp_invoke_callback+0xac/0x7b0
 cpuhp_thread_fun+0xec/0x180
 smpboot_thread_fn+0x1f0/0x290
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x1c
---[ end trace bea5412bc21deb81 ]---

Similar warning was already there ('HS-I2C is not initialized' message,
without backtrace) during system suspend/resume. It looks that cpu freq
is resumed too early, before any device drivers, but this is not an
issue for this patchset.

> ---
>  drivers/i2c/busses/i2c-exynos5.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index c1ce2299a76e..fe2f2031ea36 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -183,7 +183,6 @@ enum i2c_type_exynos {
>  
>  struct exynos5_i2c {
>  	struct i2c_adapter	adap;
> -	unsigned int		suspended:1;
>  
>  	struct i2c_msg		*msg;
>  	struct completion	msg_complete;
> @@ -715,11 +714,6 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  	struct exynos5_i2c *i2c = adap->algo_data;
>  	int i, ret;
>  
> -	if (i2c->suspended) {
> -		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
> -		return -EIO;
> -	}
> -
>  	ret = clk_enable(i2c->clk);
>  	if (ret)
>  		return ret;
> @@ -847,8 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
>  {
>  	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
>  
> -	i2c->suspended = 1;
> -
> +	i2c_mark_adapter_suspended(&i2c->adap, true);
>  	clk_unprepare(i2c->clk);
>  
>  	return 0;
> @@ -871,7 +864,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
>  
>  	exynos5_i2c_init(i2c);
>  	clk_disable(i2c->clk);
> -	i2c->suspended = 0;
> +	i2c_mark_adapter_suspended(&i2c->adap, false);
>  
>  	return 0;
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
