From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Thu, 11 Oct 2018 12:20:13 +0100
Message-ID: <20181011112013.GC32752@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
> Use cpu hotplug callback mechanism to attach/dettach the cpu in
> the cpu power domain. During cpu hotplug callback registration,
> the starting callback is invoked on all online cpus. So there is
> no need to attach from device probe.
>

To be more explicit, NACK to this series(patches 4-8 to be more specific)
unless you provide details on:

1. Why this is not in PSCI implementation ?
2. If PSCI is used on this platform, how does it work/co-exist ?
3. Is this a shortcut approached taken to bypass the CPU genpd attempts
   from Lina/Ulf ?

--
Regards,
Sudeep
