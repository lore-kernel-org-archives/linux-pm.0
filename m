From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level	handler
Date: Mon, 24 Nov 2008 14:29:00 -0800
Message-ID: <20081124222900.GA28801@trantor.hsd1.or.comcast.net>
References: <20081124220234.GA28421@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811241705440.6702-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811241705440.6702-100000@iolanthe.rowland.org>
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

On Nov 24 2008, at 17:14, Alan Stern was caught saying:
> How does ACPI go about doing the equivalent thing?  Maybe you can copy 
> that approach.

ACPI hides a lot of the EC magic from us, but it looks like it uses the
platform_notify() and platform_remove_notify() handlers to track what
devices are added to the system. I think I can make use of the same
to set dev->wakeup_capable for the devices I care about, store the
pointers to those devices, and then configure the EC bits as needed
when we suspend by looking at the result of device_may_wakeup().  I  
might not need a callback afterall.

Thanks,
~Deepak


-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
