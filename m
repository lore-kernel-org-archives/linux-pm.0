From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
Date: Mon, 27 Jun 2016 15:49:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606271540000.2550@knanqh.ubzr>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35282 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbcF0Ttx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 15:49:53 -0400
Received: by mail-qk0-f181.google.com with SMTP id a125so24551024qkc.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 12:49:53 -0700 (PDT)
In-Reply-To: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 27 Jun 2016, Bartlomiej Zolnierkiewicz wrote:

> Hi,
> 
> It seems that in mainline kernel big.LITTLE switcher support
> may be usable only on ARM Versatile Express TC2 platform
> (but even this platform doesn't enable it in its defconfig).

It is also used on some Samsung targets.

> The following patchset removes big.LITTLE switcher support
> (from both ARM core and arm_big_little CPUfreq driver) in
> favor of using HMP.
> 
> Since HMP support at scheduler level is not yet merged this
> patchset is probably premature and thus is marked as RFC.

It is premature indeed.

And before this is removed, comparison with power/performance benchmark 
numbers will have to be provided as well to justify this removal.  At 
the moment there is nothing else in mainline that can achieve what this 
code does.

We all agree that the scheduler based solution is the best way to do it. 
But this has been a couple years already and this is still work in 
progress.


Nicolas
