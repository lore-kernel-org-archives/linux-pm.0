From: Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: BUG, regression. usb-serial adapter broken by PM?
Date: Mon, 29 Nov 2010 20:52:14 -0500
Message-ID: <4CF458CE.2050603__30245.2516895302$1291131683$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <jhovold@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Daniel Sangorrin <daniel.sangorrin@gmail.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Recently, my usb-serial converter has become unusable. Attempts to open
the device always fail with:
open("/dev/ttyUSB0", O_RDONLY)          = -1 EAGAIN (Resource temporarily unavailable)

The device is a:
ID 0c52:2101 Sealevel Systems, Inc. Serial Converter
and uses the ftdi_sio driver.

I've bisected this problem to
commit 1bfee5bc86fdaecc912e06080583eddab7263df2
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Sat Sep 25 23:35:00 2010 +0200

    PM / Runtime: Merge synchronous and async runtime routines

I have other usb-serial converters that use other drivers and that are
unaffected. I have noticed the problem on a x86_64 machine (.config
here: http://pastebin.ca/2006414) and can reproduce it in kvm (with usb
passthrough, .config here: http://pastebin.ca/2006416).

I'll be glad to provide more info or try patches.

Thanks,
-Ben
