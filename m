From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter() failures
Date: Wed, 13 May 2015 17:13:27 -0700
Message-ID: <CAMAWPa_69wXtOAKkerLcXN3AcCMC7oBCH_K3MQ-A7A8nmXQzfQ@mail.gmail.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
	<2919083.VPTOth98op@vostro.rjw.lan>
	<7h7fsc2idw.fsf@deeprootsystems.com>
	<1842725.60y5FMGEPh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48171 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbbENANd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 May 2015 20:13:33 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7B2044C
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2015 00:13:32 +0000 (UTC)
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com [209.85.212.181])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 47F312043C
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2015 00:13:29 +0000 (UTC)
Received: by wizk4 with SMTP id k4so219890907wiz.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 17:13:27 -0700 (PDT)
In-Reply-To: <1842725.60y5FMGEPh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rlippert@google.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, May 13, 2015 at 5:16 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 13, 2015 03:59:55 PM Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>
>> [...]
>>
>> > Second, quite honestly, I don't see a connection to genpd here.
>>
>> The connection with genpd is because the *reason* the timer was
>> shutdown/stopped is because it shares power with the CPU, which is why
>> the timer stops when the CPU hits ceratin low power states.  IOW, it's
>> in the same power domain as the CPU.
>
> Well, what if you don't have genpd on that system?  Is the problem at hand not
> relevant then magically?

Well, if you're not using genpd to model hardware power domain
dependencies, then yes you'll definitely need a different solution.

And, as we discussed on IRC.  If you only care about timers, and genpd
is not in use, then $SUBJECT series is a fine approach, and I have no
objections.  But for SoCs where there are several other things that
share power with CPU, we need a more generic, genpd based solution,
which it seems we're in agreement on.  And since the two approaches
are not mutually exclusive, then I have real objections to applying
this series.

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
