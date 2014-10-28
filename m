From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: v3.18-rc2 compilation under a x86 KVM failed in drivers/thermal/thermal_core.c:
Date: Tue, 28 Oct 2014 14:47:39 +0000
Message-ID: <9hh1tpsz1x0.fsf@arm.com>
References: <544E6F5C.7040900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52520 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751901AbaJ1Orr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Oct 2014 10:47:47 -0400
In-Reply-To: <544E6F5C.7040900@gmx.de> ("Toralf =?utf-8?Q?F=C3=B6rster=22'?=
 =?utf-8?Q?s?= message of "Mon, 27
	Oct 2014 17:14:20 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

Hi Toralf,

Toralf F=C3=B6rster <toralf.foerster@gmx.de> writes:

> Is this an already known issue ? :
>
>   CC      drivers/thermal/thermal_core.o
> drivers/thermal/thermal_core.c: In function =E2=80=98handle_critical_=
trips=E2=80=99:
> drivers/thermal/thermal_core.c:374:2: error: implicit declaration of =
function =E2=80=98trace_thermal_zone_trip=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
> drivers/thermal/thermal_core.c: In function =E2=80=98update_temperatu=
re=E2=80=99:
> drivers/thermal/thermal_core.c:471:2: error: implicit declaration of =
function =E2=80=98trace_thermal_temperature=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
> drivers/thermal/thermal_core.c: In function =E2=80=98thermal_cdev_upd=
ate=E2=80=99:
> drivers/thermal/thermal_core.c:1296:2: error: implicit declaration of=
 function =E2=80=98trace_cdev_update=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
> cc1: some warnings being treated as errors
> scripts/Makefile.build:257: recipe for target 'drivers/thermal/therma=
l_core.o' failed
> make[2]: *** [drivers/thermal/thermal_core.o] Error 1
> scripts/Makefile.build:402: recipe for target 'drivers/thermal' faile=
d
> make[1]: *** [drivers/thermal] Error 2
> Makefile:936: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....

Error suggests that the newly added trace to thermal core isn't being
found. But...
=20
=2E..I just tried compiling x86_64_defconfig with both trace enabled an=
d
dis-abled on native x86 box and failed to reproduce above issue.=20

Is there anything special about building the kernel in a kvm?

Could you attach the failing config please?

Cheers,
Punit
