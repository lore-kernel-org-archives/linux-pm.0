From: David Brownell <david-b@pacbell.net>
Subject: Removing dev.power.power_state (WAS: Feature Removals
	for 2.6.25)
Date: Thu, 31 Jan 2008 21:28:09 -0800
Message-ID: <200801312128.10700.david-b__48854.1164239452$1201844040$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Harvey.Harrison@gmail.com
List-Id: linux-pm@vger.kernel.org

Quoth Harvey Harrison:

> Ping?
> What:	dev->power.power_state
> When:	July 2007
> Why:	Broken design for runtime control over driver power states, confusing
> 	driver-internal runtime power management with:  mechanisms to support
> 	system-wide sleep state transitions; event codes that distinguish
> 	different phases of swsusp "sleep" transitions; and userspace policy
> 	inputs.  This framework was never widely used, and most attempts to
> 	use it were broken.  Drivers should instead be exposing domain-specific
> 	interfaces either to kernel or to userspace.
> Who:	Pavel Machek <pavel@suse.cz>

A lot of the infrastructure using that has already been deleted, and
there are some incremental improvements pending for 2.6.25:

 - drivers/input/touchscreen/ads7846.c ... patch fixing this
   should be in either MM or the input queue

 - Documentation/power/devices.txt ... patch fixing this is
   in the suspend tree, due to merge RSN

 - drivers/spi/spi.c ... patch fixing this is in MM, due to
   merge with other SPI patches

 - drivers/pcmcia/ds.c ... at least I *think* that patch got sent

But there are still quite a few users left, and a new one was (sigh)
recently added.

 - drivers/rtc/rtc-sa1100.c ... new usage, merged last week

 - drivers/usb/... has various users, HCDs look easy enough to fix but
   the other bits will take more thought

 - drivers/ata/... has some too

 - drivers/ide/ppc/pmac.c

 - drivers/spi/... some controller drivers use this (look easy to fix)

 - drivers/scsi/mesh.c

 - drivers/input/serio/... has a few users

 - ... more ...

I'll probably send in a few more patches for easy stuff in areas
that I touch semi-frequently, but other folk should fix ATA, IDE,
SCSI, SERIO, and so forth.  It'd be good if Alan would help fix
the USB stuff too.  I'm not sure what Pavel's doing there...

- Dave
