From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 3/8] PM / Domains: Allow domain power states to be read
 from DT
Date: Mon, 24 Oct 2016 18:27:30 +0100
Message-ID: <12435f67-bcb6-33b5-4399-f4f628f70be8@arm.com>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
 <1476467276-75094-4-git-send-email-lina.iyer@linaro.org>
 <6ed96121-5040-474d-2d71-7927e8567c50@arm.com>
 <20161024164846.GE72940@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161024164846.GE72940@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, khilman@kernel.org, rjw@rjwysocki.net, Marc Titinger <mtitinger+renesas@baylibre.com>, brendan.jackman@arm.com, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 24/10/16 17:48, Lina Iyer wrote:
> Hi Sudeep,
>
> On Mon, Oct 24 2016 at 07:39 -0600, Sudeep Holla wrote:
>>
>>
>> On 14/10/16 18:47, Lina Iyer wrote:
>>> This patch allows domains to define idle states in the DT. SoC's can
>>> define domain idle states in DT using the "domain-idle-states" property
>>> of the domain provider. Add API to read the idle states from DT that can
>>> be set in the genpd object.
>>>
>>> This patch is based on the original patch by Marc Titinger.
>>>
>>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> drivers/base/power/domain.c | 94
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>> include/linux/pm_domain.h   |  8 ++++
>>> 2 files changed, 102 insertions(+)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 37ab7f1..9af75ba 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -1916,6 +1916,100 @@ out:
>>>     return ret ? -EPROBE_DEFER : 0;
>>> }
>>> EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>>> +
>>> +static const struct of_device_id idle_state_match[] = {
>>> +    { .compatible = "arm,idle-state", },
>>> +    { }
>>> +};
>>> +
>>
>> I still think it's better to have another compatible to serve this
>> purpose. We don't want to end up creating genpd domains just because
>> they are "arm,idle-state" compatible IMO ?
>>
>> I agree you can prevent it checking for OSC mode support in the
>> firmware. But I want to understand if you have any strong reasons for
>> avoiding that approach.
>>
> Why are you still held up with OSI/PC PSCI modes?

I am just pointing that out to make sure you are not defining these
DT bindings with just QCOM platform and OSC in consideration.

I am thinking about how can it be used/extended in other use-cases.

> I repeat again this
> series is not about any of that, it is just about PM domains.

I completely understand that, no argument on that. What I worry is that
if a system(in future) represents this power domains and domain idles
states and doesn't want to create a genpd, do we have to handle it
differently or even the way your CPUidle series would do or can we say
those states need to specify that they are compatible with the new
feature(the one being added in this series) with a new compatible.
I prefer the latter than the former to avoid all possible workarounds
in future.

> PM domains
> have idle states and the idle-state description is similar in definition
> to arm,idle-state and therefore uses the same compatible. There is no
> point re-defining something that already exists in the kernel.
>

Yes I understand that but "arm,idle-states" were not defined with this
feature in mind and hence I am bit worried if it could cause any issue
especially if deprecate cpu-idle-states and move to this model
completely. I really don't like this mix and hence I am raising the
concern here. I am trying to ease that migration.

> I was able to find the original thread, where we discussed this [1].
>
> I suggest, you read about PM domains and its idle states and understand
> this series in the context of PM domains.
>

Sure, will do that. Thanks for pointing that out. But the concern I am
raising is entirely different. I am asking if this re-use will cause any
issue in future as pointed out above.

I re-iterate that I understand this series is independent of the CPUIdle
and hence asking why not make it completely independent by just adding
the new compatible.

I am *not asking to redefine something completely*. What I am saying is
*just* to add new compatible that may(for cpu devices)/may not(for
other/non-CPU devices) be used along with "arm,idle-state".

I may be too paranoid here but I think that's safer. It helps to skip
creating of genpd if required for some domains as I had explained before.

-- 
Regards,
Sudeep
