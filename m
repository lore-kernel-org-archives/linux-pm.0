From: Deepak Saxena <dsaxena@plexity.net>
Subject: [RFC] Tying sysfs "wakeup" file to platform-level handler
Date: Mon, 24 Nov 2008 12:01:22 -0800
Message-ID: <20081124200122.GA32341@trantor.hsd1.or.comcast.net>
Reply-To: dsaxena@plexity.net
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
Cc: Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org



Hi,

On the OLPC XO laptop, we want a way to enable/disable wakeup events for 
a device from userspace at suspend time depending on the method we are 
using for suspending. For example, if the system auto-suspends, we want 
to wake up on input from the PS2 device; if the user shuts the lid, we 
want to wakeup on lid state change events; if the user presses the power 
button to suspend, we only want to wakeup on another power button event.

We have currently exported a set of files via sysfs in 
/sys/power/wakeup_events as such:

bash-3.2# ls /sys/power/wakeup_events/
ac_power  battery_error  battery_state      ps2event
all       battery_soc    ebook_mode_change  wlan

Writing a 1 to one of these files will enable that device as a wake up 
source in the Embedded Controller (EC). Writing a 0 will disable it. See 
[1] for code. This interface works but I would like to replace it with 
something that can be pushed upstream.

Each of the devices we care about already has an entry in the sysfs tree 
or could have one added and each of these entries has a "power/wakeup" file 
that according to my reading of the code, can be set to "enabled" or "disabled".
What we need is a way to tie the enable/disable state to some sort of platform 
handler so that we do not end up with platform-specific code in each
driver. What I propose is adding a generic structure that a platform
can register:

struct platform_wakeup_ops {
	init_wakeup(struct device *dev, int val);
	set_wakeup_capable(struct device *dev, int val);
	can_wakeup(struct device *dev);
	set_wakeup_eanble(struct device *dev, int val);
	may_wakeup(struct device *dev);
};

wakeup_register_ops(struct platform_wakeup_ops *ops);

The generic functions in pm_wakeup.h can be modified to call the platform
level code if such is registered. The platform level code can do whatever
it wants w/o needing to touch generic code. In our case, we can look at 
dev->bus->name && dev->busid to determine if we need to change an EC bit. 
If not, we just do the default behaviour as per pm_wakeup.h. We can
add __device_init_wakeup() and other "__" functions that can be called
by platform code that do the default action.

Thoughts?

~Deepak
	
[1] http://dev.laptop.org/git?p=olpc-2.6;a=blob;f=arch/x86/kernel/olpc-pm.c;h=3f189bd96cf71180388927e5dcf13638879bedf0;hb=8894c7ce0e33d87ca1f34405fb2431f3a506ab93#l732


-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
