From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 08/12] pinctrl: samsung: Use generic
 of_device_get_match_data helper
Date: Mon, 16 Jan 2017 21:19:12 +0200
Message-ID: <20170116191912.duvzdsvetgebbvrh@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064527eucas1p1950a217ba6563a443bb44e8e87cc26b1@eucas1p1.samsung.com>
 <1484549107-5957-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484549107-5957-9-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2017 at 07:45:03AM +0100, Marek Szyprowski wrote:
> Replace custom code with generic helper.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 7648a280c0f4..86f23842f681 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -27,6 +27,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>  
> @@ -955,15 +956,13 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static const struct of_device_id samsung_pinctrl_dt_match[];
> -
>  /* retrieve the soc specific data */
>  static const struct samsung_pin_ctrl *
>  samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>  			     struct platform_device *pdev)
>  {
>  	int id;
> -	const struct of_device_id *match;
> +	const struct samsung_pin_ctrl *match_data;
>  	struct device_node *node = pdev->dev.of_node;
>  	struct device_node *np;
>  	const struct samsung_pin_bank_data *bdata;
> @@ -978,8 +977,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
>  		dev_err(&pdev->dev, "failed to get alias id\n");
>  		return ERR_PTR(-ENOENT);
>  	}
> -	match = of_match_node(samsung_pinctrl_dt_match, node);
> -	ctrl = (struct samsung_pin_ctrl *)match->data + id;
> +	match_data = of_device_get_match_data(&pdev->dev);
> +	ctrl = match_data + id;

I did not receive answer for my previous question here - why you need
two samsung_pin_ctrl* variables? Why you need additional match_data?

Just make it:
	ctrl = of_device_get_match_data(&pdev->dev);
	ctrl += id;
To me it looks simpler and obvious. Having two variables for the same
brings questions.

If you do not agree, say it. I don't mind. But I would appreciate if
comments were not ignored.

Best regards,
Krzysztof
