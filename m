From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 18:08:08 +0530
Message-ID: <CAKohpo=13-2VwtRL3F2dGd2LS52QC0AsVjAQ5JsgadvkzhdwNw@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 10 September 2014 17:38, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> Here is the v2 of the platform_data based proposal to make cpufreq-dt
> understand when it has a shared clock by all CPUs vs. independent
> clock for each CPU.
>
> Changes since v1:
>
>  - Use a 'void *driver_data' in cpufreq_driver instead of extending
>    the existing flags field. Suggested by Viresh.
>
>  - Keep the regulator related warning in cpufreq-dt, but reword it,
>    and move it to the dev_dbg() level instead of dev_warn().
>
> Thanks,
>
> Thomas
>
> Thomas Petazzoni (4):
>   cpufreq: allow driver-specific data
>   cpufreq: cpufreq-dt: extend with platform_data
>   ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
>   cpufreq: cpufreq-dt: adjust message related to regulators

After Arnd's reply:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
