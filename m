From: Hans de Goede <hdegoede@redhat.com>
Subject: Status of merging "power: supply: axp288_fuel_gauge: Drop
 platform_data dependency" patch ?
Date: Fri, 23 Dec 2016 22:13:45 +0100
Message-ID: <13747ac6-ff54-6e0b-1992-6d020209c58f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbcLWVN6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Dec 2016 16:13:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer@ya.ru" <russianneuromancer@ya.ru>

Hi Sebastian,

Thank you for merging all the axp288_charger patches into for-next-next.

When I posted the "power: supply: axp288_fuel_gauge: Drop platform_data dependency"
patch about a week ago you replied that it looked good, but you wanted to give
others a chance to respond. So I wonder what he status on this is now ?

In the mean time I've tested it successfully on another model cherrytrail
tablet with an axp288 pmic, and one of the people following:

https://bugzilla.kernel.org/show_bug.cgi?id=88471

Has tested it on yet another model, so from a testing pov it looks good.

I realize we still have a lot of time to get this merged for 4.11, just
making sure it does not fall through the cracks.

Regards,

Hans


p.s.

Today you replied to:

"power: supply: axp288_fuel_gauge: Remove unnecessary irq?_en register writes"

That you merged it, but I don't see it in for-next-next, I guess it did not
apply without the $subject patch ?
