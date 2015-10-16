From: shrybman <shrybman@teksavvy.com>
Subject: Re: [PATCH 1/2] x86 smpboot: fix cpu_init_udelay=10000
Date: Fri, 16 Oct 2015 15:34:11 -0400
Message-ID: <0bc26e9524533c38fdbdc95eed2b1448@teksavvy.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
	<de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:53959 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753504AbbJPTeN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 15:34:13 -0400
In-Reply-To: <de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dparsons@brightdsl.net, x86@kernel.org, Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>

> From: Len Brown <len.brown@intel.com>
>=20
> For legacy machines cpu_init_udelay defaults to 10,000.
> For modern machines it is set to 0.
>=20
> The user should be able to set cpu_init_udelay to
> any value on the cmdline, including 10,000.
> Before this patch, that was seen as "unchanged from default"
> and thus on a modern machine, the user request was ignored
> and the delay was set to 0.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index e0c198e..32267cc 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -509,7 +509,7 @@ void __inquire_remote_apic(int apicid)
>  =C2=A0*/
>  #define UDELAY_10MS_DEFAULT 10000
> =20
> -static unsigned int init_udelay =3D UDELAY_10MS_DEFAULT;
> +static unsigned int init_udelay =3D INT_MAX;
> =20
>  static int __init cpu_init_udelay(char *str)
>  {
> @@ -522,13 +522,16 @@ early_param("cpu_init_udelay", cpu_init_udelay)=
;
>  static void __init smp_quirk_init_udelay(void)
>  {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* if cmdline changed it from default,=
 leave it alone */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (init_udelay !=3D UDELAY_10MS_DEFAU=
LT)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (init_udelay !=3D INT_MAX)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> =20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* if modern processor, use no delay *=
/
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (((boot_cpu_data.x86_vendor =3D=3D =
X86_VENDOR_INTEL) && (boot_cpu_data.x86 =3D=3D 6)) ||
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0((boot_cpu_data.x86_vend=
or =3D=3D X86_VENDOR_AMD) && (boot_cpu_data.x86 >=3D 0xF)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_ude=
lay =3D 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* else, use legacy delay */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_udelay =3D UDELAY_10MS_DEFAULT;


Hi Len,


Is this really what you intended? The else is commented out so if init_=
udelay is quirked
to be 0 it will always be reset to=C2=A0UDELAY_10MS_DEFAULT. Also init_=
udelay is unsigned, so
would UINT_MAX be a better choice?


Shane

