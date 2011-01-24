From: Ari Savolainen <ari.m.savolainen@gmail.com>
Subject: Re: PROBLEM: Shutdown does not poweroff due to commit
 2a2d31c8 "intel_idle: open broadcast clock event"
Date: Mon, 24 Jan 2011 09:53:54 +0200
Message-ID: <AANLkTi=MNRTh2EL9Z1MWKpDnWTKnMSLA5EuJo5-7m_Fn@mail.gmail.com>
References: <AANLkTikDA9JqFjLRfPuPWTu3xbdfc16SzaRAwzKE3cH=@mail.gmail.com>
	<1295831375.1949.944.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1295831375.1949.944.camel@sli10-conroe>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2011/1/24 Shaohua Li <shaohua.li@intel.com>:
> I can't reproduce it here, but can you please try below patch:
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 7acb32e..1fa091e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -263,7 +263,7 @@ static void __setup_broadcast_timer(void *arg)
> =A0 =A0 =A0 =A0clockevents_notify(reason, &cpu);
> =A0}
>
> -static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block =
*n,
> +static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long action, void *hcpu)
> =A0{
> =A0 =A0 =A0 =A0int hotcpu =3D (unsigned long)hcpu;
> @@ -273,15 +273,11 @@ static int __cpuinit setup_broadcast_cpuhp_notify(s=
truct notifier_block *n,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_call_function_single(hotcpu, __setup_b=
roadcast_timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void *)true, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 case CPU_DOWN_PREPARE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_call_function_single(hotcpu, __setup_br=
oadcast_timer,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)false, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return NOTIFY_OK;
> =A0}
>
> -static struct notifier_block __cpuinitdata setup_broadcast_notifier =3D {
> +static struct notifier_block setup_broadcast_notifier =3D {
> =A0 =A0 =A0 =A0.notifier_call =3D setup_broadcast_cpuhp_notify,
> =A0};
>

I tried your patch and it did fix the problem.

Ari
