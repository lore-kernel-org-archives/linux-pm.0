From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Wed, 23 Feb 2011 12:58:48 +0100
Message-ID: <4D64F678.10309__15779.8196458772$1298462394$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.1102221029100.1968-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102221029100.1968-100000@iolanthe.rowland.org>
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
Cc: "Rafael J. Wysocki" <rjw@suse.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 02/22/2011 04:36 PM, Alan Stern wrote:
> By the way, are you booting with no_console_suspend?  And do you do 
> "echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
> suspending?

Nope.

> What about if you leave async enabled for all the USB devices _except_ 
> usb[1-N]?

Ok, so now I have:
/sys/bus/usb/devices/usb1/power/async:disabled
/sys/bus/usb/devices/usb2/power/async:disabled
/sys/bus/usb/devices/usb3/power/async:disabled
/sys/bus/usb/devices/usb4/power/async:disabled
/sys/bus/usb/devices/usb5/power/async:disabled
/sys/bus/usb/devices/usb6/power/async:disabled
/sys/bus/usb/devices/usb7/power/async:disabled
/sys/bus/usb/devices/usb8/power/async:disabled
/sys/bus/usb/devices/1-0:1.0/power/async:enabled
/sys/bus/usb/devices/2-0:1.0/power/async:enabled
/sys/bus/usb/devices/2-6/power/async:enabled
/sys/bus/usb/devices/2-6:1.0/power/async:enabled
/sys/bus/usb/devices/2-6:1.1/power/async:enabled
/sys/bus/usb/devices/3-0:1.0/power/async:enabled
/sys/bus/usb/devices/4-0:1.0/power/async:enabled
/sys/bus/usb/devices/4-2/power/async:enabled
/sys/bus/usb/devices/4-2.1/power/async:enabled
/sys/bus/usb/devices/4-2:1.0/power/async:enabled
/sys/bus/usb/devices/4-2.1:1.0/power/async:enabled
/sys/bus/usb/devices/4-2.1:1.1/power/async:enabled
/sys/bus/usb/devices/4-2.2/power/async:enabled
/sys/bus/usb/devices/4-2.2:1.0/power/async:enabled
/sys/bus/usb/devices/5-0:1.0/power/async:enabled
/sys/bus/usb/devices/6-0:1.0/power/async:enabled
/sys/bus/usb/devices/7-0:1.0/power/async:enabled
/sys/bus/usb/devices/8-0:1.0/power/async:enabled

Let's see.

regards,
-- 
js
