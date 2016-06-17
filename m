From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression caused by bb6ab52f2bef ("intel_pstate: Do not set
 utilization update hook too early")
Date: Fri, 17 Jun 2016 17:40:38 +0200
Message-ID: <CAJZ5v0jEf0rYZMqL_x8aHaNo4RwAJGqSToO4VxRL7hfsv7BEfg@mail.gmail.com>
References: <20160617163023.5bb374f8@xhacker> <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com> <20160617140353.GQ30154@twins.programming.kicks-ass.net>
 <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38040 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcFQPkk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 11:40:40 -0400
In-Reply-To: <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jun 17, 2016 at 5:32 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Hi all,
>
> First of all, sorry for top post, only webmail is available now.
>
> Second, sorry again for report incorrect commit, I were too tired this morning so I remember the wrong commit.  The regression is caused by bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too early"), so I update the email title.

OK, that makes much more sense. :-)

And

4578ee7e1def intel_pstate: Avoid unnecessary synchronize_sched()
during initialization

is not sufficient I suppose?
