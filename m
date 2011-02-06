From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM: Do not create wakeup sysfs files for
	devices that cannot wake up (v3)
Date: Sun, 6 Feb 2011 21:06:29 +0100
Message-ID: <201102062106.29712.rjw__29860.9779020355$1297023010$gmane$org@sisk.pl>
References: <201102061519.11360.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102061519.11360.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The second patch changes the PM core to only create wakeup sysfs files for
devices that are wakeup-capable.  The first one modifies drivers/usb/core/hub.c
so that it doesn't call device_set_wakeup_capable() under a spinlock.

They contain changes addressing the latest comments.

Thanks,
Rafael
