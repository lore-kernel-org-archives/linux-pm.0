From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
Date: Tue, 26 Mar 2013 10:43:29 +0100
Message-ID: <51516DC1.1000807@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org> <20130326072458.GA7141@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:59831 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742Ab3CZJn3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 05:43:29 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so463516wib.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2013 02:43:28 -0700 (PDT)
In-Reply-To: <20130326072458.GA7141@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/26/2013 08:25 AM, Shawn Guo wrote:
> On Mon, Mar 25, 2013 at 06:55:30PM +0100, Daniel Lezcano wrote:
>> The initialization is done from the cpuidle framework.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/c=
puidle-imx6q.c
>> index 5ae22f7..a783a63 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
>> @@ -6,7 +6,6 @@
>>   * published by the Free Software Foundation.
>>   */
>> =20
>> -#include <linux/clockchips.h>
>=20
> Removing this causes the compile error below.
>=20
>   CC      arch/arm/mach-imx/cpuidle-imx6q.o
> arch/arm/mach-imx/cpuidle-imx6q.c: In function =E2=80=98imx6q_enter_w=
ait=E2=80=99:
> arch/arm/mach-imx/cpuidle-imx6q.c:25:2: error: implicit declaration o=
f function =E2=80=98clockevents_notify=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
> arch/arm/mach-imx/cpuidle-imx6q.c:25:21: error: =E2=80=98CLOCK_EVT_NO=
TIFY_BROADCAST_ENTER=E2=80=99 undeclared (first use in this function)
> arch/arm/mach-imx/cpuidle-imx6q.c:25:21: note: each undeclared identi=
fier is reported only once for each function it appears in
> arch/arm/mach-imx/cpuidle-imx6q.c:45:21: error: =E2=80=98CLOCK_EVT_NO=
TIFY_BROADCAST_EXIT=E2=80=99 undeclared (first use in this function)
> cc1: some warnings being treated as errors
> make[2]: *** [arch/arm/mach-imx/cpuidle-imx6q.o] Error 1


Hi Shawn,

actually this is because the patch applies on top of:

commit 12e849504b861470e5bf991f79c0be71b97c8dac
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu Mar 21 12:21:33 2013 +0000

    cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag

    Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
    to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
    this state.

    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

