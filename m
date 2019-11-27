Return-Path: <SRS0=h+KV=ZT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90703C432C0
	for <linux-pm@archiver.kernel.org>; Wed, 27 Nov 2019 22:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A58D20870
	for <linux-pm@archiver.kernel.org>; Wed, 27 Nov 2019 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK0Waa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:30:30 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:55516 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Waa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 17:30:30 -0500
Received: from hp-x360n (wsip-72-215-210-42.oc.oc.cox.net [72.215.210.42])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Nb7n3CHwz1mJF;
        Wed, 27 Nov 2019 17:30:29 -0500 (EST)
Date:   Wed, 27 Nov 2019 14:30:28 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0gY2ebW7X+PbqL-Sr4Xe0i3x9c=DCyFH3Q9g49kxY7iKA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911271424160.2366@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com> <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher> <alpine.DEB.2.21.1911261102180.2714@hp-x360n>
 <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com> <alpine.DEB.2.21.1911261542430.2523@hp-x360n> <alpine.DEB.2.21.1911261819510.2523@hp-x360n> <CAJZ5v0gY2ebW7X+PbqL-Sr4Xe0i3x9c=DCyFH3Q9g49kxY7iKA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> > If all "ec_no_wakeup=1" actually does is silently ignore EC wakeup events,
> > then I'll stick with it.

> Yes, that's all it does.

Thanks.

BTW, I'm calling it on that patch- it's been working all day long. And with
ec_no_wakeup=1 no spurious wakeups, either:

----
$ fgrep "suspend e" /var/log/syslog
...
Nov 26 19:36:46 hp-x360n kernel: [  995.519483] PM: suspend entry (s2idle)
Nov 27 06:56:44 hp-x360n kernel: [41793.786663] PM: suspend exit
----

Sadly I lost ~9% battery over that period due to "modern" suspend, but at least
it's been cool the last few times I've taken it out of the bag. Wish I could
find out what's left powered up, though.

And finally, last questions about the EC:

- Is it possible to query it once it's awakened the system to find out exactly why?

- Is it possible to have the EC mask/ignore certain of those reasons?

Thanks for all your hard work,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
