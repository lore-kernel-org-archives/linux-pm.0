From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 02:53:55 +0100
Message-ID: <CAJZ5v0iC2CUKRJokVL5xsbebOPzxNUzXxzo8hxRvm-Y=0v_LQg@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	<1458007395.8898.19.camel@redhat.com>
	<2600831.Qfymhh5Hpv@vostro.rjw.lan>
	<1458089721.8898.25.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35603 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbcCPBx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 21:53:56 -0400
Received: by mail-lb0-f180.google.com with SMTP id bc4so38631334lbc.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 18:53:56 -0700 (PDT)
In-Reply-To: <1458089721.8898.25.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Wed, Mar 16, 2016 at 1:55 AM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 2016-03-16 at 01:32 +0100, Rafael J. Wysocki wrote:
>>
>>                * We want to default to C1 (hlt), not to busy
>> polling
>> -              * unless the timer is happening really really soon.
>> +              * unless the timer is happening really really
>> soon.  Still, if
>> +              * the exit latency of C1 is too high, we need to
>> poll anyway.
>>                */
>> -             if (interactivity_req > 20 &&
>> +             if (data->next_timer_us > 20 &&
>> +                 drv-
>> >states[CPUIDLE_DRIVER_STATE_START].exit_latency <= 2 &&
>>                   !drv-
>
> I wonder if replacing these two tests with
>            data->next_timer_us
>> states[CPUIDLE_DRIVER_STATE_START].exit_latency
> would do the right thing?
>
> That way any time we do not know for sure we are waking
> up before the HLT exit latency has gone, we will poll.
>
> Any time we suspect we will wake up sooner (data->predicted_us
> is smaller than the HLT exit latency) we will still pick HLT,
> anyway.
>
> This makes the behaviour consistent between CPUs.

The idea makes sense to me, but I'd test against the sum of C1 exit
latency and C1 target residency, ie

data->next_timer_us > states[CPUIDLE_DRIVER_STATE_START].exit_latency
+ states[CPUIDLE_DRIVER_STATE_START].target_residency

because that's the time that has to pass before the next timer event
for us to make sense to go to C1 from the energy efficiency
perspective (if we are woken up earlier, we'll burn more energy that
we would if we didn't enter C1 at all, at least in theory).
