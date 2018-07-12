From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
Date: Thu, 12 Jul 2018 10:19:00 -0700
Message-ID: <CAD=FV=WkF5VHEekxc0WTPbNvYikwgiZg684QQ7mLWmqSN12tgA@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
>
> We rename get_temp() to reflect that it can be used across the v2 family.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 25 ++++++++---------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
