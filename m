From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file
	to	platform-level?handler
Date: Mon, 24 Nov 2008 14:32:58 -0800
Message-ID: <20081124223258.GB28801@trantor.hsd1.or.comcast.net>
References: <20081124210949.GA28085@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811241627560.6702-100000@iolanthe.rowland.org>
	<20081124220234.GA28421@trantor.hsd1.or.comcast.net>
	<200811242319.14544.rjw@sisk.pl>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811242319.14544.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Nov 24 2008, at 23:19, Rafael J. Wysocki was caught saying:
> > Maybe there is some other way to do this that I don't quite grok?
> > Right now, the i8042 device does not have the can_wakeup flag set
> > so writing either "enabled" or "disabled" leads to -EINVAL.
> 
> For PCI we set the can_wakeup flag during the initialization of devices.
> 
> For some other devices, ACPI BIOS contains information telling us whether
> they are capable of waking the system up and the ACPI code sets that flag for
> them on this basis.
> 
> Does your platform know which devices can wake up?

Yep. i8042, lid, power button, battery state change, WOL. I think 
I can do something similar to what ACPI is doing by trapping the
device registration.

~Deepak

-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
