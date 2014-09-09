From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 09 Sep 2014 15:29:21 +0200
Message-ID: <2522658.WeeDA1knhn@vostro.rjw.lan>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <540E435D.1070706@codeaurora.org> <CAKohpokisuO8vQ+p5sq-ojYjU55YQm+Q==+rEWCa95J37j_a7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57929 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756194AbaIINJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 09:09:54 -0400
In-Reply-To: <CAKohpokisuO8vQ+p5sq-ojYjU55YQm+Q==+rEWCa95J37j_a7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>

On Tuesday, September 09, 2014 10:17:54 AM Viresh Kumar wrote:
> On 9 September 2014 05:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 09/08/14 16:52, Rafael J. Wysocki wrote:
> >> So more bikeshedding. :-)
> 
> :)
> 
> >> Isn't "generic" somewhat too broad?  Surely it doesn't cover x86.  And does
> >> it actually cover anything without clocks/regulators?
> 
> It can work without regulators but not clocks.
> 
> > I thought when you bikeshed you have to come up with a different color ;-)
> >
> > Perhaps "cpufreq_cpus"?
> 
> I don't have any affection to the word 'generic' here and it can be anything
> we want it to be. But yeah, we shouldn't let these patches wait for that for
> too long :)
> 
> What name do you suggest Rafael?
> 
> - cpufreq_generic
> - cpufreq_cpus
> - cpufreq_dt

If it relies on DTs being used, this probably is the right name to call it.

> - cpufreq_platform
> - cpufreq_cpuX
> 
> Let me know and I will prepare pending patches accordingly :)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
