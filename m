From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Date: Thu, 5 Jul 2018 14:37:12 -0600
Message-ID: <20180705203712.GA29531@rob-hp-laptop>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
 <20180703162619.GA17238@rob-hp-laptop>
 <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 04, 2018 at 10:56:26PM +0530, Amit Kucheria wrote:
> On Tue, Jul 3, 2018 at 9:56 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
> >> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> >> appears to be identical across v2.x.y in code seen so far. We use the
> >> generic get_temp() function.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
> >>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
> >>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
> >>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
> >>  4 files changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> index 06195e8..075182e 100644
> >> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> @@ -5,6 +5,8 @@ Required properties:
> >>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> >>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> >>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> >> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> >> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
> >
> > You need to show what are valid combinations of compatibles. Does v2
> > apply to 8996? One valid combination per line.
> 
> I've restructured qcom-tsens.txt to look like this:
> 
> -----%<-------
> 
> * QCOM SoC Temperature Sensor (TSENS)
> 
> Required properties:
> - compatible: must be one of the following:
>     - "qcom,msm8916-tsens" (MSM8916)
>     - "qcom,msm8974-tsens" (MSM8974)
>     - "qcom,msm8996-tsens" (MSM8996)
>     - "qcom,tsens-<ip_version>", "qcom,tsens-v2" (TSENS IP version and a
>        generic v2 property as fallback except for MSM8996)
> 
>   Examples with ip_version are:
>     - "qcom,tsens-v2.4.0", "qcom,tsens-v2" (SDM845)
>     - "qcom,tsens-v2.2.1", "qcom,tsens-v2" (MSM8998)
> 
> -----%<-------
> 
> 8996 would end up being something like this if needed, though we're
> stuck with "qcom,msm8996-tsens":
> "qcom,msm8996-tsens", "qcom,tsens-v2.1.0", "qcom,tsens-v2" (MSM8996)

3 versions here for 3 SoCs. I'm not getting that convinced version 
numbers really are better. I would assume that other QCom IP blocks 
have versions too, but pretty much *every* *other* binding uses SoC names. 
Why is this one special? The other problem with versions is the mapping 
of versions to SoCs most likely can't be validated outside of QCom 
unless there's a version register.

So, sorry to go in circles, but can you go back to qcom,<soc>-tsens. You 
can keep qcom,tsens-v2 as a fallback.

Yes, it's annoying to have to update bindings for new SoCs. But it's 
trivial one line patches. Look at Renesas bindings. Maybe adding new 
ones will be scriptable once we move to json-schema binding docs.

Rob
