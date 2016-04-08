From: Kelvin Cheung <keguang.zhang@gmail.com>
Subject: Re: [PATCH V2 4/7] mtd: nand: add Loongson1 NAND driver
Date: Fri, 8 Apr 2016 22:30:21 +0800
Message-ID: <CAJhJPsXaidmMUX7CcTHshaYGZ-iqbaAExMh6eoOFDEAuzp4t7A@mail.gmail.com>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <1460115779-13141-4-git-send-email-keguang.zhang@gmail.com> <57079B87.9030209@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35461 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcDHOan (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 10:30:43 -0400
In-Reply-To: <57079B87.9030209@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-mips@linux-mips.org, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>

On 04/08/2016 07:52 PM, Richard Weinberger wrote:
> Am 08.04.2016 um 13:42 schrieb Keguang Zhang:
>> + chip->options = NAND_NO_SUBPAGE_WRITE;
>> + chip->ecc.mode = NAND_ECC_SOFT;
> Is the lack of HW ECC and subpage write a hardware limitation?

Yes, that's the hardware limitation of Loongson1B NAND controller.

> Thanks,
> //richard

Best regards,

Keguang Zhang
