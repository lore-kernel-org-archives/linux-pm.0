From: Ikhwan Lee <ikhwan.lee@samsung.com>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 17 Aug 2006 11:41:41 +0900
Message-ID: <006a01c6c1a6$ac74b760$4686190c@dsn.sec.samsung.com>
References: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
	<200607270853.54674.david-b@pacbell.net>
	<018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
	<200608161209.07004.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Thanks for your comments.

> > Now I understand that the drivers are responsible for making runtime
power
> > management decisions for individual devices. But there are cases that a
> > device driver does not have enough information to make the most
effective
> > decision. In such a case, we may want to employ a high level power
manager
> > to make decisions for them.
>
> And that will need some sort of programming interface.  But those will
> be providing domain-specific hints and information, not describing the
> system-wide power state transitions which are being addressed by current
> bus/class/driver suspend()/resume() methods.
>
> Plus, not all drivers will have those cases and thus need new APIs.
> Best to let just those drivers pay the costs of such interfaces, and
> not try to inflict them universally.  :)

Basically agree. Some drivers actually allow applications to manage the
device power directly. (usually through ioctl) However, for a
battery-operated embedded system, we would prefer to have all the drivers
provide such interfaces.

> > This is a common case for state-of-the-art mobile handsets such as a DMB
> > phone. As a different example, a system-level power manager may want to
put
> > the codec into a low quality (thus low power) mode regarding the battery
> > status. Certainly, this kind of decision cannot be made by the driver.
>
> You've got a bit of chicken-vs-egg going on there, in that you're assuming
> the answer is a system/global manager that knows about the codec!!  While
in
> fact there can easily be other solutions.  Examples include notifying the
> user and letting _them_ choose which module to put into lowpower/off mode
> (maybe the WLAN instead, since the codec is more essential just now), or
> a general system "cut power usage" notification, which that driver will
> interpret in that way.
>
> But I certainly agree that there are cases where "higher level" inputs
> are needed to help drivers manage power usage effectively.  I consider
> most of those to be domain-specific APIs, outside the specific scope
> of the PM framework.  (But clearly needing to be pm-aware designs.)

Maybe it is the PowerOp's scope?

> > and interdependencies
> > among devices (the device model perfectly suits for this) while device
> > drivers provide necessary APIs for safe power state transitions.
>
> The device model has glitches in terms of not handling power/voltage
> domains at all, or devices that sit on multiple busses.  One example
> I've seen quite often is an external multifunction chip with a highspeed
> serial bus for a codec data link, and a separate serial bus (I2C, SPI,
etc)
> for its control link and lowspeed non-codec data.  Plus, clusters of
> interrelated devices aren't handled that well, even if you assume that
> clock and power domain APIs will handle those issues; my pet example
> being USB-OTG modules, which started out involving five controllers
> (host, peripheral, and OTG for USB; plus I2c and external PHY) before
> chip vendors started to use more integrated design approaches.
>
> Given the wide variety of possible device power states, I really think
> it's best to try to keep the driver model out of that business.

OK, maybe a power/voltage domain framework will do it, and I hope that it
would not be as complex as the device model.

> > I have been following the thread. I especially like the section on
runtime
> > power management, with lots of examples. I am actually working on some
of
> > them, and my claim is that (as stated above) we may need to involve some
> > kind of public power state updating in a system-wide way.
>
> I can't disagree with that at all.  :)
>
> One of my concerns is how to factor that stuff well -- "architect" it -- =

so
> that the approach is broadly applicable.  A factoring that works well at
> the SOC level may not work as well at the board level; working well on one
> family of SOCs doesn't mean it works well on others.

This is a real problem. I sometimes even want to distinguish on-chip devices
from on-board devices.

> I feel comfortable saying we need a power/voltage domain framework, and an
> extensible framework for system-wide operating (and non-operating sleep)
> states.  The rest looks to me like stuff that would best be worked out
> over time, while integrating those two things and fixing the inevitable
> botches in the initial designs, as applied to current hardware.

Can't agree more. =3D) Having a power/voltage domain framework, the clock
framework, and a framework for system-wide operating states (maybe PowerOp),
we can say that we have a complete power management solution for embedded
systems.

Ikhwan
