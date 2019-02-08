From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 13:04:18 +0100
Message-ID: <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208110053.GA7913@e107155-lin>
        <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
        <20190208115122.GA13043@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208115122.GA13043@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 2019-02-08 12:51, Sudeep Holla wrote:
> On Fri, Feb 08, 2019 at 12:47:06PM +0100, Marek Szyprowski wrote:
>> On 2019-02-08 12:00, Sudeep Holla wrote:
>>> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
>>>> Dear All,
>>>>
>>>> This is a scenario that triggers the above issue:
>>> [...]
>>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
>>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
>>>> 3. early in the system resume procedure all cpus are got back to online
>>>>    state,
>>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
>>>>    cpus,
>>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>>>>    ->init() callback,
>>> This is strictly not just restricted to cpufreq-dt, but to any driver
>>> supporting multiple policies. So we need a generic fix not just
>>> cpufreq-dt specific.
>> Could you point which other driver needs similar fix? Here in cpufreq-dt
>> the problem was caused by using regulator api (indirectly) from
>> ->init(). All other drivers, which have regulators support, are for old,
>> obsolete, uni-processor systems, which don't have the problem of
>> secondary cpu suspend during system suspend/resume cycle.
>>
> scmi_cpufreq for instance. We can fix that in driver my moving to polling
> to get cpufreq_get_rate, but we support both polling and interrupt based.
> We may wait for remote processor interrupt in get_rate.

Frankly, I don't feel I know enough to touch this driver and I don't
think that this can even be fixed in a generic way in the cpufreq core.
Maybe a comment somewhere is needed that ->init() might be called during
early system resume with irqs off and driver is responsible for handling
such case until the proper resume?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
