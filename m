From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
Date: Thu, 11 Oct 2018 12:13:06 +0100
Message-ID: <20181011111306.GB32752@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
> RPMH based targets require that the sleep and wake state request votes
> be sent during system low power mode entry. The votes help reduce the
> power consumption when the AP is not using them. The votes sent by the
> clients are cached in RPMH controller and needs to be flushed when the
> last cpu enters low power mode. So add cpu power domain using Linux
> generic power domain infrastructure to perform necessary tasks as part
> of domain power down.
>

You seem to have either randomly chosen just 3 patches from Lina/Ulf's
CPU genpd series or this series doesn't entirely depend on it ?

If latter, how does this work with PSCI CPU_SUSPEND operations ?

And why this can be part of PSCI firmware implementation. Only PSCI
firmware needs if RPMH votes need to be flushed or not. So, honestly
I don't see the need for this in Linux.

--
Regards,
Sudeep
