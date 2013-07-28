From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Sun, 28 Jul 2013 13:38:42 +0530
Message-ID: <51F4D18A.7080605@linux.vnet.ibm.com>
References: <51F40612.2050403@gmx.de> <4531734.kTFAPunoch@vostro.rjw.lan> <51F4D17F.1090107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F4D17F.1090107@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07/28/2013 01:38 PM, Toralf F=C3=B6rster wrote:
> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
>> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
>>> it gives at a ThinkPad T420:
>>>
>>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
>>> acpi_cpufreq           12902  2147483647
>>
>> That is -1, which indicates some module refcount woes.
>>
>> I definitely can't see that with the mainline on my machines.
>=20
> It might be a regression in -stable only, b/c in 3,10.2 I did not
> observed it.
>=20
> Srivatsa,
>=20
> by any chance - could the revert of the cpufreq patches have somethin=
g
> to do with that ?
>

Hmmm? Those reverts didn't touch anything related to module
refcounts.. So I don't think they have anything to do with this.

Also, is the issue related to suspend/resume at all? (Sorry, I don't
have your original email, so I'm not sure what the exact issue is).

=20
Regards,
Srivatsa S. Bhat

