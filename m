From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation units
Date: Sat, 18 Mar 2017 17:59:30 +0100
Message-ID: <CACRpkdYVP0snBv_K18qkKgDBVEZ19RYkDLb5Kp9dVTBo7rOAcA@mail.gmail.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 17, 2017 at 4:37 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Crystal Cove and Whiskey Cove are two different PMICs which are
> installed on Intel Atom SoC based platforms.
>
> Moreover there are two independent drivers that by some reason were
> supposed (*) to get into one kernel module.
>
> Fix the mess by clarifying Kconfig option for Crystal Cove and split
> Whiskey Cove out of it.
>
> (*) It looks like the configuration was never tested with
>     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> Cc: Linus Walleij <linus.walleij@linaro.org> (maintainer:GPIO SUBSYSTEM)
> Cc: Zhang Rui <rui.zhang@intel.com> (supporter:THERMAL)
> Cc: Eduardo Valentin <edubezval@gmail.com> (supporter:THERMAL)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
