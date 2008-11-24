From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to platform-level
 handler
Date: Mon, 24 Nov 2008 17:14:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811241705440.6702-100000@iolanthe.rowland.org>
References: <20081124220234.GA28421@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081124220234.GA28421@trantor.hsd1.or.comcast.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Nov 2008, Deepak Saxena wrote:

> Because some of the drivers we are using are generic and I do not want
> to put a bunch of platform-specific code in there.  Let's look at the PS2 
> driver for example. We use the generic i8042 driver and I would like
> to be able to use /sys/bus/platform/devices/i8042/power/wakeup to set
> wakeup enable on mouse or keyboard input so I need a way to trigger 
> an EC mask update on a write to that file. 
> 
> Maybe there is some other way to do this that I don't quite grok?
> Right now, the i8042 device does not have the can_wakeup flag set
> so writing either "enabled" or "disabled" leads to -EINVAL.

I see.  IMO, in your example there's no way around modifying the i8042
driver.  That is, changes should be made at the driver level instead of
to the generic PM core.

However exactly what form these changes should take isn't clear.  
Perhaps something like your platform_wakeup_ops should become part of
the platform bus structure, directly accessible by any platform device
driver.  You'd only need to implement an enable_wakeup and a 
disable_wakeup routine.

How does ACPI go about doing the equivalent thing?  Maybe you can copy 
that approach.

Alan Stern
