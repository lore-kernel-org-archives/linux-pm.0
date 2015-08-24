From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Mon, 24 Aug 2015 13:50:32 -0600
Message-ID: <20150824195032.GA1384@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
 <7hfv3onv5c.fsf@deeprootsystems.com>
 <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
 <7hwpwylepx.fsf@deeprootsystems.com>
 <CAMuHMdW-T9rUWXsQeffwtXspHbjfGqo_0G4QMB1o0TwTLJAQAg@mail.gmail.com>
 <CAMAWPa-0R42thqBo0omn0KK7y0wyxoyaP+wsfoRvXBmWhBytKg@mail.gmail.com>
 <CAMuHMdV2gDBaPRb3yE=tVPO_pr7PFA6bwhyQE5raumCh_qPXww@mail.gmail.com>
 <7hio88gxpn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33438 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbbHXTuf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 15:50:35 -0400
Received: by pacti10 with SMTP id ti10so30980387pac.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2015 12:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hio88gxpn.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On Fri, Aug 21 2015 at 15:04 -0600, Kevin Hilman wrote:
>Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Hi Kevin,
>>
>> On Fri, Aug 14, 2015 at 7:19 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> On Fri, Aug 14, 2015 at 12:24 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Fri, Aug 14, 2015 at 5:40 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>>>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>>>>> On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>>>>> This check might have made sense before PM domains, but with PM domains,
>>>>>>> it's entirely possible to have a simple device without a driver and the
>>>>>>> PM domain handles all the necesary PM, so I think this check
>>>>>>> could/should be removed.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> Simple devices without a driver aren't handled automatically.
>>>>>> At minimum, the driver should call pm_runtime_enable(), cfr.
>>>>>> drivers/bus/simple-pm-bus.c.
>>>>>
>>>>> That's correct, and in the proof-of-concept stuff I hacked up and in
>>>>> Lina's series, the CPU "devices" do indeed to this.  Without that, they
>>>>> wouldn't end up ever taking this codepath through genpd's
>>>>> runtime_suspend and power_off hooks.
>>>>>
>>>>> Also, I'm not sure if your comment was meant to be an objection to the
>>>>> patch?  or if you're OK with it.
>>>>
>>>> My comment was purely meant as a response to "it's entirely possible to have a
>>>> simple device without a driver and the PM domain handles all the necesary PM".
>>>
>>> Right, so if the PM domain does the pm_runtime_enable() for these
>>> "simple" devices without drivers, they can still exist without a
>>> driver, and the PM domain doing all the magic.
>>
>> Is it possible to let the PM Domain do the pm_runtime_enable() itself in
>> the absence of a driver?
>
>Well, I suppose it's possible, not sure it's recommended. :)
>
>> If yes, I wouldn't have needed simple-pm-bus.c.
>> What if a driver is bound later?
>
>Yeah, you're approach is better.
>
I am not sure I understand the approach? Initialize the CPU devices as
"simple-pm-bus" compatible?

Thanks,
Lina
