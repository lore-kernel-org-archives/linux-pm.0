From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 15:14:24 +0100
Message-ID: <CAJZ5v0iz87xKYFV_wiJgppfiCWt7uQGXyrQhoxpZ3E7GBhA5_A@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	<1458007395.8898.19.camel@redhat.com>
	<2600831.Qfymhh5Hpv@vostro.rjw.lan>
	<1458089721.8898.25.camel@redhat.com>
	<CAJZ5v0iC2CUKRJokVL5xsbebOPzxNUzXxzo8hxRvm-Y=0v_LQg@mail.gmail.com>
	<CAJZ5v0hDGmReO9KQrofSu3K25xzP08yo+qqgLiEHejKrSXEy4w@mail.gmail.com>
	<20160316100144.75bfef53@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35504 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964AbcCPOO0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:14:26 -0400
Received: by mail-lb0-f179.google.com with SMTP id bc4so48847153lbc.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 07:14:26 -0700 (PDT)
In-Reply-To: <20160316100144.75bfef53@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Wed, Mar 16, 2016 at 3:01 PM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 16 Mar 2016 14:02:33 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> My concern here is that this might defeat the original purpose of
>> commit a9ceb78bc75c, though, because it would make us use C1 more
>> aggressively in general on everything where the sum of C1 exit latency
>> and C1 target residency is less than 20.
>
> I just got this email from the test robot this morning.
>
> Apparently the test patch I sent to Arto results in a 6.5%
> improvement on blogbench, so there is a performance benefit
> to polling when we expect short sleeps (not just a short
> timer timeout, but corrected for typical interval, etc).

That's not unexpected. :-)

However, question is whether or not that offsets the increased energy
consumption.  The entire point of using C1 as the fallback state
instead of polling is the observation that polling is too costly
energetically overall to be used as the fallback state
unconditionally.

> On the other hand, being more aggressive about C1 allows
> other cores to run at higher frequencies...

Good point.

We need to decide, though.

Do we generally want to use more polling or more C1?
