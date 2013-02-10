From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2 v2] x86 idle: remove 32-bit-only "no-hlt" parameter,
 hlt_works_ok flag
Date: Sun, 10 Feb 2013 23:26:18 +0100
Message-ID: <20130210222618.GA2573@pd.tnic>
References: <1360483829-16349-1-git-send-email-lenb@kernel.org>
 <c1647586af985fefe95a36e4924493f950ffe5e6.1360483568.git.len.brown@intel.com>
 <51181317.1080905@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:60554 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756765Ab3BJW0W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 10 Feb 2013 17:26:22 -0500
Content-Disposition: inline
In-Reply-To: <51181317.1080905@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Sun, Feb 10, 2013 at 04:37:27PM -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> Remove 32-bit x86 a cmdline param "no-hlt",
> and the cpuinfo_x86.hlt_works_ok that it sets.
>=20
> If a user wants to avoid HLT, then "idle=3Dpoll"
> is much more useful, as it avoids invocation of HLT
> in idle, while "no-hlt" failed to do so.
>=20
> Indeed, hlt_works_ok was consulted in only 3 places.
>=20
> First, in /proc/cpuinfo where "hlt_bug yes"
> would be printed if and only if the user booted
> the system with "no-hlt" -- as there was no other code
> to set that flag.
>=20
> Second, check_hlt() would not invoke halt() if "no-hlt"
> were on the cmdline.
>=20
> Third, it was consulted in stop_this_cpu(), which is invoked
> by native_machine_halt()/reboot_interrupt()/smp_stop_nmi_callback() -=
-
> all cases where the machine is being shutdown/reset.
> The flag was not consulted in the more frequently invoked
> play_dead()/hlt_play_dead() used in processor offline and suspend.
>=20
> Since Linux-3.0 there has been a run-time notice upon "no-hlt" invoca=
tions
> indicating that it would be removed in 2012.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> ---
> v2: remove also check_hlt()

[ =E2=80=A6 ]

> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 3286a92..e280253 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -28,7 +28,6 @@ static void show_cpuinfo_misc(struct seq_file *m, s=
truct cpuinfo_x86 *c)
>  {
>  	seq_printf(m,
>  		   "fdiv_bug\t: %s\n"
> -		   "hlt_bug\t\t: %s\n"

Are we fine with changing /proc/cpuinfo output? We tend to consider it
an API to userspace, judging by past experience...

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
