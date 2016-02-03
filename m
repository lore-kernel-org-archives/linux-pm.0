From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Wed, 3 Feb 2016 18:20:58 +0100
Message-ID: <CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
	<20160203155428.GY3947@e106622-lin>
	<20160203161059.GH3469@vireshk>
	<20160203172009.GC12132@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35338 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbcBCRU7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 12:20:59 -0500
In-Reply-To: <20160203172009.GC12132@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 3, 2016 at 6:20 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 03/02/16 21:40, Viresh Kumar wrote:
>> On 03-02-16, 15:54, Juri Lelli wrote:
>> > Ouch, I've just got this executing -f basic on Juno. :(
>> > It happens with the hotplug_1_by_1 test.
>> >
>
> [...]
>
>>
>> Urg..
>>
>> I failed to understand it for now though. Please test only the first 4
>> patches and leave the bottom three. AFAICT, this is caused by the 6th
>> patch.
>>
>> The first 4 are important for 4.5 and must be tested soonish.
>>
>
> First 4 look ok from a testing viewpoint.

Good, thanks for the confirmation!

I'm going to apply them and they will go to Linus next week.

Thanks,
Rafael
