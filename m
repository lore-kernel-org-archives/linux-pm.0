From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5 2/3] cpufreq: intel_pstate: account for non C0 time
Date: Sat, 5 Dec 2015 00:16:12 +0100
Message-ID: <CAJZ5v0iRdPkYWK69H7KYq8Zt3iMuobGhkiJwLBw7ZDrTrY9sFQ@mail.gmail.com>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
	<5661A41F.7050208@linux.intel.com>
	<1449250743.3240.94.camel@spandruv-desk3.jf.intel.com>
	<2560479.PPso1nSBcR@vostro.rjw.lan>
	<1449269306.3240.127.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34316 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbLDXQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 18:16:14 -0500
Received: by lbbcs9 with SMTP id cs9so28945835lbb.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Dec 2015 15:16:12 -0800 (PST)
In-Reply-To: <1449269306.3240.127.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Philippe Longepe <philippe.longepe@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephane Gasparini <stephane.gasparini@linux.intel.com>

On Fri, Dec 4, 2015 at 11:48 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Sat, 2015-12-05 at 00:01 +0100, Rafael J. Wysocki wrote:
>> On Friday, December 04, 2015 09:39:03 AM Srinivas Pandruvada wrote:
>> > On Fri, 2015-12-04 at 15:33 +0100, Philippe Longepe wrote:
>> > > Thank you Rafael,
>> > >
>> > > I'll try to sent a new patch set taking your remarks into account for
>> > > these series before tonight.
>> > >
>> > > Also, do you think we could have in some corner case a division by zero
>> > > when prev_tsc = tsc ?
>> > >
>> > > Normally it should never happen but just in case, I think we should
>> > > complete the following test:
>> > >
>> > > if ((cpu->prev_mperf == mperf) || (cpu->prev_tsc == tsc)) {
>> > > ...
>> > On Knight landing platform the first one is possible and second one
>> > should never happen. But this function will never be called for such
>> > platforms.
>>
>> Still, in case there's a future platform where those counters don't advance
>> for extended time intervals, would it really hurt to add a check for that
>> and skip the sample when it triggers?
> Doesn't hurt.

OK

Maybe checking the TSC would be overkill as there would be other
significant problems if it didn't advance, but IMO it would be good to
have a sanity check for the MPERF in there.

Thanks,
Rafael
