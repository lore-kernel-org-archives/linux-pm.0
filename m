From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/2] allow cpufreq drivers to export flags
Date: Wed, 08 Oct 2014 17:01:23 -0700
Message-ID: <20141009000123.4379.20957@quantum>
References: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
 <1412754534-14068-1-git-send-email-mturquette@linaro.org>
 <CAKohpo=9XG7XiLxBf=yo7=QCruawYxqPctC6kqB+syERFCoT6Q@mail.gmail.com>
 <20141008101115.1835927a@free-electrons.com>
 <CAKohpo=7VxrgdK9zPP89Px3aTiGhFihJ3uetC680fONDgE6O8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:42131 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaJIABa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 20:01:30 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so389283oig.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 17:01:29 -0700 (PDT)
In-Reply-To: <CAKohpo=7VxrgdK9zPP89Px3aTiGhFihJ3uetC680fONDgE6O8Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tuukka Tikkanen <tuukka.tikkan>

Quoting Viresh Kumar (2014-10-08 01:19:40)
> On 8 October 2014 13:41, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > On Wed, 8 Oct 2014 13:24:30 +0530, Viresh Kumar wrote:
> >> On 8 October 2014 13:18, Mike Turquette <mturquette@linaro.org> wrote:
> 
> >> > This series is partially in response to a discussion around DT bindings
> >> > for CPUfreq drivers [0], but it is also needed for on-going work to
> >> > integrate CPUfreq with the scheduler. In particular a scheduler-driven
> 
> > Well, when one has to merge a large number of changes, we often
> > recommend to merge them piece by piece, which is what Mike is trying to
> > do here. So we cannot at the same time ask developers to merge things
> > in small pieces that are easy to review and to merge everything
> > together because the users of a given API are not there yet.
> 
> From the wording of Mike it looks like:
> - This is required by cpufreq drivers - today
> - And this will also be useful for scheduler

Hi Viresh and Thomas,

Apologies if my wording was confusing. Without getting into a grammar
war, I did say that these patches were "in response" to this thread
(entirely accurate) and only necessary for the "on-going work" I'm doing
with the scheduler. Sorry if any of that came across as me stating that
these patches were necessary to solve Thomas' problem.

> 
> The first point doesn't stand true anymore. Lets wait for Mike's reply and
> see his opinion.
> 
> And then the patches are so small and there are no objections against
> them. I don't think getting them with the scheduler changes is that bad
> of an idea. In worst case, what if he has to redesign his idea? The new
> routines will stay without a caller then :)

Whether you merge the patches now or later is fine by me. I prefer to
get my patches out early and often so I can avoid any surprises later
on. If you have a fundamental objection to these patches then please let
me know. Otherwise it would be wonderful to have an Ack.

Thanks!
Mike

> 
> --
> viresh
