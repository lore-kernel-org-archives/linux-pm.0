From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 5/5] pm: Remove to_power_supply impl in ds278*
Date: Mon, 1 Jan 2018 11:56:59 +0200
Message-ID: <CAHp75VczqpO93aYec+dzJCZ1Nkcfi1Vx=7oVc3YBSFf6mkkQPQ@mail.gmail.com>
References: <20171231141757.GA4674@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45260 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAAJ5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 04:57:00 -0500
In-Reply-To: <20171231141757.GA4674@thinkpad>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>

On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> This patch fixes a issue introduced by patch:
> pm: add to_power_supply macro to the API
>
> In that patch a new macro has been defined in the
> power_supply.h header with the same name as the private
> function name in the ds278* battery modules that does the
> same thing, thus clashing and producing build errors.
>
> This patch removes that private implementation.

Must be folded into patch 2.

-- 
With Best Regards,
Andy Shevchenko
