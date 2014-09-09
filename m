From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 9 Sep 2014 10:17:54 +0530
Message-ID: <CAKohpokisuO8vQ+p5sq-ojYjU55YQm+Q==+rEWCa95J37j_a7w@mail.gmail.com>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
	<540E3933.8000904@codeaurora.org>
	<1721663.ItCsG3Tt8O@vostro.rjw.lan>
	<3644672.iCZ87qpZY4@vostro.rjw.lan>
	<540E435D.1070706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:57780 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaIIErz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 00:47:55 -0400
Received: by mail-oi0-f45.google.com with SMTP id v63so85532oia.18
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 21:47:54 -0700 (PDT)
In-Reply-To: <540E435D.1070706@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>

On 9 September 2014 05:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/08/14 16:52, Rafael J. Wysocki wrote:
>> So more bikeshedding. :-)

:)

>> Isn't "generic" somewhat too broad?  Surely it doesn't cover x86.  And does
>> it actually cover anything without clocks/regulators?

It can work without regulators but not clocks.

> I thought when you bikeshed you have to come up with a different color ;-)
>
> Perhaps "cpufreq_cpus"?

I don't have any affection to the word 'generic' here and it can be anything
we want it to be. But yeah, we shouldn't let these patches wait for that for
too long :)

What name do you suggest Rafael?

- cpufreq_generic
- cpufreq_cpus
- cpufreq_dt
- cpufreq_platform
- cpufreq_cpuX

Let me know and I will prepare pending patches accordingly :)
