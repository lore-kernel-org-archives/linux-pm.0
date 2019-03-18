From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] power: supply: axp288_charger: Fix unchecked return value
Date: Mon, 18 Mar 2019 18:32:35 +0100
Message-ID: <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
References: <20190318161439.GA6245@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318161439.GA6245@embeddedor>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 18-03-19 17:14, Gustavo A. R. Silva wrote:
> Currently there is no check on platform_get_irq() return value
> in case it fails, hence never actually reporting any errors and
> causing unexpected behavior when using such value as argument
> for function regmap_irq_get_virq().
> 
> Fix this by adding a proper check, a message reporting any errors
> and returning *pirq*
> 
> Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
> Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/power/supply/axp288_charger.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index f8c6da9277b3..00b961890a38 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -833,6 +833,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
>   	/* Register charger interrupts */
>   	for (i = 0; i < CHRG_INTR_END; i++) {
>   		pirq = platform_get_irq(info->pdev, i);
> +		if (pirq < 0) {
> +			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> +			return pirq;
> +		}
>   		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
>   		if (info->irq[i] < 0) {
>   			dev_warn(&info->pdev->dev,
> 

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
