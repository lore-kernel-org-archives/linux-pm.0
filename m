From: Fengguang Wu <lkp@intel.com>
Subject: Re: [kbuild-all] [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when
 hotplug is used
Date: Thu, 3 Aug 2017 09:50:56 +0800
Message-ID: <20170803015056.egrj555tf4oips3y@wfg-t540p.sh.intel.com>
References: <201707302248.x4bqfCKB%fengguang.wu@intel.com>
 <1881043.tatm6HIeku@aspire.rjw.lan>
 <CAHKzcEPQw=_mMr2-5TgU7FiPKvYfeHNCV=LjjKwEV1==y47y9g@mail.gmail.com>
 <CAJZ5v0jgU0tLQwz=rNZbU3jaRhz3J31zv5HwhZ4L=og7EErQAQ@mail.gmail.com>
 <20170801043708.GE5804@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2291 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbdHCBvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Aug 2017 21:51:00 -0400
Content-Disposition: inline
In-Reply-To: <20170801043708.GE5804@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@01.org, Stephen Boyd <sboyd@codeaurora.org>

On Tue, Aug 01, 2017 at 10:07:08AM +0530, Viresh Kumar wrote:
>On 31-07-17, 20:50, Rafael J. Wysocki wrote:
>> On Mon, Jul 31, 2017 at 5:12 PM, Waldemar Rymarkiewicz
>> <waldemar.rymarkiewicz@gmail.com> wrote:
>> > On 31 July 2017 at 13:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> On Sunday, July 30, 2017 10:54:30 PM kbuild test robot wrote:
>> >>> Hi Waldemar,
>> >>>
>> >>> [auto build test ERROR on pm/linux-next]
>> >>> [also build test ERROR on v4.13-rc2 next-20170728]
>> >>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> >>
>> >> OK, I'm dropping this commit.
>> >>
>> >> Please make sure that the problem is fixed before sending a new version of it.
>> >
>> > I am a bit confused, it was already fixed and sent out in v5 [1], but
>> > I see v5 is in 'Not Applicable, archived' state. Why?
>> >
>> > [1] https://patchwork.kernel.org/patch/9866525/
>>
>> Because it was applied and still broke.
>
>Not actually.
>
>The bug report *wasn't* reported for the patch you applied, but how would be the
>build go if V4 is applied on top of pm/linux-next. And so buildbot replied to
>this thread.
>
>It can sometimes get a bit confusing seriously, I have to read it very carefully
>today after the discussions you two had :)
>
>You can re-apply the commit as that was doing the right thing:
>
>commit 63a48cf920c0 ("PM / OPP: Fix get sharing CPUs when hotplug is used")
>
>@Fengguang: We need to somehow indicate (in BOLD/CAPS?) that the report isn't
>for a commit in the tree.

For patch testing, the report will start with such a paragraph

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.13-rc2 next-20170728]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

which should be obvious enough. How about you take them as indicators
that it's a LKML patch instead of git tree commit? :)

>Yeah, you would normally include the commit sha in that case and so
>we can actually distinguish between the two cases. But practically,
>people are getting confused unless they read it very very carefully.
>Thanks for the great job btw :)

You are welcome!

Regards,
Fengguang
