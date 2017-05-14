From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] ACPI / sleep: Simplify suspend-to-idle event processing loop
Date: Sun, 14 May 2017 13:17:51 +0200
Message-ID: <9231606.5a3ByxjlJX@aspire.rjw.lan>
References: <2169867.RZcCZmJK9B@aspire.rjw.lan> <4299064.sJpOkfBeiA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4299064.sJpOkfBeiA@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, May 14, 2017 01:57:13 AM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle) modified the core suspend-to-idle code to filter
> out spurious SCI interrupts received while suspended, but it
> implemented that by resuming the system partially every time an
> SCI triggers wakeup, so that the SCI handler can run (and possibly
> further event handlers invoked by it can run too), which requires the
> "noirq" phase of device resume to be carried out.  One drawback of
> that implementation is that PCI devices are put into the full-power
> state (D0) during the "noirq" resume phase and they need to be put
> into low-power states again in case the wakeup event turns out to be
> spurious, which may cause some unpleasant power fluctuations in the
> system to happen among other things.
> 
> However, that can be avoided by using the observation that it is
> generally possible to call the SCI handler directly from the ACPI
> suspend-to-idle ->wake callback and the processing initiated by it
> can be carried out before the "noirq" phase of device resume starts,
> so if the SCI interrupt turns out to be non-wakeup, the system can
> go back to sleep immediately.
> 
> Implement that idea, drop the suspend-to-idle ->sync callback added
> by commit eed4d47efe95 as it is not necessary any more and simplify
> the suspend-to-idle event processing loop in the core code.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Scratch this one.

It is not sufficient to run the SCI handler alone, the SCI IRQ has to be
re-armed properly for system wakeup too, so resume_device_irqs()
and suspend_device_irqs() need to run for that.

Thanks,
Rafael

