From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] intel_idle: stop using driver_data for static flags
Date: Fri, 01 Feb 2013 09:44:09 +0100
Message-ID: <510B8059.5040609@linaro.org>
References: <1359691896-23567-1-git-send-email-lenb@kernel.org> <9a38405338d7464c852c4524465f84f8a2ac22fb.1359691799.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9a38405338d7464c852c4524465f84f8a2ac22fb.1359691799.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 02/01/2013 05:11 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> The commit, 4202735e8ab6ecfb0381631a0d0b58fefe0bd4e2
> (cpuidle: Split cpuidle_state structure and move per-cpu statistics f=
ields)
> observed that the MWAIT flags for Cn on every processor to date were =
the
> same, and created get_driver_data() to supply them.
>=20
> Unfortunately, that assumption is false, going forward.
> So here we restore the MWAIT flags to the cpuidle_state table.
> However, instead restoring the old "driver_data" field,
> we put the flags into the existing "flags" field,
> where they probalby should have lived all along.

Removing the driver_data is a good thing but I am not sure it is the
case by moving the MWAIT flags to the cpuidle_state's flags field. We
are mixing arch specific flags with a generic code.

This is prone to errors because new flags could appear for the cpuidle
core code and could collide with the arch specific flags.

Wouldn't make sense to add a private field in the struct cpuidle_state
structure to let the driver/arch specific to store whatever is needed ?

struct cpuidle_state {

	...
	unsigned long private;
	...

}


> This patch does not change any operation.
>=20
> This patch removes 1 of the 3 users of cpuidle_state_usage.driver_dat=
a.
> Perhaps some day we'll get rid of the other 2.

+1 :)

> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/idle/intel_idle.c | 75 ++++++++++++++++---------------------=
----------
>  1 file changed, 26 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 2df9414..8331753 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -109,6 +109,16 @@ static struct cpuidle_state *cpuidle_state_table=
;
>  #define CPUIDLE_FLAG_TLB_FLUSHED	0x10000
> =20
>  /*
> + * MWAIT takes an 8-bit "hint" in EAX "suggesting"
> + * the C-state (top nibble) and sub-state (bottom nibble)
> + * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
> + *=20
> + * We store the hint at the top of our "flags" for each state.
> + */
> +#define flags_2_MWAIT_EAX(flags) (((flags) >> 24) & 0xFF)
> +#define MWAIT_EAX_2_flags(eax) ((eax & 0xFF) << 24)
> +
> +/*
>   * States are indexed by the cstate number,
>   * which is also the index into the MWAIT hint array.
>   * Thus C0 is a dummy.
> @@ -118,21 +128,21 @@ static struct cpuidle_state nehalem_cstates[MWA=
IT_MAX_NUM_CSTATES] =3D {
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-NHM",
>  		.desc =3D "MWAIT 0x00",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.flags =3D MWAIT_EAX_2_flags(0x00) | CPUIDLE_FLAG_TIME_VALID,
>  		.exit_latency =3D 3,
>  		.target_residency =3D 6,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C2 */
>  		.name =3D "C3-NHM",
>  		.desc =3D "MWAIT 0x10",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x10) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 20,
>  		.target_residency =3D 80,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C3 */
>  		.name =3D "C6-NHM",
>  		.desc =3D "MWAIT 0x20",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x20) |CPUIDLE_FLAG_TIME_VALID | CPUI=
DLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 200,
>  		.target_residency =3D 800,
>  		.enter =3D &intel_idle },
> @@ -143,28 +153,28 @@ static struct cpuidle_state snb_cstates[MWAIT_M=
AX_NUM_CSTATES] =3D {
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-SNB",
>  		.desc =3D "MWAIT 0x00",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.flags =3D MWAIT_EAX_2_flags(0x00) | CPUIDLE_FLAG_TIME_VALID,
>  		.exit_latency =3D 1,
>  		.target_residency =3D 1,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C2 */
>  		.name =3D "C3-SNB",
>  		.desc =3D "MWAIT 0x10",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x10) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 80,
>  		.target_residency =3D 211,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C3 */
>  		.name =3D "C6-SNB",
>  		.desc =3D "MWAIT 0x20",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x20) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 104,
>  		.target_residency =3D 345,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C4 */
>  		.name =3D "C7-SNB",
>  		.desc =3D "MWAIT 0x30",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x30) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 109,
>  		.target_residency =3D 345,
>  		.enter =3D &intel_idle },
> @@ -175,28 +185,28 @@ static struct cpuidle_state ivb_cstates[MWAIT_M=
AX_NUM_CSTATES] =3D {
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-IVB",
>  		.desc =3D "MWAIT 0x00",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.flags =3D MWAIT_EAX_2_flags(0x00) | CPUIDLE_FLAG_TIME_VALID,
>  		.exit_latency =3D 1,
>  		.target_residency =3D 1,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C2 */
>  		.name =3D "C3-IVB",
>  		.desc =3D "MWAIT 0x10",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x10) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 59,
>  		.target_residency =3D 156,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C3 */
>  		.name =3D "C6-IVB",
>  		.desc =3D "MWAIT 0x20",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x20) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 80,
>  		.target_residency =3D 300,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C4 */
>  		.name =3D "C7-IVB",
>  		.desc =3D "MWAIT 0x30",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x30) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 87,
>  		.target_residency =3D 300,
>  		.enter =3D &intel_idle },
> @@ -207,14 +217,14 @@ static struct cpuidle_state atom_cstates[MWAIT_=
MAX_NUM_CSTATES] =3D {
>  	{ /* MWAIT C1 */
>  		.name =3D "C1-ATM",
>  		.desc =3D "MWAIT 0x00",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.flags =3D MWAIT_EAX_2_flags(0x00) | CPUIDLE_FLAG_TIME_VALID,
>  		.exit_latency =3D 1,
>  		.target_residency =3D 4,
>  		.enter =3D &intel_idle },
>  	{ /* MWAIT C2 */
>  		.name =3D "C2-ATM",
>  		.desc =3D "MWAIT 0x10",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +		.flags =3D MWAIT_EAX_2_flags(0x10) | CPUIDLE_FLAG_TIME_VALID,
>  		.exit_latency =3D 20,
>  		.target_residency =3D 80,
>  		.enter =3D &intel_idle },
> @@ -222,7 +232,7 @@ static struct cpuidle_state atom_cstates[MWAIT_MA=
X_NUM_CSTATES] =3D {
>  	{ /* MWAIT C4 */
>  		.name =3D "C4-ATM",
>  		.desc =3D "MWAIT 0x30",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x30) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 100,
>  		.target_residency =3D 400,
>  		.enter =3D &intel_idle },
> @@ -230,41 +240,12 @@ static struct cpuidle_state atom_cstates[MWAIT_=
MAX_NUM_CSTATES] =3D {
>  	{ /* MWAIT C6 */
>  		.name =3D "C6-ATM",
>  		.desc =3D "MWAIT 0x52",
> -		.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
> +		.flags =3D MWAIT_EAX_2_flags(0x52) | CPUIDLE_FLAG_TIME_VALID | CPU=
IDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency =3D 140,
>  		.target_residency =3D 560,
>  		.enter =3D &intel_idle },
>  };
> =20
> -static long get_driver_data(int cstate)
> -{
> -	int driver_data;
> -	switch (cstate) {
> -
> -	case 1:	/* MWAIT C1 */
> -		driver_data =3D 0x00;
> -		break;
> -	case 2:	/* MWAIT C2 */
> -		driver_data =3D 0x10;
> -		break;
> -	case 3:	/* MWAIT C3 */
> -		driver_data =3D 0x20;
> -		break;
> -	case 4:	/* MWAIT C4 */
> -		driver_data =3D 0x30;
> -		break;
> -	case 5:	/* MWAIT C5 */
> -		driver_data =3D 0x40;
> -		break;
> -	case 6:	/* MWAIT C6 */
> -		driver_data =3D 0x52;
> -		break;
> -	default:
> -		driver_data =3D 0x00;
> -	}
> -	return driver_data;
> -}
> -
>  /**
>   * intel_idle
>   * @dev: cpuidle_device
> @@ -278,8 +259,7 @@ static int intel_idle(struct cpuidle_device *dev,
>  {
>  	unsigned long ecx =3D 1; /* break on interrupt flag */
>  	struct cpuidle_state *state =3D &drv->states[index];
> -	struct cpuidle_state_usage *state_usage =3D &dev->states_usage[inde=
x];
> -	unsigned long eax =3D (unsigned long)cpuidle_get_statedata(state_us=
age);
> +	unsigned long eax =3D flags_2_MWAIT_EAX(state->flags);
>  	unsigned int cstate;
>  	int cpu =3D smp_processor_id();
> =20
> @@ -558,9 +538,6 @@ static int intel_idle_cpu_init(int cpu)
>  		if (cpuidle_state_table[cstate].enter =3D=3D NULL)
>  			continue;
> =20
> -		dev->states_usage[dev->state_count].driver_data =3D
> -			(void *)get_driver_data(cstate);
> -
>  		dev->state_count +=3D 1;
>  	}
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
