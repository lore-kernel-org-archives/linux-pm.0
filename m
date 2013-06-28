From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Fri, 28 Jun 2013 09:14:48 +0530
Message-ID: <CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<1778593.ufLkNuJuaY@vostro.rjw.lan>
	<51CB34A2.7090404@gmx.de>
	<1475885.FjB577tJj8@vostro.rjw.lan>
	<CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com>
	<51CC7DB2.3020502@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:51289 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab3F1Dot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 23:44:49 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so1506956obb.32
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2013 20:44:48 -0700 (PDT)
In-Reply-To: <51CC7DB2.3020502@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 27 June 2013 23:30, Toralf F=F6rster <toralf.foerster@gmx.de> wrote:
> Yep, but 14 commits to bisect and about 20-30 min for each - will see=
,
> when I find a time slot.

Hmm..

> Just FWIW thie following is now a good indicator for the issue - that=
's
> the picture after wakeup, where I'd expect always 800 MHz:
>
> $ sudo cat /sys/devices/system/cpu/cpu?/cpufreq/cpuinfo_cur_freq
> 800000
> 2601000
> 2601000
> 2601000

Can you give dumps of complete cpufreq directories for all cpus before
and after s2r. That may give us some hint about the problem.
