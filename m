From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 26 Nov 2010 16:39:43 +0900
Message-ID: <AANLkTin-ZCb7bdYhtUe00cPMs7m+Kjp0=4EEQ38i0q5Y__39817.6539260477$1291048215$gmane$org@mail.gmail.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Yoshiya.Hirase@nokia.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 30, 2010 at 11:28 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wro=
te:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>
> Based on the original work from Romit and Raghu at TI. The original
> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>
> *1: https://patchwork.kernel.org/patch/96442/
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

(snip)

> +config ARCH_HIBERNATION_POSSIBLE
> + =A0 =A0 =A0 def_bool y
> + =A0 =A0 =A0 depends on CPU_V7 && !SMP
> +

(snip)

> +/*
> + * FIXME: Only support for Cortex A8 now
> + */

(snip)

> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,7 +149,6 @@ SECTIONS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__init_end =3D .;
> =A0#endif
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOSAVE_DATA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CACHELINE_ALIGNED_DATA(32)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -172,6 +171,8 @@ SECTIONS
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0_edata_loc =3D __data_loc + SIZEOF(.data);
>
> + =A0 =A0 =A0 NOSAVE_DATA
> +
> =A0#ifdef CONFIG_HAVE_TCM
> =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * We align everything to a page boundary so we can
> --

I have been working on the hibernation feature on S5PC210 (ARM Cortex
A9 MP-Core) based on this patch and it's working find with minor
modifications. (and will send as soon as clutters are removed and
tested further)

However, I've got a question on your patch: is it really necessary to
patch [arch/arm/kernel/vmlinux.lds.S] file? Without patching that
file, it works fine at my system (although it's based on 2.6.36, not
37 rc #) and with that patch, the linker spits an error. If it's
necessary to patch [arch/arm/kernel/vmlinux.lds.S], could you please
explain a bit about it?

Thank you.


- MyungJoo

> 1.7.1.rc2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
