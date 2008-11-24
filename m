From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level	handler
Date: Mon, 24 Nov 2008 13:09:49 -0800
Message-ID: <20081124210949.GA28085@trantor.hsd1.or.comcast.net>
References: <20081124200122.GA32341@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811241554520.2851-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811241554520.2851-100000@iolanthe.rowland.org>
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

On Nov 24 2008, at 15:57, Alan Stern was caught saying:
> Shouldn't these things be decided by the user and not by the kernel's 
> platform code?
> 
> So what you want is a way for userspace to know and react at the start 
> of a suspend, and a way for it to know the cause of the suspend.  Then 
> a daemon could be set to notice whenever a suspend is started, and it 
> could set all the various wakeup flags however the user wants.
> 

Ack. This is what we are already doing.  The decision on whether or 
not a device should wake us up from suspend is handle via OHM on the 
XO and we set the OLPC-specific flags in /sys/power/wakeup_events as 
there is no standard way to specify wakeup events from userland.

My proposal uses the existing sysfs interface to connect into a platform 
level handler that can set the appropriate low-level HW bits. The
decision of whether or not to enable the device's wakeup capability
would still be left to user space. 

~Deepak

-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
