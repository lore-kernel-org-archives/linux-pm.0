From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFCv7 PATCH 02/10] cpufreq: introduce cpufreq_driver_is_slow
Date: Fri, 26 Feb 2016 22:00:31 +0100
Message-ID: <CAJZ5v0i58YFj7qzAfRCvjZZiKSW0VAzO2Xm34_g_BdHnrdyL7g@mail.gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
	<CAJZ5v0gM56y0+_SCV5RDQzWWJxS_aNWWpi8ZrcGtjZo+fH2uUA@mail.gmail.com>
	<20160226005029.2278.38972@quark.deferred.io>
	<2670324.0JtTyvN55A@vostro.rjw.lan>
	<20160226185503.2278.20479@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226185503.2278.20479@quark.deferred.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26, 2016 at 7:55 PM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Quoting Rafael J. Wysocki (2016-02-25 17:16:17)
>> On Thursday, February 25, 2016 04:50:29 PM Michael Turquette wrote:
>> > Quoting Rafael J. Wysocki (2016-02-22 17:31:09)
>> > > On Tue, Feb 23, 2016 at 2:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> > > For example, in the acpi-cpufreq case all depends on what's there in
>> > > the ACPI tables.
>> >
>> > It's all a moot point until the locking in cpufreq is changed.
>>
>> No, it isn't.  Look at this, for example: https://patchwork.kernel.org/patch/8426741/
>
> Thanks for the pointer. Do you mind Cc'ing me on future versions?

I'll do that.

Thanks,
Rafael
