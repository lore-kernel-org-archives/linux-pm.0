From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Wed, 16 Jul 2014 21:02:29 +0530
Message-ID: <CAKohpok6-_7aQ1RxSJKLo1idc777LHWLVM=tjtTLOzZjeAUpjw@mail.gmail.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
	<20140716160256.7e8dbccf@free-electrons.com>
	<CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
	<20140716172811.2289a64c@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45331 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933938AbaGPPc3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 11:32:29 -0400
Received: by mail-ob0-f172.google.com with SMTP id wn1so1108617obc.17
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 08:32:29 -0700 (PDT)
In-Reply-To: <20140716172811.2289a64c@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On 16 July 2014 20:58, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> I guess you meant 3.17, right?

Yeah, sorry.

> Would be good to have this soon, since the 3.17 merge window is
> approaching. You asked me to use this cpufreq-generic driver instead of
> a custom cpufreq driver, and I did the work to do that. So now I clearly
> hope that cpufreq-generic will be merged in 3.17.

Yeah, I have already pinged Rafael few days back on this. He came back
from holidays last week and this is what he told me:

Jul 11 19:58:34 <vireshk> rafael, when are you going to pick stuff for 3.17?
Jul 11 19:59:11 <rafael> vireshk: next week i suppose


Do you depend on this patch btw?

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg675398.html

Actually there had been some objections to comparing clocks this way and
we *might* hold this off, unless the bindings are finalized. Will get all other
patches merged though.
