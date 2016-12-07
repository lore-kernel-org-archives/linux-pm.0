From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Revert "PM / OPP: Don't assume platform doesn't have regulators"
Date: Thu, 8 Dec 2016 00:29:15 +0100
Message-ID: <CAJZ5v0gVxoCD4E7cHec9iFJb8_9G4USyMDJ9mrBNvFB_Pf=uzw@mail.gmail.com>
References: <1560e022c1584376cf5a55ed048e0b60485adf2b.1481106666.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560e022c1584376cf5a55ed048e0b60485adf2b.1481106666.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, swarren@nvidia.com, Thierry Reding <treding@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 7, 2016 at 11:31 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This reverts commit ef3caabee9691386e6801ea92150e37277db9c7a.
>
> The commit was based on the assumption that a platform with voltages
> specified with individual OPPs, would have registered a regulator as
> well in order to do full DVFS.
>
> That assumption is broken by the Tegra124 platform.
>
> For Tegra124, the voltage is not scaled via a direct call to the
> regulator subsystem because the DFLL directly controls the I2C interface
> that controls the voltage. The DFLL essentially figures out the max
> frequency for a given voltage. So to run at a particular frequency, the
> DFLL continuously adjusts the voltage in a control loop fashion to get
> the desired frequency.
>
> Following are the logs from: NVIDIA Tegra124 Jetson TK1
>
>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 696000 KHz
>   cpu cpu0: dev_pm_opp_set_rate: Regulator not registered with OPP core
>   cpufreq: __target_index: Failed to change cpu frequency: -22
>   ------------[ cut here ]------------
>   kernel BUG at drivers/cpufreq/cpufreq.c:1235!
>
> Fix these by reverting the offending commit.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> Rafael, you can simply drop the patch if that is easier for you.

Done.

Thanks,
Rafael
