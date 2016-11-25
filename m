From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev list
Date: Fri, 25 Nov 2016 16:55:00 +0100
Message-ID: <CAJZ5v0g_0G8a0QePQhXFUh-4QxX6=CYrKp+FtKDvj801yP9rfg@mail.gmail.com>
References: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
 <20161125065529.GB29969@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161125065529.GB29969@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 25, 2016 at 7:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-11-16, 12:23, Viresh Kumar wrote:
>> Joonyoung Shim reported an interesting problem on his ARM octa-core
>> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
>> was failing for a struct device for which dev_pm_opp_set_regulator() is
>> called earlier.
>>
>> This happened because an earlier call to
>> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
>> removed all the entries from opp_table->dev_list apart from the last CPU
>> device in the cpumask of CPUs sharing the OPP.
>>
>> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
>> routines get CPU device for the first CPU in the cpumask. And so the OPP
>> core failed to find the OPP table for the struct device.
>>
>> This patch attempts to fix this problem by adding another field in the
>> struct opp_device: inactive.
>>
>> Instead of removing the entries from the list during
>> dev_pm_opp_of_cpumask_remove_table() function call, we mark them as
>> inactive. Such inactive devices will not be used by the core in most of
>> the cases, like before, but will be used only at special places which
>> need to take inactive devices into account.
>>
>> All the devices are removed from the list together now and that happens
>> only when the opp_table gets destroyed.
>>
>> This patch is tested on Dual A15, Exynos5250 platform by compiling the
>> cpufreq-dt driver as a module. The module is inserted/removed multiple
>> times with combinations of CPU offline/online steps.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> @Rafael: Can you please add following while applying the patch ?
>
> Cc: <stable@vger.kernel.org> # v4.4+

Yes, I can, but I need an ACK for this from Stephen too.

Thanks,
Rafael
