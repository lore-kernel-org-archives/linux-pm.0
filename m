From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Sat, 26 Apr 2008 12:37:26 -0700
Message-ID: <200804261237.26499.david-b__12299.0380427384$1209239063$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200804182118.05228.david-b@pacbell.net>
	<1208871017.14474.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208871017.14474.52.camel@yakui_zhao.sh.intel.com>
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
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 April 2008, Zhao Yakui wrote:
> Agree with what Rui said. The patch doesn't change the time when GPEs
> are enabled/disabled.

So you also think my worries were unfounded?  OK, I'm happy
to hear that.  It means the userspace model for wakeup events
on PCs can become one that non-ACPI platforms can use too.

In which case ... I'll resend this patch with a more concise
summary and a signed-off-by line.


> But after the patch is applied, some PCI device(the ACPI device with the
> _PRW object) can wake the sleeping system by default. And it is totally
> opposite to the current flowchart. 

That's not true.  Behavior could only change for devices with
drivers which already call pci_enable_wake()!

What's different is that /proc/acpi/wakeup is being taken
partially out of the decision loop ... in favor of (a) driver
model flags, which work on platforms without ACPI, and also
(b) device driver logic, which in any case really needs to
be prepared to request and otherwise manage the wake events.

If someone sets /proc/acpi/wakeup flags for a device, it
could still be made to issue wake events for devices with
drivers that don't expect (or handle) those events.

- Dave
