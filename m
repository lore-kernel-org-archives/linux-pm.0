From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Sun, 2 Apr 2017 04:03:48 +0200
Message-ID: <CAJZ5v0h=+XM6ZP62n_M8zq2mNGm6o8j0XxWehz3jam8Cgdo=vg@mail.gmail.com>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan> <20170331102223.GS19929@e106622-lin>
 <6978951.cfP8K2rCI0@aspire.rjw.lan> <CAFEhuF=sWvuC3Q1NsqdRuiGzK4uD8ie5zbEnVsuGMdJK3y9e3Q@mail.gmail.com>
 <CAFEhuFnf=N3z2fvajqGT4mN7NtU3fAeGq1CUa_WRQj-PBonwUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36624 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdDBCDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 22:03:49 -0400
In-Reply-To: <CAFEhuFnf=N3z2fvajqGT4mN7NtU3fAeGq1CUa_WRQj-PBonwUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andres Oportus <andresoportus@android.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Apr 2, 2017 at 1:29 AM, Andres Oportus
<andresoportus@android.com> wrote:
> On Sat, Apr 1, 2017 at 1:39 PM, Andres Oportus
> <andresoportus@android.com> wrote:
>> Hi Rafael, Juri,

[cut]

>>>
>>> > As we discussed at the last LPC, having an energy model handy and use
>>> > that to decide how quickly to ramp up or slow down seems the desirable
>>> > long term solution, but we probably need something (as you are
>>> > proposing) until we get there.
>>>
>>> Well, we definitely need something to address real use cases, like the one
>>> that
>>> I responded to with this patch. :-)
>>
>> I don't know the history/intent behind schedutil rate limiting, but if we

Basically, the hardware cannot be requested to change the frequency
too often as that would be too expensive in general.

>> make it to be only "down" as Juri mentioned we would not be adding a new
>> tunable but rather changing the current one to be more restricted (maybe
>> some renaming would be in order if this is done), this would provide
>> hysteresis to reduce this problem without locking the amount of the
>> hysteresis which may not work for all platforms.  I also agree that "it is
>> difficult to imagine that the same values will always be suitable for every
>> workload", but without any value to control the whole system, we get nothing
>> in between.  Ultimately I also think we should solve the hysteresis problem
>> at the root, i.e. the input to the governor in the form of util/load that
>> has not only hysteresis and energy model, but also any other behavioral
>> inputs built-in.

That's long-term, though, and besides knobs only help if users change
the defaults.  From my experience they usually don't do that.

Thanks,
Rafael
