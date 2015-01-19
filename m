From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: RFC on cpufreq implementation
Date: Mon, 19 Jan 2015 14:52:52 +0530
Message-ID: <CAHLCerMq0HnhS3ki3U1te5A8+NiDwpFNL_5_bm-CR4LoYFLo=A@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46480 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbbASJWx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 04:22:53 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so26985749lbd.9
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2015 01:22:52 -0800 (PST)
In-Reply-To: <54B7F7CD.7030903@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On Thu, Jan 15, 2015 at 10:54 PM, Mason <mpeg.blue@free.fr> wrote:
> Hello,
>
> This is a follow-up to my previous thread.
> "How many frequencies would cpufreq optimally like to manage?"
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
>
> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
> based SoC (namely Tango4 from Sigma Designs). I'd like to get
> some feedback on the cpufreq driver I wrote for that platform.
>
> I decided to expose only a small subset of frequencies (namely
> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> chose mostly min and max, and the intermediate frequencies not
> so much; so I figured "2 intermediate freqs" is good enough.
> (I'm ready to hear otherwise.)

How many states are really enough depends on the main workloads
running on your system. In a closed system (limited number of
applications) you can easily characterise your workloads and see what
operating points (OPP = voltage, frequency pair) the system spends
most of its time in (CPU_FREQ_STAT_DETAILS) and optimize out the
remaining OPPs.

In an open-ended system where you don't control what applications will
run on the system (e.g. android phone), it is probably a good idea to
expose more OPPs while keeping in mind that exposing 50 frequencies is
probably overkill (and silly) since you're spending more time reaching
the "optimum" OPP. Pick some high-impact ones e.g. ones that allow you
to lower your voltage.

> I tried to use as much generic framework as possible, but I've
> read about the clk framework, and it looks to be an even greater
> generalization. Are new platforms encouraged to use that, rather
> than provide a cpufreq driver? Does it work when voltage scaling
> comes in play? (This SoC doesn't have it, but the next will.)
>
> I'm also wondering how cpufreq and cpuidle interact? Is one a
> subset of the other? Are they orthogonal?

These queries have been answered by Krzysztof.
