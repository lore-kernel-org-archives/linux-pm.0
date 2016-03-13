From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] tools/power turbostat: bugfix: fix several invalid parameters
Date: Sun, 13 Mar 2016 03:28:17 -0400
Message-ID: <CAJvTdKm9axkp+E13irUPFhE1iPmUJOM3oji1Gfbt8b=FnifmRQ@mail.gmail.com>
References: <cover.1450011064.git.yu.c.chen@intel.com>
	<b7a8feb0effba7b59ea55288fd1b3dc0ecbfbd66.1450011064.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36795 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbcCMH2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2016 03:28:19 -0400
In-Reply-To: <b7a8feb0effba7b59ea55288fd1b3dc0ecbfbd66.1450011064.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Thanks for the patch Yu.

As it turns out, I already had a fix for this in my tree.
I think the compiler complained about these programming errors
when I compiled on a machine different from my standard desktop.

If you know what compiler options cause it to check
for stuff like this by default, I'd welcome a patch to the Makefile to
enable them.

thanks,
-Len


On Sun, Dec 13, 2015 at 8:09 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> dump_cstate_pstate_config_info is invoked with no parameters,
> which might cause this function to misjudge the processor family
> and model. Fix this by passing family and model to it.
>
> Besides, fix the compiling warning caused by missing type declaration
> in dump_cstate_pstate_config_info, get_tdp and perf_limit_reasons_pro=
be:
>
> turbostat.c: In function =E2=80=98dump_cstate_pstate_config_info=E2=80=
=99:
> turbostat.c:1973:1: warning: type of =E2=80=98family=E2=80=99 default=
s to =E2=80=98int=E2=80=99 [-Wimplicit-int]
>  dump_cstate_pstate_config_info(family, model)
>  ^
> turbostat.c:1973:1: warning: type of =E2=80=98model=E2=80=99 defaults=
 to =E2=80=98int=E2=80=99 [-Wimplicit-int]
> turbostat.c: In function =E2=80=98get_tdp=E2=80=99:
> turbostat.c:2145:8: warning: type of =E2=80=98model=E2=80=99 defaults=
 to =E2=80=98int=E2=80=99 [-Wimplicit-int]
>  double get_tdp(model)
>         ^
> turbostat.c: In function =E2=80=98perf_limit_reasons_probe=E2=80=99:
> turbostat.c:2259:6: warning: type of =E2=80=98family=E2=80=99 default=
s to =E2=80=98int=E2=80=99 [-Wimplicit-int]
>  void perf_limit_reasons_probe(family, model)
>       ^
> turbostat.c:2259:6: warning: type of =E2=80=98model=E2=80=99 defaults=
 to =E2=80=98int=E2=80=99 [-Wimplicit-int]
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/=
turbostat/turbostat.c
> index 9854929..47068de 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1970,7 +1970,7 @@ int has_config_tdp(unsigned int family, unsigne=
d int model)
>  }
>
>  static void
> -dump_cstate_pstate_config_info(family, model)
> +dump_cstate_pstate_config_info(unsigned int family, unsigned int mod=
el)
>  {
>         if (!do_nhm_platform_info)
>                 return;
> @@ -2142,7 +2142,7 @@ int print_perf_limit(struct thread_data *t, str=
uct core_data *c, struct pkg_data
>  #define        RAPL_POWER_GRANULARITY  0x7FFF  /* 15 bit power granu=
larity */
>  #define        RAPL_TIME_GRANULARITY   0x3F /* 6 bit time granularit=
y */
>
> -double get_tdp(model)
> +double get_tdp(unsigned int model)
>  {
>         unsigned long long msr;
>
> @@ -2256,7 +2256,7 @@ void rapl_probe(unsigned int family, unsigned i=
nt model)
>         return;
>  }
>
> -void perf_limit_reasons_probe(family, model)
> +void perf_limit_reasons_probe(unsigned int family, unsigned int mode=
l)
>  {
>         if (!genuine_intel)
>                 return;
> @@ -2792,7 +2792,7 @@ void process_cpuid()
>         perf_limit_reasons_probe(family, model);
>
>         if (debug)
> -               dump_cstate_pstate_config_info();
> +               dump_cstate_pstate_config_info(family, model);
>
>         if (has_skl_msrs(family, model))
>                 calculate_tsc_tweak();
> --
> 1.8.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Len Brown, Intel Open Source Technology Center
