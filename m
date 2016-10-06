From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 3/8] PM / Domains: Allow domain power states to be read
 from DT
Date: Thu, 6 Oct 2016 09:54:39 -0600
Message-ID: <20161006155439.GE28930@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-4-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFqWE=-tMLN-6zKWpb6K2a2bBxkA7q+mSivJFpzNntcupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33002 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942102AbcJFPym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 11:54:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id cd13so10722664pac.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Oct 2016 08:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqWE=-tMLN-6zKWpb6K2a2bBxkA7q+mSivJFpzNntcupw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Marc Titinger <mtitinger+renesas@baylibre.com>

On Thu, Oct 06 2016 at 03:47 -0600, Ulf Hansson wrote:
>On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
>> This patch allows domains to define idle states in the DT. SoC's can
>> define domain idle states in DT using the "domain-idle-states" property
>> of the domain provider. Calling of_pm_genpd_init() will  read the idle
>> states and initialize the genpd for the domain.
>>
>> In addition to the entry and exit latency for idle state, also add
>> residency_ns, param and of_node property to each state. A domain idling
>> in a state is only power effecient if it stays idle for a certain period
>> in that state. The residency provides this minimum time for the idle
>> state to provide power benefits. The param is a state specific u32 value
>> that the platform may use for that idle state.
>>
>> This patch is based on the original patch by Marc Titinger.
>>
>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |   8 ++++
>>  2 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 740afa9..368a5b8 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1895,6 +1895,109 @@ out:
>>         return ret ? -EPROBE_DEFER : 0;
>>  }
>>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>> +
>> +static const struct of_device_id idle_state_match[] = {
>> +       { .compatible = "arm,idle-state", },
>> +       { }
>> +};
>> +
>> +static int read_genpd_state(struct genpd_power_state *genpd_state,
>
>/s/read_genpd_state/genpd_parse_state
>
Ok.

>> +                                   struct device_node *state_node)
>> +{
>> +       int err = 0;
>
>No need to assign err to 0.
>
Will fix.
>> +       u32 latency;
>> +       u32 residency;
>> +       u32 entry_latency, exit_latency;
>> +       const struct of_device_id *match_id;
>> +
>> +       match_id = of_match_node(idle_state_match, state_node);
>> +       if (!match_id)
>> +               return -EINVAL;
>> +
>> +       err = of_property_read_u32(state_node, "entry-latency-us",
>> +                                               &entry_latency);
>> +       if (err) {
>> +               pr_debug(" * %s missing entry-latency-us property\n",
>> +                                               state_node->full_name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       err = of_property_read_u32(state_node, "exit-latency-us",
>> +                                               &exit_latency);
>> +       if (err) {
>> +               pr_debug(" * %s missing exit-latency-us property\n",
>> +                                               state_node->full_name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       err = of_property_read_u32(state_node, "min-residency-us", &residency);
>> +       if (!err)
>> +               genpd_state->residency_ns = 1000 * residency;
>> +
>> +       latency = entry_latency + exit_latency;
>
>Hmm, this is probably not what you want.
>
>The genpd governor, via __default_power_down_ok(), already adds the
>->power_on_latency_ns and the ->power_off_latency_ns, when it
>validates which idle state you are allowed to enter.
>
Good catch.
>> +       genpd_state->power_on_latency_ns = 1000 * latency;
>> +       genpd_state->power_off_latency_ns = 1000 * entry_latency;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * of_genpd_parse_idle_states: Return array of idle states for the genpd.
>> + *
>> + * @dn: The genpd device node
>> + * @states: The pointer to which the state array will be saved.
>> + * @n: The count of elements in the array returned from this function.
>> + *
>> + * Returns the device states parsed from the OF node. The memory for the states
>> + * is allocated by this function and is the responsibility of the caller to
>> + * free the memory after use.
>> + */
>> +int of_genpd_parse_idle_states(struct device_node *dn,
>> +                       struct genpd_power_state **states, int *n)
>> +{
>> +       struct genpd_power_state *st;
>> +       struct device_node *np;
>> +       int i, ret = 0;
>> +       int count;
>> +
>> +       for (count = 0; ; count++)
>> +               if (!of_parse_phandle(dn, "domain-idle-states", count))
>> +                       break;
>
>I think it's better to use of_count_phandle_with_args() to find out
>the number of phandles.
>
>> +
>> +       st = kcalloc(count, sizeof(*st), GFP_KERNEL);
>> +       if (!st)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               np = of_parse_phandle(dn, "domain-idle-states", i);
>
>Isn't this a case of when it would be convenient to use the
>of_phandle_iterator*() APIs?
>
>> +               if (!np) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               ret = read_genpd_state(&st[i], np);
>> +               if (ret) {
>> +                       pr_err
>> +                       ("Parsing idle state node %s failed with err %d\n",
>> +                                                       np->full_name, ret);
>> +                       of_node_put(np);
>> +                       break;
>> +               }
>> +               of_node_put(np);
>> +       }
>> +
>> +       if (ret) {
>> +               kfree(st);
>> +               return ret;
>> +       }
>> +
>> +       *n = count;
>> +       *states = st;
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(of_genpd_parse_idle_states);
>> +
>>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>>
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index c113713..4c9152d 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -204,6 +204,8 @@ extern int of_genpd_add_device(struct of_phandle_args *args,
>>  extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
>>                                   struct of_phandle_args *new_subdomain);
>>  extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>> +extern int of_genpd_parse_idle_states(struct device_node *dn,
>> +                       struct genpd_power_state **states, int *n);
>>
>>  int genpd_dev_pm_attach(struct device *dev);
>>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>> @@ -233,6 +235,12 @@ static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
>>         return -ENODEV;
>>  }
>>
>> +static inline int of_genpd_parse_idle_states(struct device_node *dn,
>> +                       struct genpd_power_state **states, int *n)
>> +{
>> +       return -ENODEV;
>> +}
>> +
>>  static inline int genpd_dev_pm_attach(struct device *dev)
>>  {
>>         return -ENODEV;
>> --
>> 2.7.4
>>
>
>Kind regards
>Uffe
