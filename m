From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 prototype
Date: Thu, 18 Apr 2013 10:56:08 +0200
Message-ID: <516FB528.90006@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org> <516FAF28.80002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:48914 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966262Ab3DRI4N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 04:56:13 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so1138288bkc.29
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 01:56:11 -0700 (PDT)
In-Reply-To: <516FAF28.80002@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/18/2013 10:30 AM, Santosh Shilimkar wrote:
> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>> Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
>> 'shmobile_enter_wfi' but we forgot to remove the definition in the h=
eader file.
>>
>> Note this function is just an alias to 'cpu_do_idle()' wrapped into =
a cpuidle
>> function callback prototype which already exists with the default WF=
I state
>> and the arm_simple_enter function.
>>
>> Remove the function prototype.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> You can actually fold this into 1/19. No strong opinion though.

Initially it was folded but Simon wanted to split it in two, thus 1/19
and 2/19.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

