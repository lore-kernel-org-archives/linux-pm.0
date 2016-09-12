From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 12 Sep 2016 10:16:00 -0600
Message-ID: <20160912161600.GA21885@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org>
 <87sht59mcw.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sht59mcw.fsf@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 12 2016 at 09:19 -0600, Brendan Jackman wrote:
>
>Hi Lina,
>
>Sorry for the delay here, Sudeep and I were both been on holiday last week.
>
>On Fri, Sep 02 2016 at 21:16, Lina Iyer wrote:
>> On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
>[...]
>>>This version is *not very descriptive*. Also the discussion we had on v3
>>>version has not yet concluded IMO. So can I take that we agreed on what
>>>was proposed there or not ?
>>>
>> Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
>> for the new changes in the following patches. Let me know if that makes
>> sense.
>
>The not-yet-concluded discussion Sudeep is referring to is at [1].
>
>In that thread we initially proposed the idea of, instead of splitting
>state phandles between cpu-idle-states and domain-idle-states, putting
>CPUs in their own domains and using domain-idle-states for _all_
>phandles, deprecating cpu-idle-states. I've brought this up in other
>threads [2] but discussion keeps petering out, and neither this example
>nor the 8916 dtsi in this patch series reflect the idea.
>
Brendan, while your idea is good and will work for CPUs, I do not expect
other domains and possibly CPU domains on some architectures to follow
this model. There is nothing that prevents you from doing this today,
you can specify domains around CPUs in your devicetree and CPU PM will
handle the hierarchy. I don't think its fair to force it on all SoCs
using CPU domains. This patchset does not restrict you from organizing
the idle states the way you want it. This revision of the series, clubs
CPU and domain idle states under idle-states umbrella. So part of your
requirement is also satisfied.

You can follow up the series with your new additions, I don't see a
conflict with this change.

Thanks,
Lina


>It would be great if we could go back to the thread at [1] where Sudeep
>has posted examples and come to a clear consensus on the binding design
>before reviewing implementation patches. Ideally with input from Ulf,
>Rob and Kevin.
>
>[1] https://patchwork.kernel.org/patch/9264507
>[2] http://www.spinics.net/lists/devicetree/msg141024.html
>>
>> Thanks,
>> Lina
>>
>>>We could have better example above *really* based on the discussions we
>>>had so far. This example always makes me think it's well crafted to
>>>avoid any sort of discussions. We need to consider different use-cases
>>>e.g. what about CPU level states ?
>>>
>>>IMO, we need to discuss this DT binding in detail and arrive at someq
>>>conclusion before you take all the troubles to respin the series.
>>>Also it's better to keep the DT binding separate until we have some
>>>conclusion instead of posting the implementation for each version.
>>>That's just my opinion(I would be least bothered about implementation
>>>until I know it will be accepted before I can peek into the code, others
>>>may differ.
>>>
>>>--
>>>Regards,
>>>Sudeep
>
>Cheers,
>Brendan
