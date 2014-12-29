From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/13] cpufreq: stats: cleanups
Date: Mon, 29 Dec 2014 10:11:40 +0530
Message-ID: <CAKohpo=scqNCuXDF4E29fnYEJZ3ytwomBoJ5S20WrMD4PL0b9A@mail.gmail.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
	<3949258.uE4XDaD9A7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:48116 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaL2Ell (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Dec 2014 23:41:41 -0500
Received: by mail-oi0-f41.google.com with SMTP id i138so23323252oig.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2014 20:41:40 -0800 (PST)
In-Reply-To: <3949258.uE4XDaD9A7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Prarit Bhargava <prarit@redhat.com>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 19 December 2014 at 07:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 18, 2014 05:30:17 PM Viresh Kumar wrote:
>> Hi Rafael,
>>
>> I finally started looking at how to make cpufreq-core somewhat less complex with
>> respect to locking, its state machine, etc..
>>
>> The first thing I had to get into was cpufreq-stats and so this series. Mostly
>> cleanups to make things better..
>>
>> Please see if they make any sense at all.
>>
>> I know we are at Merge window right now and you wouldn't apply it even to
>> linux-next. So, if they look fine, please don't hesitate in dropping a mail to
>> confirm they look fine, so that I can send the next set of cleanups atleast for
>> reviews. We can get these applied one by one then, once we are a bit confident
>> of them.
>
> Well, the timing is pretty bad for various reasons.  For one, this isn't 3.19
> material, so I'm not even going to look at it tomorrow and I'm officially on
> vacation from Monday onward pretty much through the first half of January.
>
> If I have some time and really nothing else to do, I'll have a look at it, but
> I can't promise anything.
>
> It would be good if you could ask poeple to have a look at it and give comments
> in the meantime.

Prarit, any more comments about this series ?

Latest stuff is here:
git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups

--
viresh
