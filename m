From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file
	to	platform-level?handler
Date: Tue, 25 Nov 2008 11:19:29 -0800
Message-ID: <20081125191929.GA4692@trantor.hsd1.or.comcast.net>
References: <20081125180744.GA4184@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811251351360.2457-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811251351360.2457-100000@iolanthe.rowland.org>
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

On Nov 25 2008, at 13:57, Alan Stern was caught saying:
> On Tue, 25 Nov 2008, Deepak Saxena wrote:
> 
> > > > Just thought of something. Not all the devices we can wakeup on are
> > > > platform devices. The WLAN specifically is an on-board USB device with
> > > > a sideband wakeup signal connected to the EC. So instead I'll make the
> > > > set_wakeup() ptr a member of struct device and call it in device_suspend().
> > > 
> > > No, don't do that.  If the device has a sideband wakeup signal then the 
> > > device's driver should be aware of that signal.  So the driver should 
> > > be modified, not the device core.  The driver can ask the platform code 
> > > to do whatever is necessary.
> > 
> > What is the method to connect between the driver's WOL code and the platform
> > code in this situation? 
> 
> It depends on the hardware and the driver.  Is this a specialized sort 
> of USB WLAN device with features specific to the XO?  How is the 
> sideband wakeup signal implemented?  Does the driver know that it is 
> running on an XO?  Does the driver know that this sideband signal 
> exists?

The sideband signal is a gpio. The driver knows that the GPIO exists,
but it does not know that it anything about it is routed on the board
IMHO it should not.

> The easiest answer is for the driver to call directly into the platform code.

Agreed, and there are several ways to do this: 

One is to do wrap code around #ifdef and if(machine_is_olpc()) to make
a call to an OLPC-specific call.

The other is to add a generic platform wakeup hook mechanism such as
either my original proposal or adding a set_wakeup() to struct device
itself. Another option is to have a single platform_set_wakeup()
pointer similar to the platform_notify() and platform_notify_remove().

Note that in the OLPC tree we have some #ifdef OLPC in the wifi driver
but those are not upstream and I'm going to work on removing them. I
would prefer not to add anymore.

~Deepak


-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
