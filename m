From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 4 Jul 2013 13:34:45 +0530
Message-ID: <CAKohpom1KE=yxTi1HNoSn4cJ1mNpvZTeeVwK3A=4qSZ6Ut98gA@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	<51CF1E53.6060902@gmx.de>
	<8029836.CFiJCXmRQ0@vostro.rjw.lan>
	<51D05DF4.50704@linux.vnet.ibm.com>
	<51D06556.7080204@gmx.de>
	<51D47FB0.5090604@gmx.de>
	<51D51C63.2080702@linux.vnet.ibm.com>
	<CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com>
	<51D51F63.8080905@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:41968 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab3GDIEr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2013 04:04:47 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so1297588obc.10
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2013 01:04:46 -0700 (PDT)
In-Reply-To: <51D51F63.8080905@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 4 July 2013 12:38, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Coming to git bisect, I think it needs to be done between a66b2e5 + this-patch
> and 3.10 + this-patch, to ensure that we look for problematic commits in-between
> a66b2e5 and 3.10 (to avoid the bisect result ending up at a66b2e5 again).

Toralf,

Try reverting these patches in the order specified (revert both)
419e172145cf6c51d436a8bf4afcd17511f0ff79
c28375583b6471c1cb833a628ab6afb5b69079d0

They are touching ondemand governor and this may be creating some
problems. But I am not sure about it, I must admit.
