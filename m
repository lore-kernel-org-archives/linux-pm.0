From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
Date: Tue, 26 Mar 2013 13:53:34 +0100
Message-ID: <51519A4E.4050501@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org> <20130326072458.GA7141@S2101-09.ap.freescale.net> <51516DC1.1000807@linaro.org> <CAAQ0ZWQ-zex62SKNREK+fuRSg-djpu6dF-qN1Me+8ZEJ=E3F9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51442 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759406Ab3CZMxe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 08:53:34 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj8so754642wib.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2013 05:53:33 -0700 (PDT)
In-Reply-To: <CAAQ0ZWQ-zex62SKNREK+fuRSg-djpu6dF-qN1Me+8ZEJ=E3F9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/26/2013 01:40 PM, Shawn Guo wrote:
> On Tue, Mar 26, 2013 at 10:43:29AM +0100, Daniel Lezcano wrote:
>> Hi Shawn,
>>
>> actually this is because the patch applies on top of:
>>
> Ah, ok. It will be helpful for people who want to test the series on
> their platform, if you can publish a branch for that.

Yes, sure.

It is in Rafael's tree.

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git

in linux-next branch.

Thanks for the review

  -- Daniel

>> commit 12e849504b861470e5bf991f79c0be71b97c8dac
>> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Date:   Thu Mar 21 12:21:33 2013 +0000
>>
>>     cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag
>>
>>     Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>>     to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when enterin=
g
>>     this state.
>>
>>     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

