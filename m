From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 1 Apr 2016 11:15:03 -0700
Message-ID: <56FEBAA7.3050305@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan> <56F5E1F2.5090100@linaro.org>
 <CAJZ5v0j=LwOT=sjSOwwzY=sYLqiV1tuvVazzgU+yMwMWXmpR8A@mail.gmail.com>
 <CAJZ5v0i1=P45wWHYHVp9mW=h7w_MywFz7x2qmEs2iiEhJSq-5g@mail.gmail.com>
 <56F97548.1030903@linaro.org>
 <20160331122445.GJ3408@twins.programming.kicks-ass.net>
 <CAJZ5v0j6eDmvVSBphvygA2Xnk9nQXqracFR+dBYz3UOeyrb7qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34815 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbcDASPG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 14:15:06 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so96457578pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2016 11:15:06 -0700 (PDT)
In-Reply-To: <CAJZ5v0j6eDmvVSBphvygA2Xnk9nQXqracFR+dBYz3UOeyrb7qA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/31/2016 05:32 AM, Rafael J. Wysocki wrote:
> On Thu, Mar 31, 2016 at 2:24 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Mon, Mar 28, 2016 at 11:17:44AM -0700, Steve Muckle wrote:
>>> The scenario I'm contemplating is that while a CPU-intensive task is
>>> running a thermal interrupt goes off. The driver for this thermal
>>> interrupt responds by capping fmax. If this happens just after the tick,
>>> it seems possible that we could wait a full tick before changing the
>>> frequency. Given a 10ms tick it could be rather annoying for thermal
>>> management algorithms on some platforms (I'm familiar with a few).
>>
>> So I'm blissfully unaware of all the thermal stuffs we have; but it
>> looks like its somehow bolten onto cpufreq without feedback.
>>
>> The thing I worry about is thermal scaling the CPU back past where RT/DL
>> tasks can still complete in time. It should not be able to do that, or
>> rather, missing deadlines because thermal is about as useful as
>> rebooting the device.

I'd agree that impacting RT/DL activity because of throttling may be as
bad as as a reset, but that seems worst case. There could be some
graceful shutdown or notification/alarm that can be done. Or a platform
can simply choose to reset.

Shouldn't we try to give the system designer the option of doing
something in software (by throttling the CPUs as low as necessary to
continue operation) rather than giving up and relying on a hardware reset?

> Right.  If thermal throttling kicks in, the game is pretty much over.
> 
> That's why ideas float about taking the thermal constraints into
> account upfront, but that's a different discussion entirely.

Current mainstream mobile platforms frequently throttle during normal
operation. I think it's important to have a robust throttling mechanism
at least until the more proactive thermal management scheme is fully
developed and proves to be equally capable (if and when that happens).

>> I guess I'm saying is, the whole cpufreq/thermal 'interface' needs work
>> anyhow.
> 
> Yes, it does.

Agreed!

thanks,
Steve

