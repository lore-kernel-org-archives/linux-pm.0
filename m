From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V2 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 function
Date: Fri, 12 Apr 2013 08:47:13 +0200
Message-ID: <5167ADF1.50401@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org> <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org> <20130412004425.GD24461@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:40555 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab3DLGrS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 02:47:18 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so1761327wey.31
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 23:47:17 -0700 (PDT)
In-Reply-To: <20130412004425.GD24461@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, magnus.damm@gmail.com, tony@atomide.com, patches@linaro.org, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, rjw@sisk.pl, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, lethal@linux-sh.org, kernel@pengutronix.de

On 04/12/2013 02:44 AM, Simon Horman wrote:
> On Thu, Apr 11, 2013 at 10:42:31PM +0200, Daniel Lezcano wrote:
>> Remove the shmobile_enter_wfi function which is the same as the
>> common WFI enter function from the arm cpuidle driver defined
>> with the ARM_CPUIDLE_WFI_STATE macro.
> Should this patch also make shmobile_enter_wfi static in
> arch/arm/mach-shmobile/cpuidle.c ?

Hum, no :)

Actually, the function was removed because it was expected to be not
longer used. I missed the cpuidle driver in the pm-sh7372.c file and th=
e
function declaration in the header file.
> Also, I have a slight preference for the patch to be split into two.
> 1. A patch to remove usage of shmobile_enter_wfi from the sh7372 SoC.
> 2. A patch to remove shmobile_enter_wfi. from common.h
>    (and make it static?).

Ok, regarding my answer above, do you still want two patches for this ?

Thanks
-- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

