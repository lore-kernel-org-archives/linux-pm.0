From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 09/12] pinctrl: samsung: Add infrastructure for pin-bank
 retention control
Date: Mon, 16 Jan 2017 21:37:00 +0200
Message-ID: <20170116193700.23ouybo6dhkhrs25@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064527eucas1p1f0f78e9420e7d9d60d94b6e7381caeb1@eucas1p1.samsung.com>
 <1484549107-5957-10-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484549107-5957-10-git-send-email-m.szyprowski@samsung.com>
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

On Mon, Jan 16, 2017 at 07:45:04AM +0100, Marek Szyprowski wrote:
> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
> 
> This patch adds infrastructure to handle pad retention during pin control
> driver resume.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 12 ++++++---
>  drivers/pinctrl/samsung/pinctrl-samsung.h | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 86f23842f681..95a84086a2e9 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1075,6 +1075,9 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  		ctrl->eint_gpio_init(drvdata);
>  	if (ctrl->eint_wkup_init)
>  		ctrl->eint_wkup_init(drvdata);
> +	if (ctrl->retention_data && ctrl->retention_data->init)
> +		drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
> +							  ctrl->retention_data);
>  
>  	platform_set_drvdata(pdev, drvdata);
>  
> @@ -1127,15 +1130,15 @@ static void samsung_pinctrl_suspend_dev(
>  
>  	if (drvdata->suspend)
>  		drvdata->suspend(drvdata);
> +	if (drvdata->retention_ctrl && drvdata->retention_ctrl->on)
> +		drvdata->retention_ctrl->on(drvdata);
> +

This new line is not needed (checkpatch might complain... either in
normal mode or in strict). Beside that, thanks for splitting the
patch for interface from the implementation:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
