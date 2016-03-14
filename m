From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 16:21:07 +0100
Message-ID: <CAJZ5v0iuLP6b3LHY_BVmAQ12qeeVWhVUPnBh=F4-nFuFr_73DQ@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<97183685.ubU62sp0PR@vostro.rjw.lan>
	<001001d17cfc$67721e70$36565b50$@net>
	<3851575.bLxYIFy0zG@vostro.rjw.lan>
	<001901d17dbc$3788f060$a69ad120$@net>
	<CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
	<1457965862.8898.4.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35381 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965405AbcCNPVJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 11:21:09 -0400
Received: by mail-lb0-f180.google.com with SMTP id bc4so243418574lbc.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2016 08:21:08 -0700 (PDT)
In-Reply-To: <1457965862.8898.4.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Mon, Mar 14, 2016 at 3:31 PM, Rik van Riel <riel@redhat.com> wrote:
> On Mon, 2016-03-14 at 13:47 +0100, Rafael J. Wysocki wrote:
>>
>> Rik, I think what we can do is to put a constant limit on the exit
>> latency of C1 like in this patch.  I'm not sure if 2 is good enough,
>> though.  It can't be less than 2, because that's what the majority of
>> systems have, but maybe it can be greater?  Any ideas?
>
> From Doug's description, it sounds like the problem is not
> that we go into idle state 0 too often, but that sometimes
> we stay there too long.
>
> I wonder if it makes sense for idle state 0 to promote
> itself to idle state 1 after some amount of time?

That would be equivalent to setting up a timer to fire at the
promotion point, so the data->next_timer_us > 20 check sort of plays
the role of that (we go for polling only when we know there is a timer
to fire soon enough).

> Maybe something like 2x the exit latency (or target
> residency?) of C1?

If the goal is to avoid entering C1 if the exit latency is too high,
we should be checking the exit latency IMO.
