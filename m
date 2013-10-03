From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: make sure frequency transitions are serialized
Date: Thu, 3 Oct 2013 11:06:13 +0530
Message-ID: <CAKohponHLGsjTXA3XRRGM+CFpMrsgTuCx00YPrCbkST5drB-ng@mail.gmail.com>
References: <a0cad3326c6a6c8f0517332dd2230edaf67268e7.1378979483.git.viresh.kumar@linaro.org>
	<793a5fadad931d04c2adb3a61c64063b7e62d083.1378979483.git.viresh.kumar@linaro.org>
	<1791712.tJBFGgQvyI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:37400 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab3JCFgN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 01:36:13 -0400
Received: by mail-qc0-f180.google.com with SMTP id p19so1293000qcv.11
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 22:36:13 -0700 (PDT)
In-Reply-To: <1791712.tJBFGgQvyI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 26 September 2013 00:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> So the problem is real, but the fix seems to be of a "quick and dirty" kind.

Hmm..

> First of all, it looks like we need a clear "begin transition" call that
> I suppose drivers should execute from their .target() methods once they have
> decided to do a transition.  That would increment the "ongoing" counter etc.
>
> Second, we need a corresponding "end transition" call that would be executed
> whenever appropriate from the driver's perspective.

Hmm..

> Clearly, these two things should be independent of the notifiers and the
> notifications should only be done between "begin transition" and "end
> transition" and only by whoever called the "begin transition" to start with.

So, we need to have begin/end calls in cpufreq_out_of_sync() as well?
As that is sending notifications..

> Now, question is what should happen if "begin transition" is called when
> the previous transition hasn't been completed yet, should it block or should
> it fail?  There seem to be arguments for both, but I suppose blocking would be
> easier to implement.

Hmm.. I will repost this once my other patches are in now.. as that will
change ->target() routine for multiple drivers and things would be simple
to fix then..
