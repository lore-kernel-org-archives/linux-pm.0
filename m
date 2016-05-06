From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 6 May 2016 13:49:52 +0200
Message-ID: <CAJZ5v0iSpuB58kQjVAJ_R73_yCmxaC7siKt9Gm8bZ2cOX1H5hw@mail.gmail.com>
References: <20160505234922.GA14673@sky.smuckle.net>
	<1961527.dEtpL4HAvs@vostro.rjw.lan>
	<1953902.drhraqW2It@vostro.rjw.lan>
	<20160506114627.GX3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32983 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758566AbcEFLty (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 07:49:54 -0400
In-Reply-To: <20160506114627.GX3430@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, May 6, 2016 at 1:46 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 06, 2016 at 02:25:16AM +0200, Rafael J. Wysocki wrote:
>> On Friday, May 06, 2016 02:09:07 AM Rafael J. Wysocki wrote:
>> > On Thursday, May 05, 2016 04:49:22 PM Steve Muckle wrote:
>> > > While working on a few patches for schedutil I noticed that the CFS
>> > > cpufreq hooks depend on PELT, which depends on CONFIG_SMP.
>
>> > For governors other than schedutil fixing that would be a matter of
>> > adding a !CONFIG_SMP variant of update_load_avg() that will call
>> > cpufreq_update_util() and do nothing else.  It doesn't matter what
>> > is passed via util and max then.
>>
>> Maybe something like the below, FWIW, as a quick fix for 4.6?
>
> Right; I suppose that'll have to do for 4.6.

OK, thanks!

I'll resend it with a changelog and stuff then.
