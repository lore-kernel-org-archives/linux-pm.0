From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Sun, 28 Jul 2013 10:08:31 +0200
Message-ID: <51F4D17F.1090107@gmx.de>
References: <51F40612.2050403@gmx.de> <4531734.kTFAPunoch@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4531734.kTFAPunoch@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
>> it gives at a ThinkPad T420:
>>
>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
>> acpi_cpufreq           12902  2147483647
>=20
> That is -1, which indicates some module refcount woes.
>=20
> I definitely can't see that with the mainline on my machines.

It might be a regression in -stable only, b/c in 3,10.2 I did not
observed it.

Srivatsa,

by any chance - could the revert of the cpufreq patches have something
to do with that ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
