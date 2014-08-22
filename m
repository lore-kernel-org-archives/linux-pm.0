From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
Date: Fri, 22 Aug 2014 07:52:49 +0200
Message-ID: <53F6DAB1.9020001@monstr.eu>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com> <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com> <4ac42f4d-72bf-4a8d-a997-094f129d7c74@BN1AFFO11FD020.protection.gbl> <9c7c26e1-4098-4252-a719-fb7b7205be61@BN1AFFO11FD006.protection.gbl>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="esr4mJLf5gHeHliFMEeGFxnVN8o1LmpJf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:59929 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaHVFwy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 01:52:54 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so10142155wes.14
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2014 22:52:52 -0700 (PDT)
In-Reply-To: <9c7c26e1-4098-4252-a719-fb7b7205be61@BN1AFFO11FD006.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--esr4mJLf5gHeHliFMEeGFxnVN8o1LmpJf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2014 09:02 PM, S=C3=B6ren Brinkmann wrote:
> On Thu, 2014-08-21 at 02:28PM +0200, Michal Simek wrote:
>> On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
>>> Match the naming pattern of all other SMP ops and rename
>>> zynq_platform_cpu_die --> zynq_cpu_die.
>>>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> ---
>>>  arch/arm/mach-zynq/platsmp.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsm=
p.c
>>> index 04e578718aa2..95933c5e70e1 100644
>>> --- a/arch/arm/mach-zynq/platsmp.c
>>> +++ b/arch/arm/mach-zynq/platsmp.c
>>> @@ -138,7 +138,7 @@ static int zynq_cpu_kill(unsigned cpu)
>>>   *
>>>   * Called with IRQs disabled
>>>   */
>>> -static void zynq_platform_cpu_die(unsigned int cpu)
>>> +static void zynq_cpu_die(unsigned int cpu)
>>>  {

Sorry for incorrect place - I mean to use kernel-doc here not below. :-)


>>>  	zynq_slcr_cpu_state_write(cpu, true);
>>> =20
>>> @@ -158,7 +158,7 @@ struct smp_operations zynq_smp_ops __initdata =3D=
 {
>>>  	.smp_boot_secondary	=3D zynq_boot_secondary,
>>>  	.smp_secondary_init	=3D zynq_secondary_init,
>>>  #ifdef CONFIG_HOTPLUG_CPU
>>> -	.cpu_die		=3D zynq_platform_cpu_die,
>>> +	.cpu_die		=3D zynq_cpu_die,
>>>  	.cpu_kill		=3D zynq_cpu_kill,
>>>  #endif
>>>  };
>>
>> Will be good if you can move fix that kernel-doc format for this funct=
ion
>> too. It is just nice to have thing.
>=20
> All these SMP-ops should be documented in the header defining that
> struct, shouldn't they?

This struct is not necessary. I have added comment to wrong place.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--esr4mJLf5gHeHliFMEeGFxnVN8o1LmpJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlP22rEACgkQykllyylKDCGQQgCfbnYaZMHESzaMPiJsxT7s9LST
eJgAn1gUeByYxo/JC1mXdS9b42LX9CjR
=9+sD
-----END PGP SIGNATURE-----

--esr4mJLf5gHeHliFMEeGFxnVN8o1LmpJf--
