From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Tue, 1 Aug 2017 13:53:08 +0200
Message-ID: <CAJZ5v0gP0UPmkZ7PKiE33ARuuchzQBEDqvNHthY1TGat5aEfNg@mail.gmail.com>
References: <201707302248.x4bqfCKB%fengguang.wu@intel.com> <1881043.tatm6HIeku@aspire.rjw.lan>
 <CAHKzcEPQw=_mMr2-5TgU7FiPKvYfeHNCV=LjjKwEV1==y47y9g@mail.gmail.com>
 <CAJZ5v0jgU0tLQwz=rNZbU3jaRhz3J31zv5HwhZ4L=og7EErQAQ@mail.gmail.com> <20170801043708.GE5804@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35538 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHALxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 07:53:09 -0400
Received: by mail-it0-f66.google.com with SMTP id v127so1436313itd.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2017 04:53:09 -0700 (PDT)
In-Reply-To: <20170801043708.GE5804@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On Tue, Aug 1, 2017 at 6:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31-07-17, 20:50, Rafael J. Wysocki wrote:
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
> Not actually.
>
> The bug report *wasn't* reported for the patch you applied, but how would be the
> build go if V4 is applied on top of pm/linux-next. And so buildbot replied to
> this thread.
>
> It can sometimes get a bit confusing seriously, I have to read it very carefully
> today after the discussions you two had :)

Yeah, I overlooked that, thanks!

>
> You can re-apply the commit as that was doing the right thing:
>
> commit 63a48cf920c0 ("PM / OPP: Fix get sharing CPUs when hotplug is used")

OK

Thanks,
Rafael
