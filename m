From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: khibernation and ACPI
Date: Sat, 29 Sep 2007 10:44:17 +0800
Message-ID: <1191033857.11480.47.camel@caritas-dev.intel.com>
References: <1190970219.11480.5.camel@caritas-dev.intel.com>
	<200709281728.44401.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709281728.44401.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-09-28 at 17:28 +0200, Rafael J. Wysocki wrote:
> On Friday, 28 September 2007 11:03, Huang, Ying wrote:
> > In following text, khibernation is the abbreviation of "kexec based
> > hibernation".
> > 
> > 
> > 1. Kexec/kdump and ACPI
> > 
> > With Linux kernel 2.6.23-rc6-mm1 + khibernation patches on my IBM T42,
> > khibernation works well with ACPI. That is, the following is possible
> > with ACPI enabled.
> > 
> > a. Boot kernel A with ACPI on
> > b. Put devices in quiescent and low power state
> 
> How exactly?

Call device_suspend() and device_power_down().

> 
> > c. Kexec a new kernel B with ACPI on
> > d. Jump back to kernel A
> > 
> > I think it should be a standard feature that the kexeced kernel can be
> > booted properly with devices been put in low power state.
> 
> Agreed.
> 
> > Because, if the dynamic power management is enabled, some idle devices will
> > be put into low power state even in G0, when a crash dump is triggered, the
> > crash dump kernel should be booted properly even with devices been put
> > in low power state. If this not supported, the crash dump can not work
> > on system with dynamic power management on.
> > 
> > 
> > 2. Khibernation and ACPI
> > 
> > Khibernation can work with ACPI even without feature above, because
> > image-writing kernel with initramfs can be booted independent of
> > device state. The scheme is as follow:
> > 
> > a. Boot kernel A with ACPI on
> > b. Put all devices in quiescent and low power state
> > c. Execute _PTS of ACPI
> > d. Kexec a new kernel B with ACPI on.
> 
> This may execute ACPI methods that should not be called after _PTS.
> 
> Unless you tell the new kernel not to initialize ACPI, that is.
> 
> > The root filesystem is initramfs, so that, the only devices needed by kernel
> > B is timer.
> > e. In kernel B, put needed devices back to normal state. 
> > f. Write memory image of kernel A out
> > g. Put all devices in quiescent and low power state
> > h. Execute acpi_enter_sleep_state(ACPI_STATE_S4)
> 
> Yes, apart from d. this looks doable.
> 

To deal with the issue of d, the following scheme can be used:

a. Boot kernel A with ACPI on
b. In kernel A, load the image of a new kernel B with sys_kexec_load
c. In kernel A, put all devices in quiescent and low power state
d. In kernel A, kexec kernel B with ACPI on (some devices may be put in
normal state during boot)
e. In kernel B, put all devices in quiescent and low power state
f. In kernel B, Jump back to kernel A
g. In kernel A, put all devices in normal state
h. In kernel A, put all devices in low power state
i. In kernel A, execute _PTS of ACPI
j. In kernel A, jump to kernel B again
k. In kernel B, put needed devices back to normal state.
l. In kernel B, write memory image of kernel A out
m. In kernel B, put all devices in quiescent and low power state
n. In kernel B, Execute acpi_enter_sleep_state(ACPI_STATE_S4)


The step g and h may be not necessary. If kernel B can put device to
normal state, it can put them in low power state too.

The step d ~ h is not necessary for every hibernation. The following
scheme can be used to speed up.

a. Boot kernel A with ACPI on
*b. In kernel A, if saved memory image of kernel B is present and valid,
load the saved memory image of kernel B; else load the image of kernel
B, both with sys_kexec_load.
c. In kernel A, put all devices in quiescent and low power state
*c1. In kernel A, if saved memory image of kernel B is present and
valid, go to step i
d. In kernel A, Kexec kernel B with ACPI on (at least some devices will
be put in normal state during boot)
e. In kernel B, put all devices in quiescent and low power state
f. In kernel B, Jump back to kernel A
g. In kernel A, put all devices in normal state
*g1. In kernel A, save the memory image of kernel B
h. In kernel A, put all devices in low power state
i. In kernel A, execute _PTS of ACPI
j. In kernel A, jump to kernel B again
k. In kernel B, put needed devices back to normal state.
l. In kernel B, write memory image of kernel A out
m. In kernel B, put all devices in quiescent and low power state
n. In kernel B, Execute acpi_enter_sleep_state(ACPI_STATE_S4)

The steps marked with * are different from the previous scheme.

Jumping between two kernel has been implemented now. Save memory image
of kernel B in kernel A has not been implemented, but it can be done
easily.


Best Regards,
Huang Ying
