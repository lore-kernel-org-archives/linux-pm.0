From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file
	to	platform-level?handler
Date: Mon, 24 Nov 2008 19:26:06 -0800
Message-ID: <20081125032606.GA30655@trantor.hsd1.or.comcast.net>
References: <20081124223258.GB28801@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811241802350.6702-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811241802350.6702-100000@iolanthe.rowland.org>
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

On Nov 24 2008, at 18:08, Alan Stern was caught saying:
> > Yep. i8042, lid, power button, battery state change, WOL. I think 
> > I can do something similar to what ACPI is doing by trapping the
> > device registration.
> 
> ACPI may not be such a good model after all.  It's very table-driven, 
> with its own little interpreter (or not so little!), whereas most 
> platforms have a pretty good idea beforehand of what devices can exist, 
> and they are described as static data.  Right?

Correct. Most embedded platforms are fairly static and don't need
the complexity of ACPI.

> So the platform code could initialize the "can_wakeup" setting when it
> first detects and registers the device.  And you could add a
> "set_wakeup" function pointer to struct platform_device, which the
> bus-level suspend and resume routines would invoke to enable or disable
> remote wakeup, as appropriate.  In the static structures these function 
> pointers would point to routines that set or clear the appropriate bits 
> in your Embedded Controller.
> 
> I think this is the right way to go...

This sounds good. I think I can get away with doing this w/o having to
touch shared drivers such as i8042.

~Deepak

-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
