From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Suspend ops on x86 architectures.
Date: Mon, 19 Nov 2007 10:02:50 +0100
Message-ID: <38b2ab8a0711190102x105f1905u64be6758a6b5f36c@mail.gmail.com>
References: <38b2ab8a0711181319y6d29b1dt1e8014cb3c5f4424@mail.gmail.com>
	<200711182312.22689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711182312.22689.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Nov 18, 2007 11:12 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Sunday, 18 of November 2007, Francis Moreau wrote:
> > Hello,
> >
> > I'm trying to get an idea on how suspend works on Linux. I already looked at
> > Documentation/power, but I'm clueless about x86 architectures. They don't
> > seem to define any suspend ops.
>
> Yes, they do, via ACPI.  Please see drivers/acpi/sleep/main.c .
>
> > Can anyone give me some pointers or some hints, I'd like to look at the
> > low level part of the suspend on these architectures also I'd like to know
> > what kind of events wake up the system once it's suspended. I guess
> > interrupts are used but which ones exactly.
>
> This also is controlled by ACPI.  The ACPI platform firmware handles the
> wake-up events and transfers control to the kernel by jumping to an address
> specified before the suspend.
>
> > Also I'm wondering how jiffies or system clock are updated correctly after
> > resuming.
>
> AFAICS, we use the pre-suspend value of jiffies.  The generic clocksource
> timekeeping is handled by timekeeping_resume() in kernel/time/timekeeping.c .
>

Thanks the hints, I'm going to take a look to ACPI then.

-- 
Francis
