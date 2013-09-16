From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Few clarifications on DVFS
Date: Mon, 16 Sep 2013 11:16:18 +0530
Message-ID: <CAOh2x=n3PVMJhbrJE33Qe73=6ZUhh8yR1rs+ziWTD5tFNjW6RA@mail.gmail.com>
References: <CAOuKo4nZ5Yij3cnM=PuMR3awJ2QAbY4O+-mKi110xfc66xyWUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52632 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3IPFqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 01:46:19 -0400
In-Reply-To: <CAOuKo4nZ5Yij3cnM=PuMR3awJ2QAbY4O+-mKi110xfc66xyWUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: karthik vm <meetvm@gmail.com>
Cc: cpufreq <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Included pm list as well..

On Mon, Sep 16, 2013 at 6:00 AM, karthik vm <meetvm@gmail.com> wrote:
> Hi,
>
> I am a PhD student doing research in DVFS area. I have few questions
> for which I am looking for an answer. It would be great if some one
> could give some pointers.
>
> 1) In my current Core2Duo laptop, "maximum transition latency" from
> cpufreq-info command is 10us. Hence I get that to change the frequency
> of my cpu it takes 10us. Also recent research papers say that the
> frequency of the processor can be changed in ns scale (eg. 10 ns -
> 100ns). If that is the case, can processor frequency be still modified
> thru OS? Will OS be able to handle such a fine grained frequency
> change?

What's the problem you see in OS doing that? Its not about the guarantee
that OS can change freq in that time, but is more about hardware... And
so it doesn't matter who changes it..

> 2) Currently the frequency change is handled by governors. But is it
> possible to change the frequency of a cpu directly by calling the
> CPU-driver functions from another part of the kernel?

Ya, the API is open to be called from anywhere you want... but then its
your hardware and you must know what you are doing :)
