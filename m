From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 04 Jul 2013 18:42:13 +0200
Message-ID: <51D5A5E5.9060302@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D47FB0.5090604@gmx.de> <51D51C63.2080702@linux.vnet.ibm.com> <CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com> <51D51F63.8080905@linux.vnet.ibm.com> <CAKohpom1KE=yxTi1HNoSn4cJ1mNpvZTeeVwK3A=4qSZ6Ut98gA@mail.gmail.com> <CAKohpok=iLyiiV5F4Q8ZK_-7ZzZqiGchHkmVWEvCRsV55z7gzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpok=iLyiiV5F4Q8ZK_-7ZzZqiGchHkmVWEvCRsV55z7gzA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 07/04/2013 10:23 AM, Viresh Kumar wrote:
> Ok, I did a mistake here (Thanks Srivatsa for telling me), this wasn'=
t
> there in 3.10 but 3.11-rc1
>=20
>> > c28375583b6471c1cb833a628ab6afb5b69079d0
>> >
>> > They are touching ondemand governor and this may be creating some
>> > problems. But I am not sure about it, I must admit.
> So just try reverting about commit.
>=20
> In case you are using acpi-cpufreq driver, please try reverting this =
before
> above one:
>=20
> 8673b83bf2f013379453b4779047bf3c6ae387e4
I reverted  8673b83b on top of 3.10.0  - no success, then I reverted
c2837558 too - no success.


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
