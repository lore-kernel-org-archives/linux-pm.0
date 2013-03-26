From: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/9] blackfin: cpufreq: move
 cpufreq driver to drivers/cpufreq
Date: Tue, 26 Mar 2013 18:26:30 +0800
Message-ID: <CAMk6uBmeiTJrJ2npbAD-CRAzEhP2G9euMD+=O_gzjncJFhZuUQ@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<df07f927c36e109e49363b9b87965a184ea941ca.1364229828.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2686084494794552359=="
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <df07f927c36e109e49363b9b87965a184ea941ca.1364229828.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robin.randhawa-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liviu.Dudau-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Steve.Bannister-5wv7dgnIgG8@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arvind.chauhan-5wv7dgnIgG8@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, charles.garcia-tobin-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============2686084494794552359==
Content-Type: multipart/alternative; boundary=e89a8ff1ce24d6a2d704d8d15a1b

--e89a8ff1ce24d6a2d704d8d15a1b
Content-Type: text/plain; charset=UTF-8

Acked-by: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Tue, Mar 26, 2013 at 12:54 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>wrote:

> This patch moves cpufreq driver of BLACKFIN architecture to
> drivers/cpufreq.
>
> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/blackfin/mach-common/Makefile
> | 1 -
>  drivers/cpufreq/Makefile
> | 1 +
>  .../blackfin/mach-common/cpufreq.c => drivers/cpufreq/blackfin-cpufreq.c
> | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/blackfin/mach-common/cpufreq.c =>
> drivers/cpufreq/blackfin-cpufreq.c (100%)
>
> diff --git a/arch/blackfin/mach-common/Makefile
> b/arch/blackfin/mach-common/Makefile
> index 75f0ba2..675466d 100644
> --- a/arch/blackfin/mach-common/Makefile
> +++ b/arch/blackfin/mach-common/Makefile
> @@ -10,7 +10,6 @@ obj-$(CONFIG_PM)          += pm.o
>  ifneq ($(CONFIG_BF60x),y)
>  obj-$(CONFIG_PM)         += dpmc_modes.o
>  endif
> -obj-$(CONFIG_CPU_FREQ)    += cpufreq.o
>  obj-$(CONFIG_CPU_VOLTAGE) += dpmc.o
>  obj-$(CONFIG_SMP)         += smp.o
>  obj-$(CONFIG_BFIN_KERNEL_CLOCK) += clocks-init.o
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 7573c22..2d86377 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_CPU_FREQ_MAPLE)          += maple-cpufreq.o
>
>  ##################################################################################
>  # Other platform drivers
>  obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)     += at32ap-cpufreq.o
> +obj-$(CONFIG_BLACKFIN)                 += blackfin-cpufreq.o
> diff --git a/arch/blackfin/mach-common/cpufreq.c
> b/drivers/cpufreq/blackfin-cpufreq.c
> similarity index 100%
> rename from arch/blackfin/mach-common/cpufreq.c
> rename to drivers/cpufreq/blackfin-cpufreq.c
> --
> 1.7.12.rc2.18.g61b472e
>
> _______________________________________________
> Uclinux-dist-devel mailing list
> Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
> https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>

--e89a8ff1ce24d6a2d704d8d15a1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Acked-by:=C2=A0Steven Miao &lt;<a href=3D"mailto:realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">realmz6=
@gmail.com</a>&gt;<br><br><div class=3D"gmail_quote">On Tue, Mar 26, 2013 a=
t 12:54 AM, Viresh Kumar <span dir=3D"ltr">&lt;<a href=3D"mailto:viresh.kum=
ar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" target=3D"_blank">viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This patch moves cpufreq driver of BLACKFIN =
architecture to drivers/cpufreq.<br>
<br>
Cc: Mike Frysinger &lt;<a href=3D"mailto:vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org">vapier@gentoo.o=
rg</a>&gt;<br>
Cc: <a href=3D"mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org">uclinux-dist=
-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org</a><br>
Signed-off-by: Viresh Kumar &lt;<a href=3D"mailto:viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">=
viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0arch/blackfin/mach-common/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0drivers/cpufreq/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0.../blackfin/mach-common/cpufreq.c =3D&gt; drivers/cpufreq/blackfin-c=
pufreq.c | 0<br>
=C2=A03 files changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename arch/blackfin/mach-common/cpufreq.c =3D&gt; drivers/cpufreq/bl=
ackfin-cpufreq.c (100%)<br>
<br>
diff --git a/arch/blackfin/mach-common/Makefile b/arch/blackfin/mach-common=
/Makefile<br>
index 75f0ba2..675466d 100644<br>
--- a/arch/blackfin/mach-common/Makefile<br>
+++ b/arch/blackfin/mach-common/Makefile<br>
@@ -10,7 +10,6 @@ obj-$(CONFIG_PM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D p=
m.o<br>
=C2=A0ifneq ($(CONFIG_BF60x),y)<br>
=C2=A0obj-$(CONFIG_PM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D dpmc_modes.o<br>
=C2=A0endif<br>
-obj-$(CONFIG_CPU_FREQ) =C2=A0 =C2=A0+=3D cpufreq.o<br>
=C2=A0obj-$(CONFIG_CPU_VOLTAGE) +=3D dpmc.o<br>
=C2=A0obj-$(CONFIG_SMP) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D smp.o<br>
=C2=A0obj-$(CONFIG_BFIN_KERNEL_CLOCK) +=3D clocks-init.o<br>
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile<br>
index 7573c22..2d86377 100644<br>
--- a/drivers/cpufreq/Makefile<br>
+++ b/drivers/cpufreq/Makefile<br>
@@ -79,3 +79,4 @@ obj-$(CONFIG_CPU_FREQ_MAPLE) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D maple-cpufreq.o<br>
=C2=A0#####################################################################=
#############<br>
=C2=A0# Other platform drivers<br>
=C2=A0obj-$(CONFIG_AVR32_AT32AP_CPUFREQ) =C2=A0 =C2=A0 +=3D at32ap-cpufreq.=
o<br>
+obj-$(CONFIG_BLACKFIN) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 +=3D blackfin-cpufreq.o<br>
diff --git a/arch/blackfin/mach-common/cpufreq.c b/drivers/cpufreq/blackfin=
-cpufreq.c<br>
similarity index 100%<br>
rename from arch/blackfin/mach-common/cpufreq.c<br>
rename to drivers/cpufreq/blackfin-cpufreq.c<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.12.rc2.18.g61b472e<br>
<br>
_______________________________________________<br>
Uclinux-dist-devel mailing list<br>
<a href=3D"mailto:Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org">Uclinux-dist-dev=
el-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org</a><br>
<a href=3D"https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel=
" target=3D"_blank">https://blackfin.uclinux.org/mailman/listinfo/uclinux-d=
ist-devel</a><br>
</font></span></blockquote></div><br>

--e89a8ff1ce24d6a2d704d8d15a1b--

--===============2686084494794552359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============2686084494794552359==--
