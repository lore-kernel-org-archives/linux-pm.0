From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 27 Jul 2006 10:43:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
References: <019501c6b170$93eb6950$4686190c@dsn.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <019501c6b170$93eb6950$4686190c@dsn.sec.samsung.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ??? <ikhwan.lee@samsung.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Jul 2006, ??? wrote:

> Hi,
> =

> It seems that we have a consensus on the obsoleteness of the sysfs
> power/state
> file and dev->power.power_state.event. Could anybody explain why? I have
> recently
> joined this mailing list and I would like to follow up with the technical
> background of
> this agreement.

Here's a quick summary.  Other people might want to contribute additional =

reasons:

	The values appearing in power/state are foolish numbers (0 or 2).  =

	A sane interface would have something more meaningful.

	dpm_runtime_{suspend|resume}() changes the value of
	dev->power.power_state.event, which means that drivers can't
	use the field to store data reliably.

	Proper runtime power management requires drivers to change their
	devices' power states as needed, with no intervention of the PM
	core.  Neither power/state nor power.power_state.event is really
	necessary for this purpose.

	For the most part, user space shouldn't be concerned about runtime
	PM, at least not on the level of individual devices.  In the cases =

	where it does care, there can be device- or system-specific =

	ways of handling it -- like the way DPM handles runtime PM for
	screens.  Userspace _does_ need to be involved in setting runtime =

	PM policy, but that's a separate issue.

	The interface from dpm_runtime_suspend() to device drivers is
	broken.  It calls the drivers' suspend() methods, but that method
	is really meant to inform drivers that the entire system is
	suspending.

	Especially on embedded systems, but potentially everywhere, =

	devices often have more power levels than just ON and SUSPENDED.
	(The most obvious example is PCI with D0, D1, D2, and D3hot, but
	consider also a disk drive that might use ON, STANDBY, and
	SPINDOWN.)  The dpm_runtime_suspend API has no way to describe
	these different power states.

> If the sysfs mechanism is deprecated, the dpm_runtime_suspend() seems to =
be
> the only method for runtime power management. But I think it's difficult =
for
> a user-
> space power manager to use this function because the caller needs to have
> the pointer
> to the device which it wants to control.

Userspace power managers shouldn't use dpm_runtime_suspend() at all, for =

the reasons mentioned above.

> Lastly, shouldn't the dpm_runtime_suspend() move the device from dpm_acti=
ve
> list
> to dpm_off list upon success? This would prevent suspending an
> already-suspended
> device again in the device_suspend() function.

This is a moot point.  dpm_runtime_suspend() shouldn't exist at all, so =

the details of what it does hardly matter.

Alan Stern
