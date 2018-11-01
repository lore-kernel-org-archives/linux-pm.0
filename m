From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Thu, 1 Nov 2018 10:21:27 -0700
Message-ID: <CAE=gft59UWM4=WhLkcLR3+FCEeD5OVwaJjZ8w_t=Fgtt=vFFpA@mail.gmail.com>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rplsssn@codeaurora.org
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, Doug Anderson <dianders@chromium.org>, mka@chromium.org, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

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
>

Reviewed-by: Evan Green <evgreen@chromium.org>
