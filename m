From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Thu, 19 May 2016 16:30:31 +0200
Message-ID: <CAJZ5v0h+vb1+9urzfOWsCKy8eziVGpVvSiB84i7nwbktOS+EaA@mail.gmail.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
	<20160519114029.GW3193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35539 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbcESOad (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 10:30:33 -0400
In-Reply-To: <20160519114029.GW3193@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>

On Thu, May 19, 2016 at 1:40 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
>> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
>> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> > This patch adds driver callback for fast_switch and below observations
>> > on schedutil governor are done with this patch.
>> >
>> > In POWER8 there is a regression observed with schedutil compared to
>> > ondemand. With schedutil the frequency is not ramping down and is
>> > mostly stuck at max frequency during idle . This is because of the
>> > watchdog timer, an RT task which is fired every 4 seconds which
>> > results in requesting max frequency.
>>
>> Well, yes, that would be problematic.
>>
>
> Right; we need to come up with something for RT tasks;

I think we need the hints thing for that to be able to distinguish
between RT and the rest.

Also in this particular case it looks like an RT task is the only task
that wakes up often enough and we don't drop the frequency when going
idle.  Do we need a hook somewhere in the idle path?
