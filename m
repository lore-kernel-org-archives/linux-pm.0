From: Ondrej Zary <linux@rainbow-software.org>
Subject: ehci_hcd causes immediate wakeup from suspend to RAM or
	disk on Asus P4P800-VM
Date: Tue, 27 Apr 2010 15:23:46 +0200
Message-ID: <201004271523.48647.linux__27071.165192365$1272374906$gmane$org@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,
machine with Asus P4P800-VM mainboard wakes up immediately after:
echo mem >/sys/power/state
or even
echo disk >/sys/power/state (only when /sys/power/disk is set to "platform", 
which is the default)

The problem disappears when unloading ehci_hcd module. There are no USB 
devices attached. The problem seems to be something like this:
http://www.mail-archive.com/linux-usb-devel%40lists.sourceforge.net/msg54499.html

/sys/devices/pci0000:00/0000:00:1d.7/power/wakeup is disabled by default

/sys/devices/pci0000:00/0000:00:1d.7/usb1/power/wakeup is enabled by default, 
changing it to disabled fixes the problem

The board has 4 USBPWxx jumpers (USBPW12, USBPW34, USBPW56 and USBPW78) that 
selects 5V or 5VSB as power to the corresponding USB connectors. When they're 
all set to 5VSB, the immediate wakeup does not appear. When any of them is 
set to 5V, it wakes up immediately after entering suspend. I guess that the 
loss of power to any of the ports (5V power is turned off in suspend) is 
detected as some event (overcurrent or device connect?)

"ignore_oc=1" parameter to ehci_hcd modules does not change anything.

-- 
Ondrej Zary
