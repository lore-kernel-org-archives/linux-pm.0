From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Sat, 13 Jul 2013 14:52:52 +0200
Message-ID: <1373719972.1359.8.camel@x61.thuisdomein>
References: <51C08370.4050906@gmx.de>
	 <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	 <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan>
	 <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de>
	 <51D07E7F.2030709@linux.vnet.ibm.com> <51DDC8FA.4020609@gmx.de>
	 <1373710596.1352.26.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373710596.1352.26.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-07-13 at 12:16 +0200, Paul Bolle wrote:
> I suspect that the stuck frequency is a regression introduced in v3.10.0.

The culprit apparently is commit a66b2e503f ("cpufreq: Preserve sysfs
files across suspend/resume"). Srivatsa submitted a patch to revert that
commit (see https://lkml.org/lkml/2013/7/11/661 ). That revert seems to
fix this issue too.


Paul Bolle
