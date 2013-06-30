From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sun, 30 Jun 2013 18:21:43 +0200
Message-ID: <51D05B17.4070606@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <CAKohpomKbGd0BxR-SQV7ose_zgb0-cmoMyMD84JdHBBr0szmBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomKbGd0BxR-SQV7ose_zgb0-cmoMyMD84JdHBBr0szmBg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/30/2013 05:15 PM, Viresh Kumar wrote:
> Just revert this patch on top of your kernel (leave bisect) and
> see if gets fixed.

negative,
reverting that commit on top of current -rc7+ tree breaks s2ram
completely here (just sysrq+b works when the power led is blinking)

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
