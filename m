From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2 IP
Date: Wed, 11 Jul 2018 11:40:42 -0700
Message-ID: <CAD=FV=WFEubDtHkL7-8DF6nPuRL4HBHOghc3YekazXUnS6vrBA@mail.gmail.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses v2 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function defined as part of ops_generic_v2.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 6 +++++-
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 34ba6c7..f40150f 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
>         .get_temp       = get_temp_tsens_v2,
>  };
>
> +const struct tsens_data data_tsens_v2 = {
> +       .ops            = &ops_generic_v2,
> +};
> +
> +/* Kept around for backward compatibility with old msm8996.dtsi */
>  const struct tsens_data data_8996 = {
>         .num_sensors    = 13,
>         .ops            = &ops_generic_v2,
>  };

Something seems fishy here.  You have a ".num_sensors" for sdm8996
hardcoded to 13 but you don't have a ".num_sensors" for your new v2.
Where does num_sensors get set for everyone else?  In patch #3 you
have a new "#qcom,sensors" but:

1. Nothing reads this as far as I can tell, so that means everyone
will end up with 0 sensors.

2. On your 2nd block of sensors in the sdm8996 device tree (see
earlier patch in the series) you try to set qcom,sensors to 8.  ...but
since you still have a compatible of "qcom,msm8996-tsens" you'll get
13.  That seems wrong.  ...or did I miss something?
