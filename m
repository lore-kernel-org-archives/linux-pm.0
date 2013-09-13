From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 206/228] cpufreq: sa11x0: remove calls to
	cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 17:26:43 +0100
Message-ID: <20130913162643.GF12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <6e2ca86ce948c0bc35f7709baf22672771fcf1e8.1379063063.git.viresh.kumar@linaro.org> <20130913155424.GB12758@n2100.arm.linux.org.uk> <CAKohpomAj0wDnjdi7XXw=bGsu0LMRrr1SMwdzBsa0GTxGrABoQ@mail.gmail.com> <20130913161527.GE12758@n2100.arm.linux.org.uk> <CAKohpomBdAgciTYnQPn6fKC7iHvuBxFLiK8kCz62q7jRHhXK1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54692 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab3IMQ0z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 12:26:55 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomBdAgciTYnQPn6fKC7iHvuBxFLiK8kCz62q7jRHhXK1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 13, 2013 at 09:52:31PM +0530, Viresh Kumar wrote:
> On 13 September 2013 21:45, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The patch to which I'm replying removes the above calls.  These calls are
> > necessary to shutdown various bits of CPU-clock dependent hardware
> > before changing the CPU clock, and restore them - reconfiguring them
> > for the new clock rate after the transition has happened.
> >
> > So, if you're removing these calls, what replaces them?  I don't see
> > anything which does without the above set.
> 
> The other patch on which you commented about unnecessary read
> locks being taken:
> 
> [PATCH 181/228] cpufreq: move freq change notifications to cpufreq
> 
> That calls these notifiers, for all platforms except the ones that have
> set CPUFREQ_ASYNC_NOTIFICATION, before and after calling
> ->target_index()..
> 
> And so functionally the code is supposed to be the same.. Unless I
> have done some stupid mistake..

Ah, sorry, read that that test the other way around.  In that case,
this patch is fine and can have my ack as per the other acks I've
already given.

Thanks.
