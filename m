From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Thu, 11 Oct 2018 10:00:53 -0600
Message-ID: <20181011160053.GA2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011112013.GC32752@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Sudeep,

This is idea is based on GenPD/PM Domains, but solves for the CPU domain
activities that need to be done from Linux when the CPU domain could be
powered off. In that, it shares the same ideas from the series posted by
Ulf. But this has no bearing on PSCI. The 845 SoC that Raju is working
on, uses Platform-coordinated and so is largely deficient in meeting the
power benefits achievable on this SoC, from Linux.

If you have looked at the patches, you probably know by now, there are
two things this patch does when the CPUs are powered off -
- Flush RPMH requests to the controller (shared resource state requests
  after the CPU is powered off and resume to the current state before
  the CPU wakes up).
- Setup the wakeup time for the CPUs in the hardware registers such that
  the hardware blocks are awake before a CPU is powered back on. This is
  like a back-off time for handling timer wakeups faster.

The CPU PD does not power off the domain from Linux. That is done from
PSCI firmware (ATF). These patches are doing the part that Linux has do,
when powering off the CPUs, to achieve a low standby power consumption.

On Thu, Oct 11 2018 at 05:20 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
>> Use cpu hotplug callback mechanism to attach/dettach the cpu in
>> the cpu power domain. During cpu hotplug callback registration,
>> the starting callback is invoked on all online cpus. So there is
>> no need to attach from device probe.
>>
>
>To be more explicit, NACK to this series(patches 4-8 to be more specific)
>unless you provide details on:
>
>1. Why this is not in PSCI implementation ?
This is a linux activity and there is no provision in ATF or QC firmware
to do this activity. The task of physically powering down the domain,
still is a firmware decision and is done through PSCI platform
coordinated in the firmware.

>2. If PSCI is used on this platform, how does it work/co-exist ?
Yes PSCI is used in this platform. ATF is the firmware and that supports
only Platform Coordinated. This SoC uses cpuidle and the regular PSCI
methods to power off the domain from the firmware. However, Linux has
responsibilities that it needs to complete before the power down can be
beneficial.

>3. Is this a shortcut approached taken to bypass the CPU genpd attempts
>   from Lina/Ulf ?
>
This is an incorrect interpretation and an unwarranted accusation. There
is no need to bypass CPU genpd attempts. That series stands on its own
merits. (Thank you, Ulf). Raju has mentioned in the cover letter
explicitly, that Ulf's patches posted here are for completeness of the
concept, as that series is a dependency. But it will merged as part of
Ulf's efforts.

Isn't sharing ideas a key aspect of working with the community? This
series just goes to say that the idea of CPU PM domains are useful,
whether PSCI uses it or not. If you still need clarifications, Raju and
I will be happy to set up a meeting and go over the idea.

Thanks,
Lina
