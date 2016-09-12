From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 12 Sep 2016 18:09:48 +0100
Message-ID: <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org> <87sht59mcw.fsf@arm.com>
 <20160912161600.GA21885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160912161600.GA21885@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>, Brendan Jackman <brendan.jackman@arm.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, khilman@kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 12/09/16 17:16, Lina Iyer wrote:
> On Mon, Sep 12 2016 at 09:19 -0600, Brendan Jackman wrote:
>>
>> Hi Lina,
>>
>> Sorry for the delay here, Sudeep and I were both been on holiday last
>> week.
>>
>> On Fri, Sep 02 2016 at 21:16, Lina Iyer wrote:
>>> On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
>> [...]
>>>> This version is *not very descriptive*. Also the discussion we had
>>>> on v3
>>>> version has not yet concluded IMO. So can I take that we agreed on what
>>>> was proposed there or not ?
>>>>
>>> Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
>>> for the new changes in the following patches. Let me know if that makes
>>> sense.

Please add all possible use-cases in the bindings. Though one can refer
the usage examples, it might not cover all usage descriptions. It helps
preventing people from defining their own when they don't see examples.
Again DT bindings are like specifications, it should be descriptive
especially this kind of generic ones.

>>
>> The not-yet-concluded discussion Sudeep is referring to is at [1].
>>
>> In that thread we initially proposed the idea of, instead of splitting
>> state phandles between cpu-idle-states and domain-idle-states, putting
>> CPUs in their own domains and using domain-idle-states for _all_
>> phandles, deprecating cpu-idle-states. I've brought this up in other
>> threads [2] but discussion keeps petering out, and neither this example
>> nor the 8916 dtsi in this patch series reflect the idea.
>>
> Brendan, while your idea is good and will work for CPUs, I do not expect
> other domains and possibly CPU domains on some architectures to follow
> this model. There is nothing that prevents you from doing this today,
> you can specify domains around CPUs in your devicetree and CPU PM will
> handle the hierarchy. I don't think its fair to force it on all SoCs
> using CPU domains.

I disagree. We are defining DT bindings here and it *should* be same for
all the SoC unless there is a compelling reason not to. I am fine if
those reasons are stated and agreed.

> This patchset does not restrict you from organizing
> the idle states the way you want it. This revision of the series, clubs
> CPU and domain idle states under idle-states umbrella. So part of your
> requirement is also satisfied.
>

I will look at the DTS changes in the series. But we *must* have more
description with more examples in the binding document.

> You can follow up the series with your new additions, I don't see a
> conflict with this change.
>

If we just need additions, then it should be fine.

-- 
Regards,
Sudeep
