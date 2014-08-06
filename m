From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq_opp.c: Fixed the __might_sleep by changing GFP_KERNEL to GFP_ATOMIC.
Date: Wed, 06 Aug 2014 22:36:19 +0200
Message-ID: <1959694.afxgG1N4Rp@vostro.rjw.lan>
References: <1407183283-21921-1-git-send-email-moon.linux@yahoo.com> <CAKohpo=VQEtmSLE5-fQ8=zb-kkRYN8kZeaBPzMV5rF=WxxmeDg@mail.gmail.com> <20140806150227.GA32301@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51956 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753151AbaHFURi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Aug 2014 16:17:38 -0400
In-Reply-To: <20140806150227.GA32301@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Anand Moon <moon.linux@yahoo.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wednesday, August 06, 2014 08:02:27 AM Stephen Boyd wrote:
> On 08/06, Viresh Kumar wrote:
> > On 6 August 2014 05:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >> https://lkml.org/lkml/2014/7/16/815
> > >>
> > >> @Rafael: Have you already applied patch from above link?
> > >
> > > No, I haven't.  Do we need it after all?
> > 
> > I think yes, Right Stephen? :)
> 
> Yes.

OK, queued up for the next pull request, thanks!

