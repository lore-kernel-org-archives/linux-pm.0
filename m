From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression caused by bb6ab52f2bef ("intel_pstate: Do not set
 utilization update hook too early")
Date: Sat, 25 Jun 2016 02:03:37 +0200
Message-ID: <CAJZ5v0j5Jdi-JtEXKT-K7GFp+QHPqWgKJ1SmwS6XgEp4=axJkg@mail.gmail.com>
References: <20160617163023.5bb374f8@xhacker> <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com> <20160617140353.GQ30154@twins.programming.kicks-ass.net>
 <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com> <001501d1cd69$5880c7f0$098257d0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38181 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbcFYADj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 20:03:39 -0400
In-Reply-To: <001501d1cd69$5880c7f0$098257d0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Jisheng Zhang <jszhang@marvell.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Thu, Jun 23, 2016 at 6:07 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.06.17 08:32 Jisheng Zhang wrote:
>
>> Second, sorry again for report incorrect commit,
>> I were too tired this morning so I remember the wrong commit.
>> The regression is caused by bb6ab52f2bef ("intel_pstate: Do not
>> set utilization update hook too early"), so I update the email title.
>
> Summary:
>
> Isn't running powertop itself a significant contributor here?

It shouldn't be, because the overhead in question comes from
->setpolicy and powertop itself should not cause it to be invoked that
often.

Thanks,
Rafael
