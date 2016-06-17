From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 0/2] cpufreq: Sort policy->freq_table
Date: Fri, 17 Jun 2016 02:56:59 +0200
Message-ID: <CAJZ5v0gMtuV-stZLf0QBQH2W_Ut1p0mq9GnpL-LCfe8eRRwAbw@mail.gmail.com>
References: <cover.1465295033.git.viresh.kumar@linaro.org> <27658050.4ol4GjkJ1n@vostro.rjw.lan>
 <20160616161739.GB24612@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33789 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbcFQA5B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 20:57:01 -0400
In-Reply-To: <20160616161739.GB24612@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Thu, Jun 16, 2016 at 6:17 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-06-16, 02:19, Rafael J. Wysocki wrote:
>> On Tuesday, June 07, 2016 03:55:13 PM Viresh Kumar wrote:
>> > Hi Rafael,
>> >
>> > I have spent some more time on this stuff and finally came out with a
>> > very simple solution. I hope you will like it more than the previous
>> > versions.
>> >
>> > Instead of trying to sort the freq-table passed by the drivers, which
>> > was complicated and would have broken some drivers for sure, this patch
>> > just checks if the freq-table is sorted or not.
>> >
>> > If it is sorted, then we just use a different set of helpers for it. The
>> > table can be sorted in both ascending and descending orders now and
>> > helpers are present for both the cases.
>>
>> Well, that's something I was thinking about from the start. :-)
>>
>> > All the patches are pushed here for testing in case anyone wants to try:
>> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table
>> >
>> > V3->V4:
>> > - Written from scratch really, completely different approach.
>>
>> I'll look at the code later this week.
>
> Hi Rafael,
>
> Did you get a chance to look at these? Steve may be blocked on this :)

I know, but I have stuff to do other than cpufreq.

And in particular regression fixes take precedence, of course.
