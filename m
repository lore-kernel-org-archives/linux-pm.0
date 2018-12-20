From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Thu, 20 Dec 2018 13:40:44 -0800
Message-ID: <CAD=FV=XWftL_aFb7rNPMW1AE+1y+Zh3W+qqtfSKHRPN+Qe_w2A@mail.gmail.com>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org> <20181130154145.GK18262@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130154145.GK18262@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Nov 30, 2018 at 7:41 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Oct 30 2018 at 11:23 -0600, Raju P.L.S.S.S.N wrote:
> >Add device bindings for cpuidle states for cpu devices.
> >
> >Cc: <devicetree@vger.kernel.org>
> >Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> >---
> >Changes in v2
> > - Address comments from Doug
> >---
> >---
> > arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 62 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >index 0c9a2aa..3a8381e 100644
> >--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >@@ -96,6 +96,7 @@
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >+                      cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> I think it might be better to use
> <&C0_CPU_PD>, <&C0_CPU_RPD>, <&CLUSTER_PD>

I disagree.  All existing examples in both bindings and other device
trees use the syntax that Raju uses.  It doesn't matter
functionality-wise, but I'd much rather match everyone else.  We
should land what Raju has posted and if someone feels super strongly
that the examples in the bindings are wrong then they should attempt
to convince Rob Herring to Ack a change to the examples in the
bindings.  Doesn't seem like a good use of time to me, though.

-Doug
