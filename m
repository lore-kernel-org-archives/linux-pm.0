From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Wed, 31 Oct 2018 16:57:17 -0700
Message-ID: <CAD=FV=WeRRMDyjgMemtrVN88TODtk_kjTW-NZOV4hDGgSO9HVQ@mail.gmail.com>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 10:23 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Add device bindings for cpuidle states for cpu devices.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2
>  - Address comments from Doug
> ---
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

I haven't been following all the discussion about idle states closely
enough to know if the contents of this patch is correct.  Thus I won't
provide my Reviewed-by since I expect Evan and/or Lina will provide
theirs again like they did on v1.  However, I'll mention that the nits
I had regarding v1 have been fixed so I'm happy with this patch
landing if others are.  ;-)

-Doug
