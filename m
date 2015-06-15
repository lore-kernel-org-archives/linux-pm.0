From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] intel_pstate: Force setting target pstate when required.
Date: Tue, 16 Jun 2015 01:44:58 +0200
Message-ID: <5378133.2EJIvAAWEJ@vostro.rjw.lan>
References: <1433218354-2607-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57721 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750835AbbFOXTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:19:01 -0400
In-Reply-To: <1433218354-2607-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: kristen@linux.intel.com, linux-pm@vger.kernel.org, dsmythies@telus.net

On Monday, June 01, 2015 09:12:34 PM Doug Smythies wrote:
> During initialization and exit it is possible that the
> target pstate might not actually be set. Furthermore,
> the result can be that the driver and the processor
> are out of synch and, under some conditions, the driver
> might never send the processor the proper target pstate.
>=20
> This patch adds a bypass or do_checks flag to the call to
> intel_pstate_set_pstate. If bypass, then specifically
> bypass clamp checks and the do not send if it is the
> same as last time check. If do_checks, then, and as before,
> do the current policy clamp checks, and do not do actual
> send if the new target is the same as the old.
>=20
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> Reported-by: Marien Zwart <marien.zwart@gmail.com>
> Reported-by: Alex Lochmann <alexander.lochmann@tu-dortmund.de>
> Reported-by: Piotr Ko=C5=82aczkowski <pkolaczk@gmail.com>
> Reported-by: Clemens Eisserer <linuxhippy@gmail.com>
> Tested-by: Marien Zwart <marien.zwart@gmail.com>
> Tested-by: Doug Smythies <dsmythies@telus.net>

I've applied the patch with a couple of changes.

> ---
>  drivers/cpufreq/intel_pstate.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index 6414661..52c720c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -33,6 +33,9 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
> =20
> +#define	PSTATE_BYPASS_CHECKS	false
> +#define PSTATE_DO_CHECKS	true

Most importantly, I've dropped these symbol definitions as in my opinio=
n it is
just clear to use bool directly instead.

Please check the result at

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dlinux-next&id=3D6c1e45917dec5e7c99ba8125fd8cc50f6e482a21


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
