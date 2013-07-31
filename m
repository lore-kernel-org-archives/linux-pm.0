From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
Date: Wed, 31 Jul 2013 12:30:45 +0200
Message-ID: <2244883.xRIZhTlqYe@vostro.rjw.lan>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org> <20130731014328.5270.4248@quantum> <CAKohpom-8KXixJ0ZbQ7Poh3uqJCqo7LFyYEfYeMyp+yZx9QmHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48694 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab3GaKUh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Jul 2013 06:20:37 -0400
In-Reply-To: <CAKohpom-8KXixJ0ZbQ7Poh3uqJCqo7LFyYEfYeMyp+yZx9QmHA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Wednesday, July 31, 2013 10:09:03 AM Viresh Kumar wrote:
> On 31 July 2013 07:13, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Viresh Kumar (2013-07-07 21:10:54)
> >> On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
> >> > Removes direct handling of OPP tables and voltage regulators by calling
> >> > of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
> >> > helper for voltage scaling".
> >> >
> >> > In the future this can help consolidate code found across similar
> >> > CPUfreq drivers.
> >> >
> >> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> >> > ---
> >> >  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
> >> >  1 file changed, 22 insertions(+), 103 deletions(-)
> >>
> >> Good patch, really gets lots of stuff out from cpufreq drivers.
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Viresh,
> >
> > Thanks for the Ack. I received no comments on this series besides your
> > own, so I plan to merge it. Do you want to take patch #3, or do you want
> > me to take it, or should I give you and Rafael a stable branch instead?
> 
> Its only related to cpufreq-cpu0 and to handle dependencies well they
> should go through a single tree.. Probably your tree is the right place for
> now. Rafael?

Yes, the entire series should go through the Mike's tree I think.

Thanks,
Rafael

