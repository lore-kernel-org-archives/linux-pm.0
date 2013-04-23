From: Taras Kondratiuk <taras@ti.com>
Subject: Re: [RFC PATCH 1/2] regulator: core: Add regulator_set_voltage_min()
Date: Tue, 23 Apr 2013 14:44:58 +0300
Message-ID: <5176743A.9070201@ti.com>
References: <1366372554-20866-1-git-send-email-taras@ti.com> <1366372554-20866-2-git-send-email-taras@ti.com> <20130422131904.GL30351@opensource.wolfsonmicro.com> <51756A21.3020405@ti.com> <20130423084838.GB5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130423084838.GB5019@opensource.wolfsonmicro.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, rjw@sisk.pl, viresh.kumar@linaro.org, shawn.guo@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Philip Rakity <prakity@nvidia.com>, Eric Miao <eric.y.miao@gmail.com>, "grygorii.strashko" <grygorii.strashko@ti.com>, Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
List-Id: linux-pm@vger.kernel.org

On 04/23/2013 11:48 AM, Mark Brown wrote:
> On Mon, Apr 22, 2013 at 07:49:37PM +0300, Taras Kondratiuk wrote:
>
>> Yeah. Sure 4kV is not a real request, but
>> max will be limited by system constrains.
>> According to regulator_set_voltage() documentation
>> system constraints should be set before calling this function,
>> so I assume I can rely on them. No?
>> Another possible implementation is below, but prefer initial one.
> I just don't see any reason for this API.  The driver setting the
> voltage ought to have some idea of what the chip limits are too for
> safety.
Let's take an example.
One regulator supplies CPU and GPU inside of SoC.
                       +-------------+
                       | SoC         |
               VDD_CPU |    +-----+  |
             +------------->| CPU |  |
+-------+   |         |    +-----+  |
| Reg X |---+         |             |
+------ +   | VDD_GPU |    +-----+  |
             +------------->| GPU |  |
                       |    +-----+  |
                       +-------------+

GPU voltage is regulated by some devfreq driver.
CPU voltage is regulated by generic cpufreq-cpu0 driver.
Both drivers know only about their operational points.
They don't know anything about chip limits.

I see two options here:
1. Pass somehow chip limits to drivers so they can limit their request.
    Pros: No need for regulator_set_voltage_min()
    Cons: a) Need to pass info about chip limits to driver. New API?
          b) CPU and GPU may have different limits,
             so after very first request voltage may violate
             CPU or GPU range.
2. Define chip limits in Reg X constraints.
    Pros: Limits will be applied to driver's request transparently.
          No need to pass info about limits to driver.
          Limits are set before the first request, so no violation.
    Cons: regulator_set_voltage_min() is needed.

IMHO option #2 is better.
Do you see other ways?

-- 
BR
Taras Kondratiuk | GlobalLogic

