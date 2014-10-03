From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RFC] sched,idle: teach select_idle_sibling about idle
 states
Date: Fri, 03 Oct 2014 08:04:23 +0200
Message-ID: <1412316263.5149.9.camel@marge.simpson.net>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org>
	 <1409844730-12273-3-git-send-email-nicolas.pitre@linaro.org>
	 <542B277D.7050103@redhat.com>
	 <alpine.LFD.2.11.1409301904150.5311@knanqh.ubzr>
	 <20141002131548.6cd377d5@cuia.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38455 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbaJCGE2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Oct 2014 02:04:28 -0400
In-Reply-To: <20141002131548.6cd377d5@cuia.bos.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On Thu, 2014-10-02 at 13:15 -0400, Rik van Riel wrote:

> This patch is ugly. I have not bothered cleaning it up, because it
> causes a regression with hackbench. Apparently for hackbench (and
> potentially other sync wakeups), locality is more important than
> idleness.
> 
> We may need to add a third clause before the search, something
> along the lines of, to ensure target gets selected if neither
> target or i are idle and the wakeup is synchronous...
> 
>     if (sync_wakeup && cpu_of(target)->nr_running == 1)
> 	return target;

I recommend you forget that trusting sync hint ever sprang to mind, it
is often a big fat lie.

-Mike

