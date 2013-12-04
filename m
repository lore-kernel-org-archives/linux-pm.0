From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] PM / hibernate: Call platform_leave in suspend path too
Date: Wed, 04 Dec 2013 22:01:27 +0100
Message-ID: <12071995.7VlP7yczan@vostro.rjw.lan>
References: <1386169618-6417-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386169618-6417-1-git-send-email-bjorn@mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 04, 2013 04:06:58 PM Bj=C3=B8rn Mork wrote:
> The system can continue running after the image is created, for
> example because userspace cancelled the hibernation or only
> saved the image for a dual mode disk + ram suspend. We must
> restore the platform to the pre_snapshot state in this case.

No, this is not what is happening. :-)

The problem is that the enable_nonboot_cpus() is run with EC transactio=
ns
blocked if in_suspend is 1 and that causes the failure below to happen.

So the changelog needs to be rewritten.

That said, looking at what acpi_hibernation_leave() does I think we can
do the change that you're proposing without any significant side effect=
s.

I'll queue up this change as a fix for 3.13 or 3.14, but I'll write a b=
etter
changelog for it.

Thanks!

> This fixes a long standing bug in the acpi_cpufreq driver
> which would fail after a cancelled hibernate because the
> system then was running with the EC blocked:
>=20
>  cpufreq: adding CPU 1
>  acpi_cpufreq_cpu_init
>  cpufreq: FREQ: 1401000 - CPU: 0
>  ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedC=
ontrol] (20130725/evregion-287)
>  ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPC_.EC__.LPMD=
] (Node ffff88023249ab28), AE_BAD_PARAMETER (20130725/psparse-536)
>  ACPI Error: Method parse/execution failed [\_PR_.CPU0._PPC] (Node ff=
ff88023270e3f8), AE_BAD_PARAMETER (20130725/psparse-536)
>  ACPI Error: Method parse/execution failed [\_PR_.CPU1._PPC] (Node ff=
ff88023270e290), AE_BAD_PARAMETER (20130725/psparse-536)
>  ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC (20130725/processo=
r_perflib-140)
>  cpufreq: initialization failed
>  CPU1 is up
>=20
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> ---
> This is posted as RFC because I am unsure whether this is the correct
> way to fix the problem.  We definitely need to undo some of the
> pre_snapshot work to have a fully functional system when create_image
> returns, but I guess there can be unwanted side effects of unconditio=
nally
> calling platform_leave() like this.
>=20
> FWIW, this works for me.
>=20
> Testing and verifying the original acpi_cpufreq problem should be eas=
y on
> any system using that driver and having an EC, which should include m=
ost
> laptops:
>   - Start a userspace hibernation and cancel it, for example by using
>     s2disk from uswsusp and pressing backspace.
>=20
> The cpufreq device will disappear from all non-boot cores, and the ab=
ove
> ACPI exceptions will be logged.
>=20
> Comments and/or alternative solutions are appreciated.
>=20
> Note that the final solution to this problem should be backported to =
all
> maintained stable kernels.  I've verified that the problem exists and=
 that
> this proposed patch applies to 3.2, 3.4, 3.10 and 3.12
>=20
>=20
> Bj=C3=B8rn
>=20
>  kernel/power/hibernate.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 0121dab83f43..59fb7e82f818 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -293,10 +293,10 @@ static int create_image(int platform_mode)
>  			error);
>  	/* Restore control flow magically appears here */
>  	restore_processor_state();
> -	if (!in_suspend) {
> +	if (!in_suspend)
>  		events_check_enabled =3D false;
> -		platform_leave(platform_mode);
> -	}
> +
> +	platform_leave(platform_mode);
> =20
>   Power_up:
>  	syscore_resume();
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
