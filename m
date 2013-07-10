From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Wed, 10 Jul 2013 21:31:09 +0200
Message-ID: <51DDB67D.70302@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D47FB0.5090604@gmx.de> <51D51C63.2080702@linux.vnet.ibm.com> <CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com> <51D51F63.8080905@linux.vnet.ibm.com> <CAKohpo=O0P9tKq5QFMhotvErcHnt9haJw3N-p9p0cZOa1t-SRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=O0P9tKq5QFMhotvErcHnt9haJw3N-p9p0cZOa1t-SRQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/04/2013 09:58 AM, Viresh Kumar wrote:
> On 4 July 2013 12:38, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.=
com> wrote:
>> Coming to git bisect, I think it needs to be done between a66b2e5 + =
this-patch
>> and 3.10 + this-patch, to ensure that we look for problematic commit=
s in-between
>> a66b2e5 and 3.10 (to avoid the bisect result ending up at a66b2e5 ag=
ain).
>=20
> Exactly!!
>=20

Problem : yesterday I wasn't even able to 100% validate the issue at
commit a66b2e5 + f51e1eb just b/c there's another issue which
erratically happens here: sometimes cpu0 is too (not only cpu 1-3). In
that case the frequency are set to 2.6 GHz for each coret instead of 80=
0
MHz for cpu0 and 2.601 GHz for cpu 1-3.

=46urthermore I've the strong feeling, that the plugged in USB devices
might have an effect. And in the mean while I would not even exclude th=
e
influence of the type of the 4 BOINC tasks (Asteorid@Home versus
Einstein@Home / World Community Grid which I have to run with nice -19
in the back ground) at the bisect results.

So all my ongoing attempts to bisect weren't successful till now.

I just tested the latest git tree from today (v3.10-8615-g23e3a1d) -
although f51e1eb is merged - the origin issue (cpu 1-3 set to 2.601 GHz
after wakeup) is still here.


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
