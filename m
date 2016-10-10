From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/8] PM / OPP: Multiple regulator support
Date: Mon, 10 Oct 2016 14:20:54 -0500
Message-ID: <57FBEA16.2010502@ti.com>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475581665.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On 10/04/2016 06:56 AM, Viresh Kumar wrote:
> Hi,
>
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
>
> Some thoughts went into it few months back but then it all got lost. I
> am trying to get that back on track with this thread.
>
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the ordering in which
> multiple supplies need to be programmed, before or after frequency
> change. It was considered in this patch and such information is left to
> the platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
>
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
>
> Though more testing on real (TI) platforms would be useful.

Cool, I'm reviewing these patches still but I definitely plan to test 
them out on the TI platforms requiring multi-regulator support. At first 
glance it looks like it does give us the hooks we need. I believe we can 
use cpufreq-dt as is and just provide the regulators before it probes.

Regards,
Dave

>
> This is rebased over: pm-4.9-rc1 tag in the PM tree.
>
> --
> viresh
>
> [1] https://marc.info/?l=linux-pm&m=145684495832764&w=2
>
> Viresh Kumar (8):
>    PM / OPP: Reword binding supporting multiple regulators per device
>    PM / OPP: Don't use OPP structure outside of rcu protected section
>    PM / OPP: Manage supply's voltage/current in a separate structure
>    PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
>    PM / OPP: Add infrastructure to manage multiple regulators
>    PM / OPP: Separate out _generic_opp_set_rate()
>    PM / OPP: Allow platform specific custom opp_set_rate() callbacks
>    PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
>
>   Documentation/devicetree/bindings/opp/opp.txt |  25 +-
>   drivers/base/power/opp/core.c                 | 501 ++++++++++++++++++++------
>   drivers/base/power/opp/debugfs.c              |  48 ++-
>   drivers/base/power/opp/of.c                   | 104 ++++--
>   drivers/base/power/opp/opp.h                  |  36 +-
>   drivers/cpufreq/cpufreq-dt.c                  |   9 +-
>   include/linux/pm_opp.h                        |  33 +-
>   7 files changed, 574 insertions(+), 182 deletions(-)
>
