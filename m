From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 2/7] thermal: tsens: Add support to split up register
 address space into two
Date: Thu, 12 Jul 2018 10:12:59 -0700
Message-ID: <CAD=FV=Xk9uxo2CLBnnji4+hv14jBpkhAYVFtduK8+6dwJyrjpQ@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> SoCs these were contiguous, leading to DTs mapping them as one register
> address space of size 0x2000. In newer SoCs, these two banks are not
> contiguous anymore.
>
> Add logic to init_common() to differentiate between old and new DTs and
> adjust associated offsets for the TM register bank so that the old DTs will
> continue to function correctly.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-8996.c   |  4 ++--
>  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
>  drivers/thermal/qcom/tsens.h        |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
