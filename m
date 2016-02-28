From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH] power_supply: lp8788-charger: initialize boolean 'found'
Date: Mon, 29 Feb 2016 08:22:28 +0900
Message-ID: <56D38134.7030101@ti.com>
References: <1456577651-5644-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456577651-5644-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2/27/2016 9:54 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The boolean 'found' is not initialized and hence garbage. It should
> be initialized as false.
>
> Found with static analysis using CoverityScan
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Milo Kim <milo.kim@ti.com>

Thanks for catching this.

> ---
>   drivers/power/lp8788-charger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/lp8788-charger.c b/drivers/power/lp8788-charger.c
> index f5a48fd..7321b72 100644
> --- a/drivers/power/lp8788-charger.c
> +++ b/drivers/power/lp8788-charger.c
> @@ -455,7 +455,7 @@ static void lp8788_charger_event(struct work_struct *work)
>
>   static bool lp8788_find_irq_id(struct lp8788_charger *pchg, int virq, int *id)
>   {
> -	bool found;
> +	bool found = false;
>   	int i;
>
>   	for (i = 0; i < pchg->num_irqs; i++) {
>
