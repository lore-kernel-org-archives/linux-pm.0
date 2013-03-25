From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
Date: Mon, 25 Mar 2013 10:49:05 +0530
Message-ID: <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Sascha Hauer <kernel@pengutronix.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.>
List-Id: linux-pm@vger.kernel.org

On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> policy->cpus contains all online cpus that have single shared clock line. And
> their frequencies are always updated together.
>
> Many SMP system's cpufreq drivers take care of this in individual drivers but
> the best place for this code is in cpufreq core.
>
> This patch modifies cpufreq_notify_transition() to notify frequency change for
> all cpus in policy->cpus and hence updates all users of this API.

Another fixup for tegra:

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 3b441d6..11ca730 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -106,7 +106,8 @@ out:
        return ret;
 }

-static int tegra_update_cpu_speed(unsigned long rate)
+static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
+               unsigned long rate)
 {
        int ret = 0;
        struct cpufreq_freqs freqs;
@@ -179,7 +180,7 @@ static int tegra_target(struct cpufreq_policy *policy,

        target_cpu_speed[policy->cpu] = freq;

-       ret = tegra_update_cpu_speed(tegra_cpu_highest_speed());
+       ret = tegra_update_cpu_speed(policy, tegra_cpu_highest_speed());

 out:
        mutex_unlock(&tegra_cpu_lock);
@@ -191,10 +192,12 @@ static int tegra_pm_notify(struct notifier_block
*nb, unsigned long event,
 {
        mutex_lock(&tegra_cpu_lock);
        if (event == PM_SUSPEND_PREPARE) {
+               struct cpufreq_policy *policy = cpufreq_cpu_get(0);
                is_suspended = true;
                pr_info("Tegra cpufreq suspend: setting frequency to %d kHz\n",
                        freq_table[0].frequency);
-               tegra_update_cpu_speed(freq_table[0].frequency);
+               tegra_update_cpu_speed(policy, freq_table[0].frequency);
+               cpufreq_cpu_put(policy);
        } else if (event == PM_POST_SUSPEND) {
                is_suspended = false;
        }
