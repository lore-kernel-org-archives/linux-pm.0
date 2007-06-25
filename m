From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target
	method in pm_ops
Date: Sun, 24 Jun 2007 19:11:16 -0700
Message-ID: <200706241911.18201.david-b__43437.1036979885$1182737536$gmane$org@pacbell.net>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242240.40476.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 24 June 2007, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Some drivers may need to use ACPI to determine the low power states in which
> to place their devices, but to provide the drivers with this information the
> ACPI core needs to know what sleep state the system is going to enter.

It also needs to export that to things like the ACPI-to-PCI glue
code.  So it would be good if you defined the missing routine now,
saving the effort of patching it in later:

	int acpi_get_target_sleep_state(void);

It doesn't need EXPORT_SYMBOL().


> Namely, the device's state should not be too high power for given system sleep
> state and, if the device is supposed to be able to wake up the system, its state
> should not be too low power for the wake up to be possible).  However,
> pm_ops->prepare() is only called after the drivers' .suspend() callbacks have
> been executed, 

That's a critical point that should show up in your doc updates.


> so we need an additional means to pass the information of the 
> target system sleep state to the ACPI core.  For this purpose, we can introduce
> an additional member function in 'struct pm_ops'.
> 
> Additionally, the at91 platform code incorrectly assumes that pm_ops->prepare()
> will be called before devices are suspended and uses it for setting the target
> system sleep state, so pm_ops->prepare() should to be replaced with the new
> operation, pm_ops->set_target(), for this architecture.

That was originally correct ... but as you pointed out, the
semantics there changed in RC5.

Which means this patch is a *BUGFIX*, preventing what would
otherwise be a regression in 2.6.22 ... and so it should
be merged for RC6 or so.


Another way to describe the changes is that set_target() now
does what prepare() used to do, while prepare() serves a
new role.  A role which still needs to be well-described in
the documentation you provided, by the way... it seems to
do whatever needs to be done after devices suspend but
before nonboot CPUs are disabled.

- Dave
