From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Wed, 16 Aug 2006 11:37:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0608161127120.7924-100000@iolanthe.rowland.org>
References: <018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <ikhwan.lee@samsung.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Aug 2006, Ikhwan Lee wrote:

> Now I understand that the drivers are responsible for making runtime power
> management decisions for individual devices. But there are cases that a
> device driver does not have enough information to make the most effective
> decision. In such a case, we may want to employ a high level power manager
> to make decisions for them.

Yes, these managers are sometimes needed.

> Suppose we have a SoC with an on-chip multimedia codec. The codec can eit=
her
> be clock-gated or power-gated, and it shares its power domain with a
> neighboring IP, say a 3D engine. Clock gating can be done by the driver
> since the clock can be controlled separately. However, the codec driver c=
an
> never perform power-gating since it does not know if the 3D engine is act=
ive
> or not. We would prefer a centralized device power manager in this case.
> This is a common case for state-of-the-art mobile handsets such as a DMB
> phone.

In which case a centralized power manager would handle things.  But
there's no reason that power manager couldn't be part of the kernel's
infrastructure.  The individual device drivers would tell it when they
need power, and it would gate off the power when nobody needs any.  In
this case no userspace API is required.  It's merely a platform-level
design issue.

> As a different example, a system-level power manager may want to put
> the codec into a low quality (thus low power) mode regarding the battery
> status. Certainly, this kind of decision cannot be made by the driver.
> =

> IMO, having support for such use cases in the PM core and exporting
> necessary driver APIs would not be a bad idea. Centralized device power
> manager can keep track of the system power states and interdependencies
> among devices (the device model perfectly suits for this) while device
> drivers provide necessary APIs for safe power state transitions.

Unfortunately it's far from clear how or when to do this.  Which drivers =

need to export such an API?  What form should the API take?  Remember, =

each driver will support its own specialized set of power states.  Putting =

such things in the PM core makes sense only if they can all be constrained =

to follow a common pattern.

> I have been following the thread. I especially like the section on runtime
> power management, with lots of examples. I am actually working on some of
> them, and my claim is that (as stated above) we may need to involve some
> kind of public power state updating in a system-wide way.

It's easy to say "some kind of public power state updating".  The hard =

part comes when you have to specify exactly _what_ kind.  That's when the =

flame wars start.

Alan Stern
