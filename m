From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Tue, 29 Aug 2017 13:20:27 -0700
Message-ID: <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org

Hi Nikolaus, thanks for the patch...

On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Tested on Pyra prototype with bq27421.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index b6c3120ca5ad..e3c878ef7c7e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>  #define bq27545_dm_regs 0
>  #endif
>
> -#if 0 /* not yet tested */
> +#if 1 /* tested on Pyra */
>  static struct bq27xxx_dm_reg bq27421_dm_regs[] = {

I think we can drop the #if and #else...#endif so it's just the
dm_regs table, as with bq27425.
