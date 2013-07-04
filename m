From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 04 Jul 2013 12:25:31 +0530
Message-ID: <51D51C63.2080702@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D47FB0.5090604@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51D47FB0.5090604@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/04/2013 01:16 AM, Toralf F=C3=B6rster wrote:
> On 06/30/2013 07:05 PM, Toralf F=C3=B6rster wrote:
>> On 06/30/2013 06:33 PM, Srivatsa S. Bhat wrote:
>>> Toralf, can you please
>>> try out the below patch and see if it improves anything? (Don't rev=
ert anything,
>>> just apply the below diff on a problematic kernel and see if it sol=
ves your
>>> issue).
>>
>> applied on top of a66b2e5 - issue went away (either fixed or hidden =
now)
>>
>> Thx
>>
> But if I do apply that patch on top of kernel 3.10 then it has no eff=
ect
> - 3.10 shows the same issue.
>=20

Weird. So I think something *else* got broken by some other patch, _aft=
er_
a66b2e5. Viresh, do you have any suspect commits in mind?

Regards,
Srivatsa S. Bhat

