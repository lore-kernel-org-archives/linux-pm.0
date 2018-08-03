From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
Date: Fri, 3 Aug 2018 13:43:18 +0200
Message-ID: <CAPDyKFq=m7ad66SwiOr+4ab=e7PNiXrXJ6c8G0ZTPOdO1RQ_6g@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-5-ulf.hansson@linaro.org> <1678369.6pMUSOvdlV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1678369.6pMUSOvdlV@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19 July 2018 at 12:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
>> To enable a device belonging to a CPU to be attached to a PM domain managed
>> by genpd, let's do a few changes to genpd as to make it convenient to
>> manage the specifics around CPUs.
>>
>> First, as to be able to quickly find out what CPUs that are attached to a
>> genpd, which typically becomes useful from a genpd governor as following
>> changes is about to show, let's add a cpumask 'cpus' to the struct
>> generic_pm_domain.
>>
>> At the point when a device that belongs to a CPU, is attached/detached to
>> its corresponding PM domain via genpd_add_device(), let's update the
>> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
>> the master domains, which makes the genpd->cpus to contain a cpumask that
>> hierarchically reflect all CPUs for a genpd, including CPUs attached to
>> subdomains.
>>
>> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
>> unnecessary for cases when only non-CPU devices are parts of a genpd.
>> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
>> Clients must set the bit before they call pm_genpd_init(), as to instruct
>> genpd that it shall deal with CPUs and thus manage the cpumask in
>> genpd->cpus.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
>>  include/linux/pm_domain.h   |  3 ++
>>  2 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 21d298e1820b..6149ce0bfa7b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/suspend.h>
>>  #include <linux/export.h>
>> +#include <linux/cpu.h>
>>
>>  #include "power.h"
>>
>> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>>  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>>  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>> +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>>
>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>>               const struct generic_pm_domain *genpd)
>> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
>>       dev_pm_put_subsys_data(dev);
>>  }
>>
>> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>> +                                int cpu, bool set, unsigned int depth)
>> +{
>> +     struct gpd_link *link;
>> +
>> +     if (!genpd_is_cpu_domain(genpd))
>> +             return;
>> +
>> +     list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> +             struct generic_pm_domain *master = link->master;
>> +
>> +             genpd_lock_nested(master, depth + 1);
>> +             __genpd_update_cpumask(master, cpu, set, depth + 1);
>> +             genpd_unlock(master);
>> +     }
>> +
>> +     if (set)
>> +             cpumask_set_cpu(cpu, genpd->cpus);
>> +     else
>> +             cpumask_clear_cpu(cpu, genpd->cpus);
>> +}
>
> As noted elsewhere, there is a concern about the possible weight of this
> cpumask and I think that it would be good to explicitly put a limit on it.

I have been digesting your comments on the series, but wonder if this
is still a relevant concern?

Updating the mask is only done when the cpu is attached to its PM
domain. However, of course, I should not allocate the cpumask in
pm_genpd_init() unless the GENPD_FLAG_CPU_DOMAIN is set, as that is
just a waste.

>
>> +
>> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
>> +                              struct device *dev, bool set)
>> +{
>> +     bool is_cpu = false;
>> +     int cpu;
>> +
>> +     if (!genpd_is_cpu_domain(genpd))
>> +             return;
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             if (get_cpu_device(cpu) == dev) {
>> +                     is_cpu = true;
>
> You may call __genpd_update_cpumask() right here and then you won't
> need the extra is_cpu variable.

Yes, indeed this looks weird, thanks for spotting it!

Ah, now I recall, the idea was to store an is_cpu variable per device,
to avoid looking up the cpu device at detach, but this is just
unnecessary. :-)

[...]

Thanks for reviewing!

Kind regards
Uffe
