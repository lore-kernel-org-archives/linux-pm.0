From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem to
 be held for duration of changing governors [v2]
Date: Tue, 5 Aug 2014 12:13:59 +0530
Message-ID: <CAKohponNEpppfoZrbDZmdwXnPukzozOSw8YF1qDKNr7iJkZSqg@mail.gmail.com>
References: <1406634362-811-1-git-send-email-prarit@redhat.com>
	<2066166.pXm4lKLOID@vostro.rjw.lan>
	<53DA8389.80804@redhat.com>
	<1917362.abr2Y4p7vh@vostro.rjw.lan>
	<53DA8A41.2030601@redhat.com>
	<53DAA60B.6040802@codeaurora.org>
	<53DAA749.5080506@redhat.com>
	<53DAA95B.2040505@codeaurora.org>
	<53DAB038.3050007@redhat.com>
	<53DABFA6.6090503@codeaurora.org>
	<53DACA26.1000908@redhat.com>
	<53DAE592.2030909@codeaurora.org>
	<53DB6B81.6050400@redhat.com>
	<53DBCBE8.6010809@codeaurora.org>
	<CAKohpom0KycrB8qJDM7yEOHOn76J1sEe90CG+JXERJMcxKnOJA@mail.gmail.com>
	<53DF7BC4.9070500@redhat.com>
	<CAKohpomEQ__Q4xTaBgHJyE0Meu4au-cXKCAKCqHWTHLRL+R5OA@mail.gmail.com>
	<53DFEA25.5070206@codeaurora.org>
	<CAKohpo=VJJFxKo5hNH3GNOZpjeHBc9fWORD9h7SThaFtkM__FA@mail.gmail.com>
	<3848ac8b087052a65d890dcfe17e3af8.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:60718 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948AbaHEGn7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Aug 2014 02:43:59 -0400
Received: by mail-oa0-f44.google.com with SMTP id eb12so359474oac.31
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2014 23:43:59 -0700 (PDT)
In-Reply-To: <3848ac8b087052a65d890dcfe17e3af8.squirrel@www.codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?Um9iZXJ0IFNjaMODwrZuZQ==?= <robert.schoene@tu-dresden.de>

On 5 August 2014 11:59,  <skannan@codeaurora.org> wrote:
> Looks like Srivatsa has gone off the grid too. I'm hoping at least one of
> you can do a review of my series. Come on guys, not everyone has to work
> on the same patch/issue. :-(

Srivatsa is currently going through some personal stuff. He is joining MIT
for his Masters/Phd and so would be moving to US soon :)
