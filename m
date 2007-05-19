From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [4/5] 2.6.22-rc2: known regressions
Date: Sun, 20 May 2007 00:06:23 +0200
Message-ID: <464F74DF.6030003__37460.4568620727$1179612494$gmane$org@googlemail.com>
References: <464F6DC9.80805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F6DC9.80805@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "art@usfltd.com" <art@usfltd.com>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Suspend

Subject    : STD fails with pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x160 [usbcore]() returns -16
References : http://lkml.org/lkml/2007/5/19/66
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
Status     : Unknown

Subject    : 2.6.22-rc1 suspend to RAM problem
References : http://permalink.gmane.org/gmane.linux.power-management.general/5819
Submitter  : Marcus Better <marcus@better.se>
Status     : caused by fw-ohci module



Timers/NOHZ

Subject    : 2.6.21-git4 BUG: soft lockup detected on CPU#1! 
References : http://lkml.org/lkml/2007/5/2/511
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : problem is being debugged



USB

Subject    : usb hotplug/udev cannot correctly register usb/scanners
References : http://lkml.org/lkml/2007/5/15/205
Submitter  : art@usfltd.com <art@usfltd.com>
Status     : Unknown



Regards,
Michal

--
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
