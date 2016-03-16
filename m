From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 16:09:15 +0100
Message-ID: <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
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
	<CAJZ5v0h2YDHHt1XL3Y5UiA6dAEDtzNSOGn+Fd-ph70fhvW1AZw@mail.gmail.com>
	<1458140836.14723.30.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36384 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbcCPPJR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 11:09:17 -0400
Received: by mail-lf0-f46.google.com with SMTP id l83so21592457lfd.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 08:09:16 -0700 (PDT)
In-Reply-To: <1458140836.14723.30.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Wed, Mar 16, 2016 at 4:07 PM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 2016-03-16 at 16:05 +0100, Rafael J. Wysocki wrote:
>> On Wed, Mar 16, 2016 at 3:46 PM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > On Wed, 2016-03-16 at 15:14 +0100, Rafael J. Wysocki wrote:
>> > >
>> > > On Wed, Mar 16, 2016 at 3:01 PM, Rik van Riel <riel@redhat.com>
>> > > wrote:
>> > > >
>> > > >
>> > > > On the other hand, being more aggressive about C1 allows
>> > > > other cores to run at higher frequencies...
>> > > Good point.
>> > >
>> > > We need to decide, though.
>> > >
>> > > Do we generally want to use more polling or more C1?
>> > I can see five distinct data points for decision making:
>> >
>> > 1) data->next_timer_us where we know for sure the sleep
>> >    interval will be less than C1 latency -> poll
>> Almost right, modulo my previous comment: that should be the sum of
>> C1
>> exit latency and C1 target residency.
>
> Doesn't the residency include the exit latency?
>
> After all, we subtract the exit latency from the
> measured residency time in menu_update.

Yes, it does, sorry.  So it should be the target residency. :-)

>> > Would you like me to write a patch to take the user
>> > configured latency_req into account, separate out
>> > the predicted_us and typical_interval, and test whether
>> > to poll against the smaller of next_timer_us, latency_req,
>> > and the typical_interval, while we continue to use the
>> > predicted_us as is in the main selection loop?
>> Yes, please.
>
> Will do.

Cool, thanks!
