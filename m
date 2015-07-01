From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
Date: Wed, 1 Jul 2015 18:56:29 +0200
Message-ID: <CAMuHMdW1BaJ8rsd9LQMSJusgG=4jrWm1C=UwioK_fM2bj3nX5w@mail.gmail.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
	<1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
	<55940FCD.5070901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34436 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbGAQ43 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 12:56:29 -0400
In-Reply-To: <55940FCD.5070901@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 1, 2015 at 6:05 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 30/06/15 18:18, Gregory CLEMENT wrote:
>> On the Armada 375/38x/39x SoCs, in standby mode the SoCs stay powered
>> and it is possible to wake-up from any interrupt sources. This patch
>> adds flag to the GIC irqchip driver to let linux know this.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>   arch/arm/mach-mvebu/board-v7.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-mvebu/board-v7.c
>> b/arch/arm/mach-mvebu/board-v7.c
>> index e5911defccac..f446230e7416 100644
>> --- a/arch/arm/mach-mvebu/board-v7.c
>> +++ b/arch/arm/mach-mvebu/board-v7.c

>> @@ -129,6 +131,11 @@ static int armada_375_external_abort_wa(unsigned long
>> addr, unsigned int fsr,
>>
>>   static void __init mvebu_init_irq(void)
>>   {
>> +       if (of_machine_is_compatible("marvell,armada375") ||
>> +           of_machine_is_compatible("marvell,armada380") ||
>> +           of_machine_is_compatible("marvell,armada390"))
>> +               gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
>> +                                     IRQCHIP_MASK_ON_SUSPEND);
>
>
> I am planning to add these flags in the GIC driver itself and remove
> this function. I will post the patch next week once merge window closes
> next, so based on how that discussion proceeds you may have drop this
> patch, just heads up.

Tried that before...

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331813.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
