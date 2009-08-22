From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: How to wakup system from standby via USB keyboard
Date: Sat, 22 Aug 2009 10:08:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908221005140.5241-100000@netrider.rowland.org>
References: <1250914412.29439.108.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1250914412.29439.108.camel@falcon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Aug 2009, Wu Zhangjin wrote:

> > I think the interface you're looking for is
> > 
> > 	/sys/bus/usb/devices/usbN/../power/wakeup
> > 
> > where N is the USB bus number.  This file defaults to "disabled"; if
> > you write "enabled" to it then the USB host controller will be enabled
> > as a wakeup source.  This should work even without ACPI; it uses the
> > PCI PME mechanism.
> > 
> 
> I checked the /sys/bus/usb.../wakeup interfaces, seems the
> usbN/power/wakeup interfaces are enabled by default in my machine, but
> the usbN/N-X:Y/power/wakeup is not available. so, I can not wakeup the
> system via any USB devices.
> 
> Here is the output:
> 
> $ find /sys/bus/usb/devices/usb1/ -name "wakeup" -exec echo {} \; -exec
> cat '{}' \;
> /sys/bus/usb/devices/usb1/power/wakeup
> enabled
...

You did not read what I wrote.

You shouldn't look at: /sys/bus/usb/devices/usb1/power/wakeup.  
You should look at:    /sys/bus/usb/devices/usb1/../power/wakeup.

The N-X:Y/power/wakeup interfaces don't matter; the kernel doesn't 
use them.

Alan Stern
