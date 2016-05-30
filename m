From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Mon, 30 May 2016 21:08:14 +0200
Message-ID: <CAJZ5v0io0vxbeOw_LNivm=jZfpENf91-o1BySvkeqrRXXDHDbw@mail.gmail.com>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
	<1464231181-30741-4-git-send-email-smuckle@linaro.org>
	<20160526071629.GW17585@vireshk-i7>
	<CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
	<20160530101830.GE30066@vireshk-i7>
	<CAJZ5v0hwohZh_Pubt5pc2NoiMWrSDkcfjkbcFuugPkRTwKhejQ@mail.gmail.com>
	<20160530153233.GA9463@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36754 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161631AbcE3TIQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 15:08:16 -0400
In-Reply-To: <20160530153233.GA9463@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Mon, May 30, 2016 at 5:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> I clearly missed the !policy->fast_switch_enabled check in sugov_limit() and so
> the confusion.
>
> On 30-05-16, 16:25, Rafael J. Wysocki wrote:
>> On Mon, May 30, 2016 at 12:18 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > Suppose this is the current range of frequencies supported by a
>> > driver: 200, 400, 600, 800, 1000 (in MHz).

[cut]

> I am not sure how harmful it can be, but we are returning from sugov_limits()
> without making sure that policy->cur is in valid range currently. I also know
> that you left it out because of the possible races with the util handler.
>
> But this is something that is fundamentally broken for now.

To be clear, this is your opinion that I disagree with.

> The user writes updates the policy->max/min, we return the call to the user thinks that it has
> successfully written to the file and everything is aligned. But we may be
> running at an frequency from invalid range. Yes, that will happen very soon, but
> its broken.

Does it really matter that the call may return before the new limit
takes effect?  I don't think so.

Moreover, if the limit is updated cross-CPU (ie. the CPU running the
call is not the one whose limit is updated) and the target CPU is
idle, waking it up just in order to make sure that the frequency limit
took effect is not particularly smart.

What really matters is how soon the limit can take effect and that in
both "fast switch" and "traditional" cases is about the same time, so
I don't see anything problematic here.

Actually, making sugov_limits() wait for the limit to take effect
would be a matter of adding three lines of code to it, but that would
change a relatively lightweight call into a really heavyweight one, so
I didn't add them, because I didn't see a point in doing that.

I still don't see a point in doing that for that matter.
