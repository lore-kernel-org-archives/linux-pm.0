From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sun, 30 Jun 2013 18:20:02 +0200
Message-ID: <51D05AB2.2080600@gmx.de>
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
> On 30 June 2013 19:52, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Well, to be honest, I'm not really sure how the above commit can cau=
se the
>> problem you're seeing to happen ...
>>
>> Srivatsa, Viresh, any ideas?
>=20
> I don't. But its very simple to get this checked isn't it?
> Just revert this patch on top of your kernel (leave bisect) and
> see if gets fixed.
>=20
I do (mostly) check a bisect result before I post it to a mailing list
to not blame the wrong commit to be guilty (b/c - erm - I did it in the
past).

Said that I finished bisect, checked out commit a66b2e5, tested it (has
the issue), did "git show a66b2e5 | patch -p1 -R" and checked that
result (no issue).


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
