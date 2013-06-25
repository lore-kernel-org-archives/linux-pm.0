From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for acpi-freq driver
Date: Wed, 26 Jun 2013 01:02:19 +0200
Message-ID: <1453366.xvWmsCZd02@vostro.rjw.lan>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com> <51C95282.3040305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51C95282.3040305@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 25, 2013 04:19:14 PM Lan Tianyu wrote:
> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 15:48, Viresh Kumar wrote:
> > On 25 June 2013 12:24, Lan Tianyu <tianyu.lan@intel.com> wrote:
> >> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 11:56, Viresh Kumar wrote:
> >=20
> >>> This is generic file, don't add this information here. Add this i=
n
> >>> acpi-cpufreq file.
> >> I don't find acpi-cpufreq.txt under
> >> Documentation/cpu-freq/acpi-cpufreq.txt. So I should create it?
> >=20
> > I meant acpi-cpufreq.c file
> Ok. From my opinion, the new attribute is an ABI and it's better to a=
dd
> descriptor under Document directory. The user can be easy to find how=
 to
> use it.

Yes, this should be documented under Documentation/ABI/testing/.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
