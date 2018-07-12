From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Date: Thu, 12 Jul 2018 10:15:45 -0700
Message-ID: <CAD=FV=V42W417=WD9Xh4naf3fMd_sZvG6=DtKqCTSsofZFSckQ@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
>
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
