From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Fri, 05 Jul 2013 16:06:39 +0200
Message-ID: <51D6D2EF.8020307@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D47FB0.5090604@gmx.de> <51D51C63.2080702@linux.vnet.ibm.com> <CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com> <51D51F63.8080905@linux.vnet.ibm.com> <CAKohpom1KE=yxTi1HNoSn4cJ1mNpvZTeeVwK3A=4qSZ6Ut98gA@mail.gmail.com> <CAKohpok=iLyiiV5F4Q8ZK_-7ZzZqiGchHkmVWEvCRsV55z7gzA@mail.gmail.com> <51D5A5E5.9060302@gmx.de> <CAKohponPboo5awGj5uowrdo=e168BaRtkwQ8qte-Gj8R2FUgZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponPboo5awGj5uowrdo=e168BaRtkwQ8qte-Gj8R2FUgZg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 07/05/2013 06:35 AM, Viresh Kumar wrote:
> I assume that you have applied the patch given by Srivatsa earlier ov=
er
> these reverts?
yes

> But I now also suspect that this might have been caused by something
> outside cpufreq.

+1

At least the likelihood is big and the "saving" to narrow down bisectin=
g just to
the cpufreq patch is small compared to the "cost" of the risk of an unw=
anted side effect.
OTOH not sure when I find a time frame for the bisect nightmare.
That's why I tweaked my s2ram script in this way:

+       if [[ "$1" =3D "mem" && "$(uname -r)" =3D "3.10.0" ]]; then
+               echo " tweak governor ..."
+               for g in performance ondemand; do
+                       for i in 0 1 2 3; do
+                               echo $g > /sys/devices/system/cpu/cpu$i=
/cpufreq/scaling_governor
+                       done
+               done
+               echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/ignor=
e_nice
+       fi



--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
