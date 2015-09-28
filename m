From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Mon, 28 Sep 2015 22:09:35 +0200
Message-ID: <CAJZ5v0gMin9AtT=Jcs8cLK_dU8Hea4ByJh_kf04QdWDtO5mfSA@mail.gmail.com>
References: <1439172686-16360-1-git-send-email-yu.c.chen@intel.com>
	<14896395.L30bH9BMzP@vostro.rjw.lan>
	<36DF59CE26D8EE47B0655C516E9CE64026587A89@SHSMSX101.ccr.corp.intel.com>
	<2077382.8itqOgEaxv@vostro.rjw.lan>
	<36DF59CE26D8EE47B0655C516E9CE64026F22661@SHSMSX101.ccr.corp.intel.com>
	<CAJZ5v0h=fjAzLKOio1sAH3J_3FL6pY041jiLvLs8MPTkbvm9Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33726 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbI1UJg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 16:09:36 -0400
In-Reply-To: <CAJZ5v0h=fjAzLKOio1sAH3J_3FL6pY041jiLvLs8MPTkbvm9Ag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Sep 28, 2015 at 10:05 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Mon, Sep 28, 2015 at 7:56 PM, Chen, Yu C <yu.c.chen@intel.com> wrote:

[cut]

>>> > Because the name of acpi_irq is already used by acpi irq handler at
>>> > drivers/acpi/osl.c:
>>> > request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)
>>>
>>> Ah, this is the name of the handler.  I forgot about that, sorry.
>>>
>>> Well, it might be worth renaming the handler to something like
>>> acpi_interrupt(), then.
>> OK, will rewrite the patch, Thanks!
>
> Alternatively, you can call the new variable acpi_sci_irq.

BTW, please CC ACPI-related patches to linux-acpi too.

Thanks,
Rafael
