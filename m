From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] PM / sleep: Support power button wakeup from S2I on recent Dell laptops
Date: Thu, 04 May 2017 16:33:40 +0200
Message-ID: <31153495.XRWftVVQSP@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 26, 2017 11:21:11 PM Rafael J. Wysocki wrote:
> Hi All,
> 
> The underlying issue is that on some relatively new Dell laltops, including
> Dell XPS13 9360 and 9365, pressing the power button is not sufficient to
> wake up the system from suspend-to-idle (it has to be pressed and held
> down for around 5 sec for the wakeup to happen) which is not expected
> and does not match the Windows' behavior.
> 
> This turns out to be a consequence of the way power button events are signaled
> on those systems, which is through the Embedded Controller (EC).  Namely,
> button events go to the EC which then signals the event through its ACPI GPE
> (General Purpose Event), which triggers an ACPI SCI (System Control Interrupt),
> whose handler executes a specicif AML control method and triggers a Notify()
> targetting a devie object associated with the power button.  The problem with
> suspend-to-idle is that the EC GPE is disabled during suspend, because
> otherwise all EC events would wake up the system from suspend-to-idle (and
> there can be many of them).
> 
> The only way to address this is to allow the EC GPE to stay enabled while
> suspended to idle, but that cannot be done unconditionally, because of the
> possible spurious wakeup events from the EC.  Fortunately, on the Dell systems
> in question it is possible to reduce the number of events coming from the EC
> while suspended (see the changelog of patch [3/5] for details), but still some
> spurious events may happen.  For this reason, when there is an SCI while
> suspended, it is not practical to resume all the way up to user space.
> Instead, it is better to resume partially up to the point at which the SCI can
> be processed by its handler, which is after calling dpm_resume_noirq(), let
> the SCI be processed and if no real wakeup events come out of that,
> suspend again.  Actually, that can be done in general, because spurious
> SCIs do happen while suspended to idle on other systems too, and that's
> which it goes as patch [2/5] before the Dell-related changes.
> 
> Patch [1/5] is more of a cleanup, but makes the rest look slightly more
> straightforward, and patches [4-5/5] update the drivers used for button
> events processing on the affected systems so that they signal wakeup
> as expected and avoid propagating the wakeup events as button events
> to user space.
> 
> The series is available from a git branch at
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git s2idle-dell-test
> 
> and has been included into the testing branch thereof.
> 
> Please let me know if there are any concerns.

Patches [1-2/5] from this series don't seem to be controversial, so I'd like to
go ahead with them, as they are general improvements independent of the
rest of the series.

If anyone has any concerns about that, please let me know.

Thanks,
Rafael
