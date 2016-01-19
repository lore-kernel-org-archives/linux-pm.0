From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
Date: Tue, 19 Jan 2016 11:01:51 +0100
Message-ID: <CAPDyKFpV4mNdYt=KVXARrcZALcqL-7wjcDumeNkT0yCnymk42g@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
	<CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
	<20160114183316.GB1651@linaro.org>
	<CAPDyKFpj0Gv=5hVwZWjmgmumHPriuYk+LLVBwjEeW9Jfj8p5Kw@mail.gmail.com>
	<20160115165758.GC1651@linaro.org>
	<CAPDyKFo4qe8THwJQd1aNQwpbjV1phOGKz_gEuP-wRD6Dgtx0pg@mail.gmail.com>
	<20160118165818.GD1651@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160118165818.GD1651@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 18 January 2016 at 17:58, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Fri, Jan 15 2016 at 15:08 -0700, Ulf Hansson wrote:
>>
>> [...]
>>
>>>> I think case 2 and case 3 should be okay to support, but I am really
>>>> questioning case 1.
>>>>
>>> With you other patch, it does make sense to have 2 and 3 instead of 1
>>> and 2.
>>
>>
>> Okay!
>>
>>> My only concern is as I view the SoC as a whole, there would be cases
>>> where the parent domain could only be non-IRQ safe (turning off a big
>>> regulator may require some sleep) and the subdomains are quicker and
>>> faster IRQ-safe domains. Putting up this restriction, chops up the
>>
>>
>> Just because they are "quick" (don't sleep) doesn't mean they have to
>> set the IRQ safe flag for the domain.
>>
>> Let's compare how pm_runtime_irq_safe() is used for devices in
>> drivers. Lots of corresponding runtime PM callbacks don't sleep, but
>> that don't mean that the driver calls pm_runtime_irq_safe().
>>
>> Drivers that are expecting to invoke pm_runtime_get_sync() (or other
>> synchronous runtime PM API) from atomic context, requires the
>> corresponding runtime PM callbacks to be IRQ safe. Only under these
>> circumstances the pm_runtime_irq_safe() is used.
>>
> I agree.
>
> The limitation and the interpretation could completely be s/w. There is
> nothing preventing that in hardware. So we could have a processor
> subsystem domain that can collapse faster and even during cpuidle. We
> would define that domain IRQ-safe because of its need to collapse and
> resume when IRQs are disabled, but its parent may not have that
> restriction, in fact, the parent could have another child that could
> only operate as non-IRQ safe.
>
> By imposing the limitation that parents of IRQ-safe domains cannot be
> non-IRQ-safe, we have to chop off that relationship, because of another
> non-IRQ-safe sibling.
>
>>> domain hierarchy. Imagine, if you could represent the whole power domain
>>> organization in DT, but because of this restriction, we may not be able
>>> to do that.
>>
>>
>> You do have a point. Considering my comment above, do you still think
>> this may become an issue?
>>
> Yes. Pls see my example below.
>
> That said, I probably won't encounter this limitation in my current
> series, but its not hard to foresee this corner case.

Okay, thanks for sharing your thoughts.

For now, I suggest we leave case 1) as a non-supported option.

When we have a valid use case for case 1), we anyway will have to
think of a better approach than what's suggested in $subject patch,
since keeping the parent domain always powered on isn't good enough.

Kind regards
Uffe
