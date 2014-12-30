From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 00/13] cpufreq: stats: cleanups
Date: Tue, 30 Dec 2014 09:56:13 -0500
Message-ID: <54A2BD0D.5010203@redhat.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org> <3949258.uE4XDaD9A7@vostro.rjw.lan> <CAKohpo=scqNCuXDF4E29fnYEJZ3ytwomBoJ5S20WrMD4PL0b9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38661 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbaL3O4U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Dec 2014 09:56:20 -0500
In-Reply-To: <CAKohpo=scqNCuXDF4E29fnYEJZ3ytwomBoJ5S20WrMD4PL0b9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 12/28/2014 11:41 PM, Viresh Kumar wrote:
> On 19 December 2014 at 07:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, December 18, 2014 05:30:17 PM Viresh Kumar wrote:
>>> Hi Rafael,
>>>
>>> I finally started looking at how to make cpufreq-core somewhat less complex with
>>> respect to locking, its state machine, etc..
>>>
>>> The first thing I had to get into was cpufreq-stats and so this series. Mostly
>>> cleanups to make things better..
>>>
>>> Please see if they make any sense at all.
>>>
>>> I know we are at Merge window right now and you wouldn't apply it even to
>>> linux-next. So, if they look fine, please don't hesitate in dropping a mail to
>>> confirm they look fine, so that I can send the next set of cleanups atleast for
>>> reviews. We can get these applied one by one then, once we are a bit confident
>>> of them.
>>
>> Well, the timing is pretty bad for various reasons.  For one, this isn't 3.19
>> material, so I'm not even going to look at it tomorrow and I'm officially on
>> vacation from Monday onward pretty much through the first half of January.
>>
>> If I have some time and really nothing else to do, I'll have a look at it, but
>> I can't promise anything.
>>
>> It would be good if you could ask poeple to have a look at it and give comments
>> in the meantime.
> 
> Prarit, any more comments about this series ?
> 
> Latest stuff is here:
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups

Hey Viresh, seems fine to me.  I do want to again point out the issue with the
sysfs removal but fixing that type of issue is out-of-scope for this patchset.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.

> 
> --
> viresh
> 
