From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and
	hibernation operations framework
Date: Sun, 1 Jul 2007 21:28:40 -0700
Message-ID: <200707012128.41742.david-b__27983.018445275$1183356727$gmane$org@pacbell.net>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Saturday 30 June 2007, Rafael J. Wysocki wrote:
>=20
> The patches make the following changes:
> * make ACPI use the new .set_target() method in 'struct pm_ops'
> * add an ACPI helper function for the devices to determine the power st=
ate
> =A0 to put the device into
> * move the definition of 'struct pm_ops' to <include/suspend.h>
> * change the name of 'struct pm_ops' to 'struct platform_suspend_ops' a=
nd
>   modify the names of some related functions and global variables accor=
dingly
> * modify 'struct platform_suspend_ops' so that .prepare() and .finish()=
 don't
>   take arguments (.enter() still takes the state argument, because some
>   platforms don't need to implement the other callbacks)
> * make some functions normally defined in kernel/power/main.c be also d=
efined
>   when CONFIG_PM is unset
> * make suspend_ops be a static variable
> * rework 'struct hibernation_ops' to add the new method analogous to
> =A0 .set_target()
> * rename 'struct hibernation_ops' to 'struct platform_hibernation_ops' =
(in
>   analogy with 'struct platform_suspend_ops')

These look like good cleanups and, in some cases, enhancements.
