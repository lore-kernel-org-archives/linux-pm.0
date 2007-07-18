From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC] Replacing sysdevs with platform devices
Date: Wed, 18 Jul 2007 17:20:16 +0200
Message-ID: <200707181720.17263.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

Some time ago we agreed that it would be a good idea to stop using device
drivers' .suspend() and .resume() callbacks for hibernation and to introduce
new hibernation-specific driver callbacks.  I'm currently working on
implementing that and I'd like to avoid adding any hibernation-specific
callbacks to sysdev drivers.  For this reason, I thought I first would try to
replace sysdevs used for late suspending and early resuming with platform
devices, where possible and straightforward, so I have reviewed the code and
found that:

(1) In many cases sysdevs are used only for the late suspending and early
    resuming of platform-dependent stuff (such as , timers, local APICs etc.).
    These instances can be readily replaced with platform devices and platform
    drivers, so can you please tell me if patches to do that would be acceptable
    and useful?

(2) In some cases sysdevs are used for late suspending, early resuming and late
    shutdown of platform-dependent stuff (such as I/O APICs on x86* etc.).  In
    such cases, to replace sysdevs with platform devices we would need to
    add a .shutdown_late() callback to 'struct platform_driver' and a piece of
    infrastructure to execute these callbacks in device_shutdown(), right
    before or after, or instead of sysdev_shutdown().  Can you please tell me
    if that would be useful?

(3) In arch/x86_64/kernel/mce.c the sysdev is used for early resuming and
    communications with user space, so I don't think it would be a good idea to
    replace the sysdev with a platform device entirely.  However, would it make
    sense to add a platform device for the early resuming alone and leave the
    sysdev for other purposes?

(4) In a few cases one sysdev is used for many different purposes, including
    late suspend and early resume, and many different drivers bind to it.  This
    is done by the i386 MTRR code and by the ARM s3c24xx platforms.

    Still, as far as the i386 MTRR code is concerned, it only is necessary to
    apply the late suspend and early resume to the boot CPU, since we disable
    the other CPUs before this code is called and we eanble them after it has
    been called using the CPU hotplug.  Thus, it seems that we only need one
    platform device for handling the boot CPU's MTRR late suspend and early
    resume.

    Now, on the s3c24xx platforms one sysdev seems to be used for many
    platform-related operations.  In particular, two or more different sysdev
    drivers having .suspend() and/or .resume() callbacks defined, related to
    different parts of the platform, seem to bind to the same sysdev, which is
    kind of ugly.  It seems to be more correct to have a separate platform
    device defined for each thing that requires to be suspended late or resumed
    early and a dedicated platform driver handling these operations.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
