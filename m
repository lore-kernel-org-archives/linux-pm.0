From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level	handler
Date: Mon, 24 Nov 2008 14:02:34 -0800
Message-ID: <20081124220234.GA28421@trantor.hsd1.or.comcast.net>
References: <20081124210949.GA28085@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811241627560.6702-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811241627560.6702-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Nov 24 2008, at 16:34, Alan Stern was caught saying:
> On Mon, 24 Nov 2008, Deepak Saxena wrote:
> 
> > Ack. This is what we are already doing.  The decision on whether or 
> > not a device should wake us up from suspend is handle via OHM on the 
> > XO and we set the OLPC-specific flags in /sys/power/wakeup_events as 
> > there is no standard way to specify wakeup events from userland.
> > 
> > My proposal uses the existing sysfs interface to connect into a platform 
> > level handler that can set the appropriate low-level HW bits. The
> > decision of whether or not to enable the device's wakeup capability
> > would still be left to user space. 
> 
> Then I must have misunderstood the point of your earlier message.  Are
> you saying that the real problem is to tie the existing
> /sys/devices/.../power/wakeup flags into your platform handler?

ACK.

> The sources you listed (ac_power, battery_state, and so on) are all 
> pretty much platform-level entities to begin with.  Their drivers must 
> already contain or communicate with a fair amount of platform-level 
> code.  So why should there be any trouble about adding a new 
> communication channel for wakeup settings?

Because some of the drivers we are using are generic and I do not want
to put a bunch of platform-specific code in there.  Let's look at the PS2 
driver for example. We use the generic i8042 driver and I would like
to be able to use /sys/bus/platform/devices/i8042/power/wakeup to set
wakeup enable on mouse or keyboard input so I need a way to trigger 
an EC mask update on a write to that file. 

Maybe there is some other way to do this that I don't quite grok?
Right now, the i8042 device does not have the can_wakeup flag set
so writing either "enabled" or "disabled" leads to -EINVAL.

~Deepak

-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
