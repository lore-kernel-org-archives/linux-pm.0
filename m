From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Wed, 27 Nov 2013 21:21:55 +0100
Message-ID: <5408313.YdNvR1b3g5@vostro.rjw.lan>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org> <4759452.7dXrrSTGCc@vostro.rjw.lan> <CAKohpomXk34aaG3bKX9AuOcn7ZEXcKrc858jCUhcB2bavcnarQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53489 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757411Ab3K0UJG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2013 15:09:06 -0500
In-Reply-To: <CAKohpomXk34aaG3bKX9AuOcn7ZEXcKrc858jCUhcB2bavcnarQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>

On Wednesday, November 27, 2013 09:22:01 PM Viresh Kumar wrote:
> On 27 November 2013 19:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > And here my question was: Is it safe to continue at all in that case?
> 
> Hmm.. Honestly speaking I haven't thought about it earlier. And from
> the kind of inputs we got from Nishanth its not safe at all and so we
> really need a BUG_ON in this case, instead of WARN_ON.
> 
> What do you say?

Yeah, BUG_ON() sounds like the right thing to do here.

I have a concern that on some systems you can't really say what frequency
you're running at the moment, however.  So there should be a flag for
drivers indicating whether or not frequencies (or operation points in
general) are directly testable and the check should only be done for
the drivers with the flag set.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
