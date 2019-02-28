From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Thu, 28 Feb 2019 23:41:34 +0100
Message-ID: <ca30d998-2fe1-7ec9-8387-99c8d3e313bc@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
 <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
 <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28/02/2019 23:26, Ulf Hansson wrote:
> On Thu, 28 Feb 2019 at 16:40, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/02/2019 14:59, Ulf Hansson wrote:
>>> Instead of iterating through all the state nodes in DT, to find out how
>>> many states that needs to be allocated, let's use the number already known
>>> by the cpuidle driver. In this way we can drop the iteration altogether.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>> index d50b46a0528f..cbfc936d251c 100644
>>> --- a/drivers/firmware/psci/psci.c
>>> +++ b/drivers/firmware/psci/psci.c
>>> @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>>>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>>>                       struct device_node *cpu_node, int cpu)
>>>  {
>>> -     int i, ret = 0, count = 0;
>>> +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
>>
>> why -1 ?
> 
> Because of the WFI state. The cpuidle-arm driver always carries this
> state at index 0, which also is never used in
> psci_cpu_suspend_enter(), where the similar is taken into account.
> 
> It's a bit of magic, so perhaps someone should post a patch that
> documents this a bit better in the code, wherever it makes sense.

Ah yes, right. The first state is already filled with the WFI state in
the cpuidle-arm.c driver and we must infer the index passed to
dt_init_idle_driver is 1 because of that.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


[ ... ]


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
