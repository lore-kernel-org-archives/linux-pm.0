From: Simon Horman <horms@verge.net.au>
Subject: Re: [V2 patch 01/19] ARM: shmobile: cpuidle: remove
 shmobile_enter_wfi function
Date: Fri, 12 Apr 2013 16:06:21 +0900
Message-ID: <20130412070619.GA21350@verge.net.au>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
 <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org>
 <20130412004425.GD24461@verge.net.au>
 <5167ADF1.50401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51718 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab3DLHGY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 03:06:24 -0400
Content-Disposition: inline
In-Reply-To: <5167ADF1.50401@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, magnus.damm@gmail.com, tony@atomide.com, patches@linaro.org, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, rjw@sisk.pl, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, lethal@linux-sh.org, kernel@pengutronix.de

On =E9=87=91,  4=E6=9C=88 12, 2013 at 08:47:13=E5=8D=88=E5=89=8D +0200,=
 Daniel Lezcano wrote:
> On 04/12/2013 02:44 AM, Simon Horman wrote:
> > On Thu, Apr 11, 2013 at 10:42:31PM +0200, Daniel Lezcano wrote:
> >> Remove the shmobile_enter_wfi function which is the same as the
> >> common WFI enter function from the arm cpuidle driver defined
> >> with the ARM_CPUIDLE_WFI_STATE macro.
> > Should this patch also make shmobile_enter_wfi static in
> > arch/arm/mach-shmobile/cpuidle.c ?
>=20
> Hum, no :)

Ok, that was my other idea :^)

> Actually, the function was removed because it was expected to be not
> longer used. I missed the cpuidle driver in the pm-sh7372.c file and =
the
> function declaration in the header file.
> > Also, I have a slight preference for the patch to be split into two=
=2E
> > 1. A patch to remove usage of shmobile_enter_wfi from the sh7372 So=
C.
> > 2. A patch to remove shmobile_enter_wfi. from common.h
> >    (and make it static?).
>=20
> Ok, regarding my answer above, do you still want two patches for this=
 ?

Yes please.
