From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 14/16] intel_idle: remove use and definition of MWAIT_MAX_NUM_CSTATES
Date: Mon, 11 Feb 2013 09:53:02 +0100
Message-ID: <5118B16E.6010709@linaro.org>
References: <1360372100-28482-1-git-send-email-lenb@kernel.org> <137ecc779c80138723677209730738d76262e810.1360371180.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64256 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3BKIxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 03:53:01 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so2958076wie.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Feb 2013 00:52:59 -0800 (PST)
In-Reply-To: <137ecc779c80138723677209730738d76262e810.1360371180.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On 02/09/2013 02:08 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> Cosmetic only.
>=20
> Replace use of MWAIT_MAX_NUM_CSTATES with CPUIDLE_STATE_MAX.
> They are both 8, so this patch has no functional change.
>=20
> The reason to change is that intel_idle will soon be able
> to export more than the 8 "major" states supported by MWAIT.
> When we hit that limit, it is important to know
> where the limit comes from.

Does it mean CPUIDLE_STATE_MAX may increase in a near future ?



> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/include/asm/mwait.h |  1 -
>  drivers/idle/intel_idle.c    | 16 ++++++++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwai=
t.h
> index bcdff99..3f44732 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -4,7 +4,6 @@
>  #define MWAIT_SUBSTATE_MASK		0xf
>  #define MWAIT_CSTATE_MASK		0xf
>  #define MWAIT_SUBSTATE_SIZE		4
> -#define MWAIT_MAX_NUM_CSTATES		8
> =20
>  #define CPUID_MWAIT_LEAF		5
>  #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fa71477..c949a6f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -74,7 +74,7 @@ static struct cpuidle_driver intel_idle_driver =3D =
{
>  	.en_core_tk_irqen =3D 1,
>  };
>  /* intel_idle.max_cstate=3D0 disables driver */
> -static int max_cstate =3D MWAIT_MAX_NUM_CSTATES - 1;
> +static int max_cstate =3D CPUIDLE_STATE_MAX - 1;
> =20
>  static unsigned int mwait_substates;
> =20
> @@ -123,7 +123,7 @@ static struct cpuidle_state *cpuidle_state_table;
>   * which is also the index into the MWAIT hint array.
>   * Thus C0 is a dummy.
>   */
> -static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] =3D=
 {
> +static struct cpuidle_state nehalem_cstates[CPUIDLE_STATE_MAX] =3D {
>  	{ /* MWAIT C0 */ },
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-NHM",
> @@ -148,7 +148,7 @@ static struct cpuidle_state nehalem_cstates[MWAIT=
_MAX_NUM_CSTATES] =3D {
>  		.enter =3D &intel_idle },
>  };
> =20
> -static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] =3D {
> +static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] =3D {
>  	{ /* MWAIT C0 */ },
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-SNB",
> @@ -180,7 +180,7 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX=
_NUM_CSTATES] =3D {
>  		.enter =3D &intel_idle },
>  };
> =20
> -static struct cpuidle_state ivb_cstates[MWAIT_MAX_NUM_CSTATES] =3D {
> +static struct cpuidle_state ivb_cstates[CPUIDLE_STATE_MAX] =3D {
>  	{ /* MWAIT C0 */ },
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-IVB",
> @@ -212,7 +212,7 @@ static struct cpuidle_state ivb_cstates[MWAIT_MAX=
_NUM_CSTATES] =3D {
>  		.enter =3D &intel_idle },
>  };
> =20
> -static struct cpuidle_state hsw_cstates[MWAIT_MAX_NUM_CSTATES] =3D {
> +static struct cpuidle_state hsw_cstates[CPUIDLE_STATE_MAX] =3D {
>  	{ /* MWAIT C0 */ },
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-HSW",
> @@ -244,7 +244,7 @@ static struct cpuidle_state hsw_cstates[MWAIT_MAX=
_NUM_CSTATES] =3D {
>  		.enter =3D &intel_idle },
>  };
> =20
> -static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] =3D =
{
> +static struct cpuidle_state atom_cstates[CPUIDLE_STATE_MAX] =3D {
>  	{ /* MWAIT C0 */ },
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-ATM",
> @@ -503,7 +503,7 @@ static int intel_idle_cpuidle_driver_init(void)
> =20
>  	drv->state_count =3D 1;
> =20
> -	for (cstate =3D 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
> +	for (cstate =3D 1; cstate < CPUIDLE_STATE_MAX; ++cstate) {
>  		int num_substates;
> =20
>  		if (cstate > max_cstate) {
> @@ -560,7 +560,7 @@ static int intel_idle_cpu_init(int cpu)
> =20
>  	dev->state_count =3D 1;
> =20
> -	for (cstate =3D 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
> +	for (cstate =3D 1; cstate < CPUIDLE_STATE_MAX; ++cstate) {
>  		int num_substates;
> =20
>  		if (cstate > max_cstate) {
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

