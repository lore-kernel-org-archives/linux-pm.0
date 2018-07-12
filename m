From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 6/7] thermal: tsens: Add generic support for TSENS v2 IP
Date: Thu, 12 Jul 2018 10:16:46 -0700
Message-ID: <CAD=FV=WRvqE5rwwFMPdtFTnSn+zVY6H84eR=En4gfQye-JW=wQ@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <34de426540a878bf77a77dd2c42a16678d6545a7.1531384019.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34de426540a878bf77a77dd2c42a16678d6545a7.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses v2 of the TSENS IP block but the get_temp() function appears to
> be identical across v2.x.y in code seen so far. We use the generic
> get_temp() function defined as part of ops_generic_v2.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 5 +++++
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
