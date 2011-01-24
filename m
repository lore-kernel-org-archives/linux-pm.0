From: Thomas Renninger <trenn@suse.de>
Subject: User tool for configuring wake-up devices
Date: Mon, 24 Jan 2011 15:09:47 +0100
Message-ID: <201101241509.48032.trenn__39960.9632826925$1295878262$gmane$org@suse.de>
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
To: David Brownell <david-b@pacbell.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org
Cc: oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

Hi,

some time ago we talked about a userspace tool
which can enable specific devices to be able to
wake the machine up from suspend.

While Rafael solved that for network directly
in the driver iirc (should work via ethtool now),
there wasn't any outcome for
other devices (usb, key, mouse, generic ACPI implementation
reading out device's sysfs path...) to activate them as
wakeup devices in a userfriendly way?

Oliver just asked me for a tool to e.g. configure
and enable usb or other devices as wake-up devices.

I quickly googled and found:
  - acpitools (http://sourceforge.net/projects/acpitool)
    rather old, I doubt it does any sysfs reads to find
    out which devices could be configured and of what
    type they are?

  - acpi-wakeup
    even less feature rich...

In sysfs is this supposed to work via:
/sys/devices/.../power/wakeup_active
now?

How are users supposed to enable devices for suspend wake up?
Are there any tools already which are worth packaging
or is such a tool waiting for implementation?

Thanks,

   Thomas
