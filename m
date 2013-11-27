From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Wed, 27 Nov 2013 15:22:01 +0100
Message-ID: <4759452.7dXrrSTGCc@vostro.rjw.lan>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org> <2309056.KUZA1Fnj0Y@vostro.rjw.lan> <CAKohpokjAuUA-o4cJi=N7mO93kTwrmfVqtL-zOHAs6awKoXn1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59763 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756502Ab3K0OJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2013 09:09:13 -0500
In-Reply-To: <CAKohpokjAuUA-o4cJi=N7mO93kTwrmfVqtL-zOHAs6awKoXn1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>

On Wednesday, November 27, 2013 08:31:02 AM Viresh Kumar wrote:
> On 27 November 2013 01:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I was talking about the case when your
> >
> > __cpufreq_driver_target(policy, policy->cur - 1, CPUFREQ_RELATION_L);
> >
> > fails.  The other case is not really interesting.
> 
> Okay.. I actually thought the context of this chat is about "not fixing the
> frequency silently". That's what Dirk pointed out, if I am not wrong.

In that case you can simply print a message bashing the boot loader. :-)

> And hence I also support the new pr_warn I have added in those cases.

Sure.

> But yes a WARN_ON() can be printed out in case
> __cpufreq_driver_target() fails.

And here my question was: Is it safe to continue at all in that case?

Rafael

