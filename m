From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sun, 30 Jun 2013 20:45:24 +0530
Message-ID: <CAKohpomKbGd0BxR-SQV7ose_zgb0-cmoMyMD84JdHBBr0szmBg@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	<51CF1E53.6060902@gmx.de>
	<8029836.CFiJCXmRQ0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:61076 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3F3PP1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2013 11:15:27 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so3981763oah.11
        for <linux-pm@vger.kernel.org>; Sun, 30 Jun 2013 08:15:24 -0700 (PDT)
In-Reply-To: <8029836.CFiJCXmRQ0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 30 June 2013 19:52, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, to be honest, I'm not really sure how the above commit can cause the
> problem you're seeing to happen ...
>
> Srivatsa, Viresh, any ideas?

I don't. But its very simple to get this checked isn't it?
Just revert this patch on top of your kernel (leave bisect) and
see if gets fixed.
