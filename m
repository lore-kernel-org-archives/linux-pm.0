From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Mon, 28 Apr 2008 15:20:05 -0700
Message-ID: <200804281520.05683.david-b__39659.322895068$1209421407$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<1209386885.884.9.camel@yakui_zhao.sh.intel.com>
	<20080428213553.GA3489@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080428213553.GA3489@khazad-dum.debian.net>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 28 April 2008, Henrique de Moraes Holschuh wrote:
> On Mon, 28 Apr 2008, Zhao Yakui wrote:
> > Yes. What your said is right. If your patch is applied, whether the PCI
> > device can wake the sleeping system is controlled by device driver. In
> > such case the /proc/acpi/wakeup will be useless.
> 
> Which calls for a new standard interface to let userpace control that,
> doesn't it?  Issues with wake-up devices are not uncommon, the user
> really has to have a way to configure that, and IMHO it better be a
> generic one...

That "new standard interface" has been in the kernel for quite
some time now:  /sys/devices/.../power/wakeup attributes, which
default to "enabled" for wake-capable devices.  Set to "disabled"
if it's not behaving on your system for some reason.  It's part
of the driver model infrastructure.

These patches have been nudging ACPI switch over to that generic
mechanism, instead of needing an ACPI-specific one... first posted
on the order of 18 months ago, FWIW.


Note that there are (broadly) two categories of issue here.  One
is with the hardware/firmware ... e.g. ACPI, on systems where that
exists.  (By far the minority in terms of Linux platforms, and maybe
in terms of individual systems too, despite the fact that most of
us developers run x86 Linux somewhere.)  The other is inside the driver
itself:  does it arrange for the right things to be wake events, and
handle them OK.

When I last did a survey of what drivers use PCI wakeup mechanisms,
the result was pretty weak:  a handful of network drivers, and the
USB host controllers.  Such support has been, if anything, declining
since we acquired "pm_message_t".  But I believe that most of those
drivers actually behave, at least on non-ACPI systems.

Try "cd linux-2.6; grep -lr pci_enable_wake *" for current results...

- Dave
