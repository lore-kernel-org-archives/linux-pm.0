From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Wed, 27 Dec 2017 15:54:37 -0600
Message-ID: <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
References: <cover.1513591822.git.viresh.kumar@linaro.org> <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop> <20171227085645.GF8312@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbdL0Vy7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Dec 2017 16:54:59 -0500
In-Reply-To: <20171227085645.GF8312@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 27, 2017 at 2:56 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-12-17, 14:29, Rob Herring wrote:
>> On Mon, Dec 18, 2017 at 03:51:30PM +0530, Viresh Kumar wrote:
>
>> > +On some platforms the exact frequency or voltage may be hidden from the OS by
>> > +the firmware and the "opp-hz" or the "opp-microvolt" properties may contain
>> > +magic values that represent the frequency or voltage in a firmware dependent
>> > +way, for example an index of an array in the firmware.
>>
>> I'm still not convinced this is a good idea.
>
> You were kind-of a few days back :)
>
> lkml.kernel.org/r/CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com

Yeah, well that was before Stephen said anything.

> So here is the deal:
>
> - I proposed "domain-performance-state" property for this stuff
>   initially.
> - But Kevin didn't like that and proposed reusing "opp-hz" and
>   "opp-microvolt", which we all agreed to multiple times..
> - And we are back to the same discussion now and its painful and time
>   killing for all of us.

There's bigger issues than where we put magic values as I raised in
the other patch.

> TBH, I don't have too strong preferences about any of the suggestions
> you guys have and I need you guys to tell me what binding changes to
> do here and I will do that.
>
>> If you have firmware
>> partially managing things, then I think we should have platform specific
>> bindings or drivers.
>
> What about the initial idea then, like "performance-state" for the
> power domains ? All platforms will anyway replicate that binding only.

I don't really know. I don't really care either. I'll probably go
along with what everyone agrees to, but the only one I see any
agreement from is Ulf. Also, it is pretty vague as to what platforms
will use this. You claimed you can support QCom scenarios, but there's
really no evidence that that is true. What I don't want to see is this
merged and then we need something more yet again in a few months for
another platform.

Rob
