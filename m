From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 2/5] pm: add to_power_supply macro to the API
Date: Mon, 1 Jan 2018 11:56:17 +0200
Message-ID: <CAHp75VeBLaes42NN1L4ujfvkYAUOW9h9Q26mfsj7e7a86OC_Yg@mail.gmail.com>
References: <20171231141700.GA4612@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171231141700.GA4612@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> This patch adds the to_power_supply macro to upcast
> a device to a power_supply struct.
>
> This is needed because the same piece of code using
> container_of is used in various other places, so we
> abstract away such low-level operations via a macro.

The patch 5 must be folded into this one. I told you that.
Otherwise you will leave bisectability issue.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
>

> v9:
> * Split the pm changes from the thinkpad_acpi patch
> into its own patch
>
> v10:
> * No changes in this patch in v10
>
> v11:
> * Fix changelog formatting

Changelog should go *after* --- line...

> ---

...to here.

>  drivers/power/supply/power_supply_core.c | 2 +-
>  include/linux/power_supply.h             | 2 ++

-- 
With Best Regards,
Andy Shevchenko
