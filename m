From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend ops on x86 architectures.
Date: Sun, 18 Nov 2007 23:12:22 +0100
Message-ID: <200711182312.22689.rjw@sisk.pl>
References: <38b2ab8a0711181319y6d29b1dt1e8014cb3c5f4424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <38b2ab8a0711181319y6d29b1dt1e8014cb3c5f4424@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 18 of November 2007, Francis Moreau wrote:
> Hello,
> 
> I'm trying to get an idea on how suspend works on Linux. I already looked at
> Documentation/power, but I'm clueless about x86 architectures. They don't
> seem to define any suspend ops.

Yes, they do, via ACPI.  Please see drivers/acpi/sleep/main.c .

> Can anyone give me some pointers or some hints, I'd like to look at the
> low level part of the suspend on these architectures also I'd like to know
> what kind of events wake up the system once it's suspended. I guess
> interrupts are used but which ones exactly.

This also is controlled by ACPI.  The ACPI platform firmware handles the
wake-up events and transfers control to the kernel by jumping to an address
specified before the suspend.

> Also I'm wondering how jiffies or system clock are updated correctly after
> resuming.

AFAICS, we use the pre-suspend value of jiffies.  The generic clocksource
timekeeping is handled by timekeeping_resume() in kernel/time/timekeeping.c .

Greetings,
Rafael
