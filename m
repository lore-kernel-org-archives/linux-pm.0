From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] sched/idle : find the best idle CPU with cpuidle info
Date: Thu, 11 Sep 2014 00:50:34 +0200
Message-ID: <4753245.VagS0oaVYJ@vostro.rjw.lan>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org> <alpine.LFD.2.11.1409101734470.16533@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50472 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751803AbaIJWbF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 18:31:05 -0400
In-Reply-To: <alpine.LFD.2.11.1409101734470.16533@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Wednesday, September 10, 2014 05:35:27 PM Nicolas Pitre wrote:
> 
> Ping.

Is this urgent, and if so, then why?

> On Thu, 4 Sep 2014, Nicolas Pitre wrote:
> 
> > This is a rework of the series initially posted by Daniel Lezcano here:
> > 
> > http://news.gmane.org/group/gmane.linux.power-management.general/thread=44161
> > 
> > Those patches were straightened up, commit logs are more comprehensive,
> > bugs were fixed, etc.
> > 
> > 
> >  drivers/cpuidle/cpuidle.c |  6 ++++++
> >  kernel/sched/fair.c       | 43 ++++++++++++++++++++++++++++++++++-------
> >  kernel/sched/idle.c       |  6 ++++++
> >  kernel/sched/sched.h      | 39 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 87 insertions(+), 7 deletions(-)
> > 
> > 
> > Nicolas
> > 
> > 
> > _______________________________________________
> > linaro-kernel mailing list
> > linaro-kernel@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-kernel
> > 
> > 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
