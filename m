From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Sat, 28 Sep 2013 14:33:43 -0700
Message-ID: <20130928213343.GA19582@linux.vnet.ibm.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
 <7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>
 <5243641B.6050604@linaro.org>
 <CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com>
 <5243EE02.9020207@linaro.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:39710 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab3I1Vds (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Sep 2013 17:33:48 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 28 Sep 2013 15:33:48 -0600
Content-Disposition: inline
In-Reply-To: <5243EE02.9020207@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Sep 26, 2013 at 10:19:14AM +0200, Daniel Lezcano wrote:
> On 09/26/2013 08:17 AM, Viresh Kumar wrote:
> >On 26 September 2013 04:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>If you introduce a list, you will have to introduce a lock to protect
> >>it.
> >
> >I missed it, should have added that :)
> >
> >>This lock will be in the fast path cpuidle_idle_call with the
> >>get_driver function and conforming to the comment: "NOTE: no locks or
> >>semaphores should be used here".
> >>
> >>A lock has been introduced in this function already and the system hangs
> >>with 1024 cpus.
> >
> >Hmm... I see.. I didn't knew about this expectation.. What about a rcu
> >read/write lock? As far as I know its too lightweight... Can we have that
> >in fast path?
> 
> Nope, we can't use rcu in the idle path :)
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/083054.html

But you should be able to use SRCU in the idle path, if that helps.

							Thanx, Paul

