From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 01:38:04 +0200
Message-ID: <1703157.S2GHVxrQk4@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net> <1578637.1XJQpJurXn@aspire.rjw.lan> <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61253 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbdGOXpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 19:45:51 -0400
In-Reply-To: <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sunday, July 16, 2017 01:34:53 AM Mason wrote:
> On 16/07/2017 01:24, Rafael J. Wysocki wrote:
> 
> > On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
> >
> >> The enum offers the advantage of centralizing how many different states
> >> exist for all the platforms we know about in the kernel, it's easy to
> >> define common values for platforms that have the same semantics, just
> >> like it's simple to add new values for platform specific details.
> > 
> > Well, you seem to be liking this, so why don't you just implement it?
> 
> At the end of his message, Florian wrote:
> 
> > In any case, just agree and I will be happy to follow-up with patches.

But it may be hard to convince everybody without posting code changes
and often enough showing a patch makes a good argument.

Thanks,
Rafael
