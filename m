From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Fri, 28 Jun 2013 20:51:11 +0200
Message-ID: <51CDDB1F.3080306@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com> <51CDC518.8030907@gmx.de> <1875598.7eDhd0iuMQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1875598.7eDhd0iuMQ@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/28/2013 08:56 PM, Rafael J. Wysocki wrote:
> On Friday, June 28, 2013 07:17:12 PM Toralf F=C3=B6rster wrote:
>> On 06/28/2013 05:44 AM, Viresh Kumar wrote:
>>> Can you give dumps of complete cpufreq directories for all cpus bef=
ore
>>> and after s2r. That may give us some hint about the problem.
>>
>> Because CPU0 is not affected I somehow arguing about nohz patches ..=
=2E
>=20
> Do you have CONFIG_NO_HZ_FULL set by chance?
>=20
> Rafael
>=20
>=20
no

$ zgrep  CONFIG_NO_HZ_FULL /proc/config.gz

I do just have :

$ zgrep  CONFIG_NO_HZ /proc/config.gz
CONFIG_NO_HZ_COMMON=3Dy
CONFIG_NO_HZ_IDLE=3Dy
CONFIG_NO_HZ=3Dy

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
