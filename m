From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Questions about sleep states on ARM Juno R0
Date: Tue, 15 Mar 2016 14:14:32 +0000
Message-ID: <CAPKp9uZ28sYvAsz2H2gid=_DStcFrRnVw70mYDkHUAcXJZy9Bw@mail.gmail.com>
References: <56E80519.1040400@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:32808 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbcCOOOe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 10:14:34 -0400
Received: by mail-io0-f178.google.com with SMTP id n190so25350770iof.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 07:14:33 -0700 (PDT)
In-Reply-To: <56E80519.1040400@bsc.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nishtala <rajiv.nishtala@bsc.es>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>

Hi Rajiv,

On Tue, Mar 15, 2016 at 12:50 PM, nishtala <rajiv.nishtala@bsc.es> wrote:
>
> In response to the discussion here (https://community.arm.com/thread/9382).
> I'm continuing my follow-up question.
>
> Sudeep here says to read the sysfs files to get usage/time to understand the
> sleep-state residency of the cores/cluster.
>
> To look at the sysfs files, I wrote a version of a watchdog which
> essentially prints out the difference in "usage", if
> it changes in the last 0.01s (it is a LARGE interval relative to update
> period of sysfs files).
>
> The questions I have are the following:
> - When the system is idle, that is, no user initiated tasks are running; I
> expected the counter for "usage" in CLUSTER_SLEEP_0 to remain constant,
> because you don't exit
> until any kernel interrupts occur, and is guaranteed to stay atleast for
> 3500us while the "time" in the same category to increase.
>

Are you not seeing any increase in interrupt count on that cpu where
CLUSTER_SLEEP_0 usage is increasing. Also there's not guarantee that
it will stay in  CLUSTER_SLEEP_0 for 3500us, it can be woken up by interrupts.

> However, what I notice is that "usage" ALSO increases, which is something I
> do not understand.
>

Check the interrupt count, you must see that also increasing.

> - When I run an application only on small OR big cores, the counter "usage"
> for CPU_SLEEP_0 on the other type of core (big/small) still isn't updated.
> Am I missing something here?
>

Is this a question or your observation ? You are assuming that only your
applications will be running ? It depends also on several background tasks
that are running.

> - Similarly, when I have an application that does only computations on both
> big AND small cores simultaneously, how come the counter, "usage", for
> CLUSTER_SLEEP_0 increases?
> Shouldn't it remain constant?
>

Again, when your application is running doesn't mean it's continuously runs
from start to end. It will interrupted when it yields the cpu or waits
on some IO.
During that short periods the cpus can enter idle states.

> - How come value of "CLUSTER_SLEEP_0" (on a57 cluster) increases when there
> is actually something running on it. How is it computed?
>

Ditto as above.

[...]

> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>

You need to fix this, please get rid of this disclaimer if you want people to
respond to you.
