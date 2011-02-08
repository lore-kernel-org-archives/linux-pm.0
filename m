From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Tue, 8 Feb 2011 13:21:59 +0100
Message-ID: <20110208122159.GA8284__11798.3053475202$1297167813$gmane$org@elte.hu>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072046.48763.rjw@sisk.pl>
	<20110207201803.GU10564@opensource.wolfsonmicro.com>
	<201102072215.59921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072215.59921.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> I'd appreciate it if people could review/test it and drop their comments.
> 
> Thanks,
> Rafael
> 
> ---
>  arch/x86/xen/Kconfig               |    2 +-
>  drivers/acpi/Kconfig               |    1 -
>  drivers/acpi/bus.c                 |    4 +---
>  drivers/acpi/internal.h            |    6 ++++++
>  drivers/acpi/sleep.c               |   13 +++++++++++--
>  drivers/base/power/Makefile        |    3 +--
>  drivers/net/e1000e/netdev.c        |    8 ++++----
>  drivers/net/pch_gbe/pch_gbe_main.c |    2 +-
>  drivers/pci/pci-driver.c           |    4 ++--
>  drivers/scsi/Makefile              |    2 +-
>  drivers/scsi/scsi_priv.h           |    2 +-
>  drivers/scsi/scsi_sysfs.c          |    2 +-
>  drivers/usb/core/hcd-pci.c         |    4 ++--
>  include/acpi/acpi_bus.h            |    2 +-
>  include/linux/pm.h                 |    2 +-
>  kernel/power/Kconfig               |   29 +++--------------------------
>  16 files changed, 37 insertions(+), 49 deletions(-)

Ok, there's some real bang for bucks in this patch, nice! It's a beginning.

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Also, i've Cc:-ed Linus, to check whether the idea to make power management a 
permanent, core portion of Linux has any obvious downsides we missed.

Rafael, could you do a defconfig-ish x86 build with and without CONFIG_PM, and post 
the 'size vmlinux' comparison - so that we can see the size difference? We make some 
things CONFIG_EXPERT configurable just to enable folks who *really* want to cut down 
on kernel size to configure it out.

Note that those usecases, even if they want a super-small kernel, might not care 
about PM at all while they care about size: small boot kernels in ROMs, or simple 
devices where CPU-idling implies deep low power mode, etc.

So the vmlinux size comparisons would be needed really. If it's 5k nobody will care. 
If it's 50k-100k that's borderline. In the other side of the scale we have the 1500+
#ifdef CONFIG_PM lines strewn around the kernel source, and the frequent !PM build
breakages.

	Ingo
