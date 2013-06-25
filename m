From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI/Processor: Clear unuseful variable count in the acpi_processor_preregister_performance()
Date: Wed, 26 Jun 2013 00:58:50 +0200
Message-ID: <18573179.2IsDSHVV58@vostro.rjw.lan>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <CAKohpo=jdP-WF4D+XO=Z9cYVvJpbM9EG6hKSCgURNMVBTGut5g@mail.gmail.com> <51C957E1.7080808@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51C957E1.7080808@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 25, 2013 04:42:09 PM Lan Tianyu wrote:
> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 15:45, Viresh Kumar wrote:
> > On 25 June 2013 07:36, Lan Tianyu <tianyu.lan@intel.com> wrote:
> >> The variable count in the acpi_processor_preregister_performance()=
 is only initalized
> >> as one for one cpu and increased by one when find another cpu that=
 share same dependency
> >> domain. Otherwise, it isn't referenced somewhere else.
> >>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> ---
> >>  drivers/acpi/processor_perflib.c |    4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> Thanks.

Queued up for 3.11.

Thanks,
Rafael

