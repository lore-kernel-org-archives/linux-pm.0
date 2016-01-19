From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] cpuidle optimizations (on top of linux-next)
Date: Tue, 19 Jan 2016 14:14:59 +0100
Message-ID: <CAJZ5v0hgKfpi2PDbzk5Rvnio1vC3onaWkJ-2ccg5KAd=r3qPBA@mail.gmail.com>
References: <1621492.NI2xz9vt7M@vostro.rjw.lan>
	<569CEC86.5080002@arm.com>
	<20160119072811.GA11346@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36793 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbcASNPB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 08:15:01 -0500
In-Reply-To: <20160119072811.GA11346@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Jan 19, 2016 at 8:28 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>> On 15/01/16 23:53, Rafael J. Wysocki wrote:
>> >Hi,
>> >
>> >When I was looking at the cpuidle code after the Sudeeps's problem report,
>> >it occured to me that we had some pointless overhead there, so two
>> >changes to reduce it follow.
>> >
>> >[1/2] Make the fallback to to default_idle_call() in call_cpuidle()
>> >       unnecessary and drop it.
>> >[2/2] Make menu_select() avoid checking states that don't need to
>> >       (or even shouldn't) be checked when making the selection.
>> >
>>
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Rafael, can I pick these up into the scheduler tree?

They won't apply at this point as one commit they depend on is in my
linux-next branch waiting for the next push.

Would it be a problem if they went in through the PM tree instead?

Thanks,
Rafael
