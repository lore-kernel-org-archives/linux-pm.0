From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with "dynamic_switching"
Date: Sat, 15 Jul 2017 00:06:24 +0200
Message-ID: <2309380.IRBF8BkiFH@aspire.rjw.lan>
References: <cover.1499853492.git.viresh.kumar@linaro.org> <20170714070142.GA14515@isilmar-4.linta.de> <CAJZ5v0hagTXFmV94abxeEL5=dPn0FQtW7SogyK6iJd6ika+GUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46997 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751132AbdGNWOK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 18:14:10 -0400
In-Reply-To: <CAJZ5v0hagTXFmV94abxeEL5=dPn0FQtW7SogyK6iJd6ika+GUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, July 14, 2017 01:11:58 PM Rafael J. Wysocki wrote:
> On Fri, Jul 14, 2017 at 9:01 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > On Thu, Jul 13, 2017 at 06:19:53PM +0200, Rafael J. Wysocki wrote:
> >> On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> > There is no limitation in the ondemand or conservative governors which
> >> > disallow the transition_latency to be greater than 10 ms.
> >> >
> >> > The max_transition_latency field is rather used to disallow automatic
> >> > dynamic frequency switching for platforms which didn't wanted these
> >> > governors to run.
> >> >
> >> > Replace max_transition_latency with a boolean (dynamic_switching) and
> >> > check for transition_latency == CPUFREQ_ETERNAL along with that. This
> >> > makes it pretty straight forward to read/understand now.
> >>
> >> Well, using CPUFREQ_ETERNAL for that on the driver side is still not
> >> particularly straightforward IMO, so maybe add a
> >> "no_dynamic_switching" to the driver structure and set it to "true"
> >> for the one driver in question?
> >
> > IIRC it's not just one driver which sets the latency to CPUFREQ_ETERNAL, and
> > where dynamic switching might be harmful or at least lead to undefined
> > behavior.
> 
> OK
> 
> Still, though, using CPUFREQ_ETERNAL to indicate the "no dynamic
> switching" condition is somewhat convoluted, so why don't we have a
> flag to *explicitly* say that instead?
> 
> Do you know which drivers they are or is it just all drivers that use
> CPUFREQ_ETERNAL?

Well, after the $subject patch it effectively is all drivers that use
CPUFREQ_ETERNAL anyway, so it looks like we actually can do a complete
switch-over.

Thanks,
Rafael
