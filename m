From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: race condition on min/max update?
Date: Fri, 26 Feb 2016 22:05:31 +0100
Message-ID: <CAJZ5v0hzJhbbNhpV-mGNSxvPkWCJDfGjw1D46hXUOzH5MsG4Wg@mail.gmail.com>
References: <56CE1432.2020409@linaro.org>
	<20160226025315.GA9159@vireshk-i7>
	<5917491.2o5563OMLE@vostro.rjw.lan>
	<20160226143749.GA20706@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32895 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbcBZVFd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 16:05:33 -0500
Received: by mail-lb0-f179.google.com with SMTP id ep2so21278657lbb.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2016 13:05:32 -0800 (PST)
In-Reply-To: <20160226143749.GA20706@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Feb 26, 2016 at 3:37 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-02-16, 15:11, Rafael J. Wysocki wrote:
>> A min/max update should trigger ->governor(limits) and then the governor
>> is responsible for taking care of the race (if it needs to).
>>
>> At least that's how it should work IMO.
>
> Urg, simple thing.

It's not particularly clean, though, because ->governor(LIMITS) is
called after min/max have been updated, so the governor may end up
using a frequency that's completely off for a little while between
updating min/max and calling ->governor(LIMITS) (the LIMITS call
really is something like a "you have new min and max, fix up yourself"
notification).  That's why I added a check for min <= max to the
schedutil prototype.

Thanks,
Rafael
