From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH 6/8] thermal: mediatek: mt8183: fix bank number settings
Date: Tue, 7 May 2019 16:58:40 +0800
Message-ID: <CAJMQK-i6oZ1dTbTXV2_nX+mGfZ7JcafRMKbb81YgPk67Gdbjbg@mail.gmail.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-7-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556793795-25204-7-git-send-email-michael.kao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "michael.kao" <michael.kao@mediatek.com>
Cc: fan.chen@mediatek.com, jamesjj.liao@mediatek.com, dawei.chien@mediatek.com, louis.yu@mediatek.com, roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Michael Kao <michael.kao@mediatek.com>
>
> MT8183_NUM_ZONES should be set to 1
> because MT8183 doesn't have multiple banks.
>
> Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
> Signed-off-by: Michael Kao <Michael.Kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 5c07a61..cb41e46 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -216,6 +216,9 @@ enum {
>  /* The total number of temperature sensors in the MT8183 */
>  #define MT8183_NUM_SENSORS     6
>
> +/* The number of banks in the MT8183 */
> +#define MT8183_NUM_ZONES               1
> +
>  /* The number of sensing points per bank */
>  #define MT8183_NUM_SENSORS_PER_ZONE     6
>
> @@ -503,7 +506,7 @@ struct mtk_thermal {
>
>  static const struct mtk_thermal_data mt8183_thermal_data = {
>         .auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
> -       .num_banks = MT8183_NUM_SENSORS_PER_ZONE,
> +       .num_banks = MT8183_NUM_ZONES,
>         .num_sensors = MT8183_NUM_SENSORS,
>         .vts_index = mt8183_vts_index,
>         .cali_val = MT8183_CALIBRATION,

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
