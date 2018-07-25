From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/4] power: supply: max17040: Send uevent in SOC changes
Date: Wed, 25 Jul 2018 12:52:03 +0200
Message-ID: <CAJKOXPcyPgtifVVT8VJQ3smcGzXxeVSoUdUyCV1ZsD5PbjnnQg@mail.gmail.com>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-5-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-5-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23 July 2018 at 06:08, Matheus Castello <matheus@castello.eng.br> wrote:
> Add check for changes in state of charge from delayed work, so
> in case of changes we call power_supply_changed to send an uevent.
>
> power_supply_changed send an uevent for alert user space about
> changes, is useful for example to user space apps made changes in
> UI battery level or made other decisions.

Hi,

Too many "changes". How about:

Notify core through power_supply_changed() in case of changes in state
of charge. This is useful for user-space to efficiently update current
battery level.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 3efa52d32b44..72915ac9e13b 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -202,14 +202,22 @@ static void max17040_get_of_data(struct max17040_chip *chip)
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> +       u16 last_soc;
>
>         chip = container_of(work, struct max17040_chip, work.work);
>
> +       /* store SOC for check change */
> +       last_soc = chip->soc;
> +
>         max17040_get_vcell(chip->client);
>         max17040_get_soc(chip->client);
>         max17040_get_online(chip->client);
>         max17040_get_status(chip->client);
>
> +       /* check changes and send uevent */
> +       if (last_soc != chip->soc)
> +               power_supply_changed(chip->battery);
> +
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
>  }
> --
> 2.13.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
