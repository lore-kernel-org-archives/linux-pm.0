From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Wed, 10 Jan 2018 15:24:21 +0200
Message-ID: <1515590661.7000.855.camel@linux.intel.com>
References: <4046497.JI7UjL75gC@aspire.rjw.lan>
         <12541194.33112yYDjW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <12541194.33112yYDjW@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-01-10 at 13:26 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some systems don't support the ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT
> functions in their Low Power S0 Idle _DSM, but still expect EC
> events to be processed in the suspend-to-idle state for power button
> wakeup (among other things) to work.  Surface Pro3 turns out to be
> one of them.
> 
> Fortunately, it still provides Low Power S0 Idle _DSM with the screen
> on/off functions supported, so modify the ACPI suspend-to-idle to use
> the Low Power S0 Idle code path for all systems supporting the
> ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT or the ACPI_LPS0_SCREEN_OFF and
> ACPI_LPS0_SCREEN_ON functions in their Low Power S0 Idle _DSM.
> 
> Potentially, that will cause more systems to use suspend-to-idle by
> default, so some future corrections may be necessary if it leads
> to issues, but let it remain more straightforward for now.
 
> -#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> ACPI_LPS0_EXIT))
> +#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) |
> (1 << ACPI_LPS0_SCREEN_ON))

> +#define ACPI_LPS0_S2I_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> ACPI_LPS0_EXIT))

Just a nitpick: Can we leave S2IDLE instead of S2I?
Would it make sense for potential code readers?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
