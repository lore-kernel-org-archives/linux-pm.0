From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Sat, 13 Jul 2013 12:16:36 +0200
Message-ID: <1373710596.1352.26.camel@x61.thuisdomein>
References: <51C08370.4050906@gmx.de>
	 <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	 <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan>
	 <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de>
	 <51D07E7F.2030709@linux.vnet.ibm.com> <51DDC8FA.4020609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DDC8FA.4020609@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-07-10 at 22:50 +0200, Toralf F=C3=B6rster wrote:
> I tested the patch several times on top of a66b2e5 - the origin issue=
 is
> fixed

Srivatsa's patch became commit f51e1eb63d ("cpufreq: Fix cpufreq
regression after suspend/resume").

>  but - erratically another issue now appears : all 4 cores are runs
> after wakeup at 2.6 GHz.

Well, a laptop I use seems to run into something related: the second of
its two cores can get stuck at a fixed frequency after resume. Often
it's its maximum frequency. That makes the CPU run hot, without actuall=
y
doing much work. But it can also get stuck at its lowest frequency.

Please note that commit f51e1eb63d, which is part of v3.10.1-rc1,
doesn't seem to cause this behavior. This issue can already be seen whe=
n
running v3.10.0. So perhaps that commit just made this issue more
noticeable to Toralf. But it's not clear to me what Toralf's origin(al?=
)
issue actually was.

Anyhow, I suspect that the stuck frequency is a regression introduced i=
n
v3.10.0. But I have been unable to pinpoint it to a commit added in the
v3.10 cycle through bisecting. I must have marked a commit good that wa=
s
actually bad, just because a few suspend and resume cycles didn't
trigger this issue. To be continued...
=20
> The temporary hot fix is to switch between governor performance and
> ondemand for all 4 cores.

That workaround works here too. I switch the core that is stuck at a
particular frequency to some other governor and then back to ondemand.

Thanks,


Paul Bolle
