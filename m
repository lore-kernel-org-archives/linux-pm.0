From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2 V3] CPUFreq: Add new sysfs attribute freqdomain_cpus for acpi-freq driver
Date: Thu, 27 Jun 2013 14:13:52 +0200
Message-ID: <3120815.KnnGRKg1ke@vostro.rjw.lan>
References: <1372316934-27225-1-git-send-email-tianyu.lan@intel.com> <CAKohponGDfjP6bFtXohb=h+_csmT49UJ=Dko_e4mUrkDBVN02g@mail.gmail.com> <51CBF5DC.5020806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51CBF5DC.5020806@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 27, 2013 04:20:44 PM Lan Tianyu wrote:
> On 2013=E5=B9=B406=E6=9C=8827=E6=97=A5 16:25, Viresh Kumar wrote:
> > On 27 June 2013 12:38, Lan Tianyu <tianyu.lan@intel.com> wrote:
> >> Commit aa77a52 and fcf8058 changes the content of "related_cpus" a=
nd user
> >> space can't get cpus which are in the same hardware coordination c=
pu domain
> >> (These info are provided by ACPI AML method _PSD) via "related_cpu=
s". This
> >> change affects some users of original "related_cpus".
> >>
> >> This patch is to add a new sysfs attribute "freqdomian_cpus" for a=
cpi-cpufreq
> >> driver which exposes all cpus in the same domain regardless of har=
dware or
> >> software coordination to make up the info loss of previous change.
> >>
> >> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D58761
> >> Reported-by: Jean-Philippe Halimi <jean-philippe.halimi@exascale-c=
omputing.eu>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
>=20
> Thanks.

Queued up for 3.11 with minor changes.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
