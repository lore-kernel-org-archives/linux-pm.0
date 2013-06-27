From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 27 Jun 2013 20:00:18 +0200
Message-ID: <51CC7DB2.3020502@gmx.de>
References: <51C08370.4050906@gmx.de> <1778593.ufLkNuJuaY@vostro.rjw.lan> <51CB34A2.7090404@gmx.de> <1475885.FjB577tJj8@vostro.rjw.lan> <CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/27/2013 06:10 AM, Viresh Kumar wrote:
> On 27 June 2013 00:42, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Well, I'm not aware of any recent changes in cpufreq that would make=
 things
>> work differently depending on whether or not AC power is used.
>=20
> Toralf,
>=20
> It would be helpful if you can do git bisect and let us know which pa=
tch
> created this problem. Otherwise its very difficult to trace it.
>=20

Yep, but 14 commits to bisect and about 20-30 min for each - will see,
when I find a time slot.

Just FWIW thie following is now a good indicator for the issue - that's
the picture after wakeup, where I'd expect always 800 MHz:

$ sudo cat /sys/devices/system/cpu/cpu?/cpufreq/cpuinfo_cur_freq
800000
2601000
2601000
2601000


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
