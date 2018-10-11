From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
Date: Thu, 11 Oct 2018 17:27:59 +0200
Message-ID: <CAPDyKFpXJ4MbqFOmDboBuR_1sziyuDi3qgKVvhokaAnQQ+kzjA@mail.gmail.com>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org> <20181011111306.GB32752@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011111306.GB32752@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, mka@chromium.org, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 11 October 2018 at 13:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
>> RPMH based targets require that the sleep and wake state request votes
>> be sent during system low power mode entry. The votes help reduce the
>> power consumption when the AP is not using them. The votes sent by the
>> clients are cached in RPMH controller and needs to be flushed when the
>> last cpu enters low power mode. So add cpu power domain using Linux
>> generic power domain infrastructure to perform necessary tasks as part
>> of domain power down.
>>
>
> You seem to have either randomly chosen just 3 patches from Lina/Ulf's
> CPU genpd series or this series doesn't entirely depend on it ?

Yep, it not easy to follow. But I do understand what you are trying to do here.

>
> If latter, how does this work with PSCI CPU_SUSPEND operations ?
>
> And why this can be part of PSCI firmware implementation. Only PSCI
> firmware needs if RPMH votes need to be flushed or not. So, honestly
> I don't see the need for this in Linux.

I do think there is clear need for this in Linux. More precisely,
since the PSCI firmware have knowledge solely about CPUs (and clusters
of CPUs), but not about other shared resources/devices present on the
SoC.

What Raju is trying to do here, is to manage those resources which
needs special treatment, before and after the CPU (likely cluster) is
going idle and returns from idle.

One question here though, what particular idle state is relevant for
the QCOM SoC to take last-man-actions for? I assume it's only cluster
idle states, and not about cpu idle states, no? Raju, can you please
clarify?

Historically, the typical solution have been to use the
cpu_cluster_pm_enter|exit() notifiers. Those could potentially be
replaced by instead building a hierarchical topology, using
master/subdomain of genpd/"power-domains", along the lines of what
Raju is doing. However, I am not sure if that is the correct approach,
at least we need to make sure it models the HW in DT correctly.

Kind regards
Uffe
