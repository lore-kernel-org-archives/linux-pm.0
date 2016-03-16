From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 16:05:38 +0100
Message-ID: <CAJZ5v0h2YDHHt1XL3Y5UiA6dAEDtzNSOGn+Fd-ph70fhvW1AZw@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	<1458007395.8898.19.camel@redhat.com>
	<2600831.Qfymhh5Hpv@vostro.rjw.lan>
	<1458089721.8898.25.camel@redhat.com>
	<CAJZ5v0iC2CUKRJokVL5xsbebOPzxNUzXxzo8hxRvm-Y=0v_LQg@mail.gmail.com>
	<CAJZ5v0hDGmReO9KQrofSu3K25xzP08yo+qqgLiEHejKrSXEy4w@mail.gmail.com>
	<20160316100144.75bfef53@annuminas.surriel.com>
	<CAJZ5v0iz87xKYFV_wiJgppfiCWt7uQGXyrQhoxpZ3E7GBhA5_A@mail.gmail.com>
	<1458139600.14723.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34675 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966832AbcCPPFk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 11:05:40 -0400
Received: by mail-lf0-f51.google.com with SMTP id e138so20648769lfe.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 08:05:39 -0700 (PDT)
In-Reply-To: <1458139600.14723.29.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Wed, Mar 16, 2016 at 3:46 PM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 2016-03-16 at 15:14 +0100, Rafael J. Wysocki wrote:
>> On Wed, Mar 16, 2016 at 3:01 PM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > On the other hand, being more aggressive about C1 allows
>> > other cores to run at higher frequencies...
>> Good point.
>>
>> We need to decide, though.
>>
>> Do we generally want to use more polling or more C1?
>
> I can see five distinct data points for decision making:
>
> 1) data->next_timer_us where we know for sure the sleep
>    interval will be less than C1 latency -> poll

Almost right, modulo my previous comment: that should be the sum of C1
exit latency and C1 target residency.

> 2) latency_req as configured by the user, if this is
>    smaller than C1
> latency we need poll  (we currently
>    get this wrong)

Correct.

> 3) interval determined by get_typical_interval, this we
>    may know with a higher confidence value, and choosing
>    poll may actually be appropriate

Right.

> 4) data->predicted_us corrected only by bucket correction
>    factor - this is a gamble, so we probably want C1,
>    even if data->predicted_us is low

Agreed.

> 5) interactivity_req, which is data->predicted_us
>    divided by a load factor - we should probably ignore
>    that for poll since it is way too aggressive, and
>    stick to C1 and deeper for this factor

Agreed.

> Does the above make sense?

Yes, it does.

> Currently the code merges (3) and (4) into the same
> value before making a comparison, and neglects to take
> (2) into account at all when deciding whether to poll.
>
> Would you like me to write a patch to take the user
> configured latency_req into account, separate out
> the predicted_us and typical_interval, and test whether
> to poll against the smaller of next_timer_us, latency_req,
> and the typical_interval, while we continue to use the
> predicted_us as is in the main selection loop?

Yes, please.
