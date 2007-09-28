From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: khibernation and ACPI
Date: Fri, 28 Sep 2007 17:28:43 +0200
Message-ID: <200709281728.44401.rjw@sisk.pl>
References: <1190970219.11480.5.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190970219.11480.5.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 28 September 2007 11:03, Huang, Ying wrote:
> In following text, khibernation is the abbreviation of "kexec based
> hibernation".
> 
> 
> 1. Kexec/kdump and ACPI
> 
> With Linux kernel 2.6.23-rc6-mm1 + khibernation patches on my IBM T42,
> khibernation works well with ACPI. That is, the following is possible
> with ACPI enabled.
> 
> a. Boot kernel A with ACPI on
> b. Put devices in quiescent and low power state

How exactly?

> c. Kexec a new kernel B with ACPI on
> d. Jump back to kernel A
> 
> I think it should be a standard feature that the kexeced kernel can be
> booted properly with devices been put in low power state.

Agreed.

> Because, if the dynamic power management is enabled, some idle devices will
> be put into low power state even in G0, when a crash dump is triggered, the
> crash dump kernel should be booted properly even with devices been put
> in low power state. If this not supported, the crash dump can not work
> on system with dynamic power management on.
> 
> 
> 2. Khibernation and ACPI
> 
> Khibernation can work with ACPI even without feature above, because
> image-writing kernel with initramfs can be booted independent of
> device state. The scheme is as follow:
> 
> a. Boot kernel A with ACPI on
> b. Put all devices in quiescent and low power state
> c. Execute _PTS of ACPI
> d. Kexec a new kernel B with ACPI on.

This may execute ACPI methods that should not be called after _PTS.

Unless you tell the new kernel not to initialize ACPI, that is.

> The root filesystem is initramfs, so that, the only devices needed by kernel
> B is timer.
> e. In kernel B, put needed devices back to normal state. 
> f. Write memory image of kernel A out
> g. Put all devices in quiescent and low power state
> h. Execute acpi_enter_sleep_state(ACPI_STATE_S4)

Yes, apart from d. this looks doable.

Greetings,
Rafael
