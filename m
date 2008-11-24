From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to platform-level
 handler
Date: Mon, 24 Nov 2008 15:57:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811241554520.2851-100000@iolanthe.rowland.org>
References: <20081124200122.GA32341@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081124200122.GA32341@trantor.hsd1.or.comcast.net>
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

> 
> 
> Hi,
> 
> On the OLPC XO laptop, we want a way to enable/disable wakeup events for 
> a device from userspace at suspend time depending on the method we are 
> using for suspending. For example, if the system auto-suspends, we want 
> to wake up on input from the PS2 device; if the user shuts the lid, we 
> want to wakeup on lid state change events; if the user presses the power 
> button to suspend, we only want to wakeup on another power button event.
> 
> We have currently exported a set of files via sysfs in 
> /sys/power/wakeup_events as such:
> 
> bash-3.2# ls /sys/power/wakeup_events/
> ac_power  battery_error  battery_state      ps2event
> all       battery_soc    ebook_mode_change  wlan
> 
> Writing a 1 to one of these files will enable that device as a wake up 
> source in the Embedded Controller (EC). Writing a 0 will disable it. See 
> [1] for code. This interface works but I would like to replace it with 
> something that can be pushed upstream.
> 
> Each of the devices we care about already has an entry in the sysfs tree 
> or could have one added and each of these entries has a "power/wakeup" file 
> that according to my reading of the code, can be set to "enabled" or "disabled".
> What we need is a way to tie the enable/disable state to some sort of platform 
> handler so that we do not end up with platform-specific code in each
> driver. What I propose is adding a generic structure that a platform
> can register:
> 
> struct platform_wakeup_ops {
> 	init_wakeup(struct device *dev, int val);
> 	set_wakeup_capable(struct device *dev, int val);
> 	can_wakeup(struct device *dev);
> 	set_wakeup_eanble(struct device *dev, int val);
> 	may_wakeup(struct device *dev);
> };
> 
> wakeup_register_ops(struct platform_wakeup_ops *ops);
> 
> The generic functions in pm_wakeup.h can be modified to call the platform
> level code if such is registered. The platform level code can do whatever
> it wants w/o needing to touch generic code. In our case, we can look at 
> dev->bus->name && dev->busid to determine if we need to change an EC bit. 
> If not, we just do the default behaviour as per pm_wakeup.h. We can
> add __device_init_wakeup() and other "__" functions that can be called
> by platform code that do the default action.
> 
> Thoughts?

Shouldn't these things be decided by the user and not by the kernel's 
platform code?

So what you want is a way for userspace to know and react at the start 
of a suspend, and a way for it to know the cause of the suspend.  Then 
a daemon could be set to notice whenever a suspend is started, and it 
could set all the various wakeup flags however the user wants.

Alan Stern
