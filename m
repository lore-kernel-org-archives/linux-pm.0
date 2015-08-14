From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Fri, 14 Aug 2015 10:19:04 -0700
Message-ID: <CAMAWPa-0R42thqBo0omn0KK7y0wyxoyaP+wsfoRvXBmWhBytKg@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
	<7hfv3onv5c.fsf@deeprootsystems.com>
	<CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
	<7hwpwylepx.fsf@deeprootsystems.com>
	<CAMuHMdW-T9rUWXsQeffwtXspHbjfGqo_0G4QMB1o0TwTLJAQAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33197 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354AbbHNRTJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 13:19:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4712420824
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 17:19:08 +0000 (UTC)
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com [209.85.212.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2D6E42081C
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 17:19:06 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so24521604wic.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 10:19:04 -0700 (PDT)
In-Reply-To: <CAMuHMdW-T9rUWXsQeffwtXspHbjfGqo_0G4QMB1o0TwTLJAQAg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On Fri, Aug 14, 2015 at 12:24 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Kevin,
>
> On Fri, Aug 14, 2015 at 5:40 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>> This check might have made sense before PM domains, but with PM domains,
>>>> it's entirely possible to have a simple device without a driver and the
>>>> PM domain handles all the necesary PM, so I think this check
>>>> could/should be removed.
>>>>
>>>> Thoughts?
>>>
>>> Simple devices without a driver aren't handled automatically.
>>> At minimum, the driver should call pm_runtime_enable(), cfr.
>>> drivers/bus/simple-pm-bus.c.
>>
>> That's correct, and in the proof-of-concept stuff I hacked up and in
>> Lina's series, the CPU "devices" do indeed to this.  Without that, they
>> wouldn't end up ever taking this codepath through genpd's
>> runtime_suspend and power_off hooks.
>>
>> Also, I'm not sure if your comment was meant to be an objection to the
>> patch?  or if you're OK with it.
>
> My comment was purely meant as a response to "it's entirely possible to have a
> simple device without a driver and the PM domain handles all the necesary PM".

Right, so if the PM domain does the pm_runtime_enable() for these
"simple" devices without drivers, they can still exist without a
driver, and the PM domain doing all the magic.

> I have no objections to the patch (read: I'm not sufficiently familiar with
> the code to make educated guesses about the side effects of this change ;-).

OK, thanks for clarifiying.

Kevin
