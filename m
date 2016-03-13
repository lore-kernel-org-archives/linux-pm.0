From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 06/16] tools/power turbostat: allow sub-sec intervals
Date: Sun, 13 Mar 2016 03:57:56 -0400
Message-ID: <CAJvTdK=HFNHEVW6j-fDYCC1S_TkJKGqCCTd7v-3KL0aL3XWByQ@mail.gmail.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
	<24781860a144a6792cb7697307f36b4486b611da.1456563103.git.len.brown@intel.com>
	<001201d171da$22f11850$68d348f0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:32860 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcCMH56 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2016 03:57:58 -0400
Received: by mail-lb0-f195.google.com with SMTP id bc4so15647391lbc.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2016 23:57:57 -0800 (PST)
In-Reply-To: <001201d171da$22f11850$68d348f0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

Doug,

Thank you for closely reviewing these changes.

> Don't you also need to update these lines?:
>
> - .RB [ "\--interval seconds" ]
> + .RB [ "\--interval decimal_seconds" ]
>
> - The 5-second interval can be changed with th "-i sec" option.
> + The 5-second interval can be changed with the "--interval decimal_seconds" option.

You are right, this language became inconsistent.
Now that you've pointed it out, I think I like it the old way better
-- I've made them all
simply "seconds" (and the default is indicated as the decimal value 5.0)

>> +             nanosleep(&interval_ts, NULL);
>
> In the limit of a very high sampling rate, doesn't the assumption
> that the time spent in turbostat itself is negligible become
> invalid?
> And shouldn't the sleep time be compensated accordingly?

> Where total is the sample interval, in uSec, and begin was initialized
> somewhere outside this loop.
>
> Even if the time spent in turbostat is still almost negligible,
> this will prevent sampling time error accumulation, by sleeping just
> a little less every so often. However, there is also some extra
> overhead, which is also undesirable.

Turbostat isn't used to measure time, it just reports time.
So I think it is okay if the intervals drift.
There could be a lot of things that delay turbostat from running
exactly when its timeouts requested.

The important thing is that it accurately report for whatever
interval it does wake up on.

That said, you are right, for a very fast interval, the overhead
of turbostat itself becomes measurable.

The problem that I've observed is that on a very large
systems (eg. well over 100 processors), the timestamp taken
on the 1st processor is getting somewhat stale by the time
we get to the last processor.  For this reason it is on my list
to do per-cpu timetamps, which are taken when aperf/mperf
are taken.

When we get a vectored msr read inside the kernel, we can
shrink that overhead to mitigate its effect, however, I'll still
want to take a timestamp on each cpu.

thanks,
Len Brown, Intel Open Source Technology Center
