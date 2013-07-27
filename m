From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Sun, 28 Jul 2013 01:39:25 +0200
Message-ID: <4531734.kTFAPunoch@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F40612.2050403@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
> it gives at a ThinkPad T420:
>=20
> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> acpi_cpufreq           12902  2147483647

That is -1, which indicates some module refcount woes.

I definitely can't see that with the mainline on my machines.

Thanks,
Rafael

