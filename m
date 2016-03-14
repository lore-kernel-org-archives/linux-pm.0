From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 23:55:51 +0100
Message-ID: <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<97183685.ubU62sp0PR@vostro.rjw.lan>
	<001001d17cfc$67721e70$36565b50$@net>
	<3851575.bLxYIFy0zG@vostro.rjw.lan>
	<001901d17dbc$3788f060$a69ad120$@net>
	<CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
	<1457965862.8898.4.camel@redhat.com>
	<CAJZ5v0iuLP6b3LHY_BVmAQ12qeeVWhVUPnBh=F4-nFuFr_73DQ@mail.gmail.com>
	<1457977512.8898.13.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36466 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcCNWzx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 18:55:53 -0400
Received: by mail-lb0-f178.google.com with SMTP id x1so259362453lbj.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2016 15:55:52 -0700 (PDT)
In-Reply-To: <1457977512.8898.13.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Mon, Mar 14, 2016 at 6:45 PM, Rik van Riel <riel@redhat.com> wrote:
> On Mon, 2016-03-14 at 16:21 +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 14, 2016 at 3:31 PM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > Maybe something like 2x the exit latency (or target
>> > residency?) of C1?
>>
>> If the goal is to avoid entering C1 if the exit latency is too high,
>> we should be checking the exit latency IMO.
>
> I agree with that, but doesn't the current code already
> do that?

For reference, here's what the current code does:

        data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
        /*
         * We want to default to C1 (hlt), not to busy polling
         * unless the timer is happening really really soon.
         */
        if (interactivity_req > 20 &&
            !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
            dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
            data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

> The code currently checks against both the latency_req
> and the expected sleep time. What is the rationale for
> adding another latency to check against?

Yes, it does check that in the main selection loop, but the check here
(and in question) is special.

If we end up using last_state_idx == 0 (polling), C1 will still be
considered in the main selection loop and it will be selected if it
satisfies all of the conditions.

If we use last_state_idx == CPUIDLE_DRIVER_STATE_START here, however,
C1 won't be looked at again in the main selection loop, so the check
here is to see whether or not to use C1 even if it *does* *not*
satisfy all of the normal conditions.

Granted, it generally is beneficial to use C1 rather than polling
unless C1 is hopelessly slow and that is visible in the Doug's
results.  Also granted, the way that piece of code worked before was
too aggressive, because it didn't take the "C1 may be hopelessly slow"
part into account at all.

> I am trying to understand what the goal is here, and
> under what circumstances the logic in the main selection
> loop needs to be overridden.
>
> What is the main selection loop doing wrong?
>
> When is it causing bad outcomes?
>
> Is it causing other bad outcomes beyond C0/C1 selection?
>
> Can we just ignore polling and always go to HLT, leaving
> out this (somewhat kludgy feeling) part of the code?

Len tells me that this would have hurt performance.

> If HLT is sometimes too slow on Atom, is it also too slow
> for certain workloads on faster CPUs? (say 10Gbps ethernet?)

Right.

> A lot of the logic (especially the load correction) in
> menu.c was last fine tuned before several bugs in the
> corresponding measuring code were fixed.
>
> I don't understand your patch well enough to object to
> it, but the "start the loop at poll instead of HLT"
> logic is becoming rather convoluted...

That logic has been there for quite a while, though.

Really, the choice is between a simple revert of commit
a9ceb78bc75ca47972096372ff3d48 and doing something in addition to it
to mitigate the "C1 is hopelessly slow" issue.
