From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] power: Fix unmet dependency on POWER_SUPPLY by
 POWER_RESET by uncoupling them
Date: Mon, 07 Dec 2015 11:12:39 +0900
Message-ID: <5664EB17.5000309@samsung.com>
References: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
 <20151205005937.GF22936@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:55516 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbbLGCMs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2015 21:12:48 -0500
In-reply-to: <20151205005937.GF22936@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Pavel Fedin <p.fedin@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On 05.12.2015 09:59, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Dec 02, 2015 at 02:59:06PM +0900, Krzysztof Kozlowski wrote:
>> Actually reset/power off handlers do not really depend on power supply.
>> Move the power reset out of power supply block so it will appear in main
>> drivers section. This fixes following build warning (encountered on ARM
>> exynos defconfig when POWER_SUPPLY is disabled manually):
>>
>> warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS && REALVIEW_DT) selects POWER_RESET which has unmet direct dependencies (POWER_SUPPLY)
>> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
>> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
> 
> nice catch. I don't really like the Makefile changes, though. I think
> it would be better to make the power/ entry in drivers/Makefile into
> "obj-y" and handle the details in drivers/power/Makefile.

You idea indeed looks better, I'll send a v2.

Best regards,
Krzysztof

