From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 05/11] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
Date: Thu, 11 Oct 2018 17:05:07 +0200
Message-ID: <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-6-ulf.hansson@linaro.org> <20181010150331.GB4844@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010150331.GB4844@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10 October 2018 at 17:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Wed, Oct 03, 2018 at 04:38:18PM +0200, Ulf Hansson wrote:
>> The CPU's idle state nodes are currently parsed at the common cpuidle DT
>> library, but also when initializing back-end data for the arch specific CPU
>> operations, as in the PSCI driver case.
>>
>> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
>> the device node for the CPU and the index to the requested idle state node,
>> as in-parameters. In case a corresponding idle state node is found, it
>> returns the node with the refcount incremented for it, else it returns
>> NULL.
>>
>> Moreover, for ARM, there are two generic methods, to describe the CPU's
>> idle states, either via the flattened description through the
>> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
>> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
>> take both options into account.
>>
>> [1]
>> Documentation/devicetree/bindings/arm/idle-states.txt
>> [2]
>> Documentation/devicetree/bindings/arm/psci.txt
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  8 ++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 74eaedd5b860..bf1d5fa34899 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -424,6 +424,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
>>  }
>>  EXPORT_SYMBOL(of_cpu_node_to_id);
>>
>> +/**
>> + * of_get_cpu_state_node - Get CPU's idle state node at the given index
>> + *
>> + * @cpu_node: The device node for the CPU
>> + * @index: The index in the list of the idle states
>> + *
>> + * Two generic methods can be used to describe a CPU's idle states, either via
>> + * a flattened description through the "cpu-idle-states" binding or via the
>> + * hierarchical layout, using the "power-domains" and the "domain-idle-states"
>> + * bindings. This function check for both and returns the idle state node for
>> + * the requested index.
>> + *
>> + * In case and idle state node is found at index, the refcount incremented for
>> + * it, so call of_node_put() on it when done. Returns NULL if not found.
>> + */
>> +struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
>
> No strong opinion but I am wondering if it makes sense to get cpu
> logical index and fetch the cpu of_node here to contain the refcount on
> it within this function while we are trying to consolidate. I do see
> that may not be so useful in psci.c but keeping refcount for cpu of_node
> here keeps the user free from that.

I see your point.

However, I am hesitating doing that change, as it would be a waste for
the psci case, but I also think that it may becomes a bit less
straight forward to use this helper function.

Although, no strong opinions from my side either, but since Rob is
happy with this, there is no need to change it, I think.

>
> I am fine as it is if there are reasons not to do that.
>

Right.

Kind regards
Uffe
