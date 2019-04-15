From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/4] power: supply: max17040: Send uevent in SOC changes
Date: Mon, 15 Apr 2019 09:30:58 +0200
Message-ID: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-5-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415012635.6369-5-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Apr 2019 at 03:48, Matheus Castello <matheus@castello.eng.br> wrote:
>
> Notify core through power_supply_changed() in case of changes in state
> of charge. This is useful for user-space to efficiently update current
> battery level.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index f036f272d52f..db901ebf495d 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -208,10 +208,17 @@ static void max17040_check_changes(struct i2c_client *client)
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> +       int last_soc;
>
>         chip = container_of(work, struct max17040_chip, work.work);
> +       /* store SOC for check change */
> +       last_soc = chip->soc;
>         max17040_check_changes(chip->client);
>
> +       /* check changes and send uevent */
> +       if (last_soc != chip->soc)

chip->soc could be negative ERRNO so in such case I think user-space
should not be notified.

> +               power_supply_changed(chip->battery);
> +

You should also notify on online and status change (e.g. started
charging). User-space also wants to know that, e.g. to show the
charging icon or battery health status.

Best regards,
Krzysztof
