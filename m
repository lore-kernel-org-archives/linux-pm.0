From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
 =?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28rev=2E_?=
 =?iso-8859-1?q?2=29?=
Date: Wed, 26 Mar 2008 10:40:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261032140.4969-100000__38929.5447887436$1206542760$gmane$org@iolanthe.rowland.org>
References: <200803261524.18300.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803261524.18300.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Mar 2008, Oliver Neukum wrote:

> Am Mittwoch, 26. M=E4rz 2008 15:10:01 schrieb Alan Stern:
> > > > IMO you must always keep the ordering invariant. If a parent return=
s an error
> > > > the PM core must not wake its children.
> > =

> > Don't think of it that way. =A0The PM core doesn't wake anything. =A0It
> > merely notifies drivers that the system sleep is ending, so that the
> > drivers can wake their devices. =A0It's up to the driver to detect
> > whether the parent failed to resume, in which case the driver should
> > take appropriate action.
> =

> How do you propose that every driver should check the power state
> of its parent? Without locking the parent?

It depends entirely on the driver and subsystem; generalizations are =

not possible.  When appropriate, they can copy the scheme used by USB.  =

Or they can make up their own scheme.

> > The situation is no different from what happens when the user tries to =

> > access a mounted USB disk drive after the USB cable has been unplugged.=
 =A0
> > The drivers take care of everything.
> =

> That completely throws away the reason to have a PM core.

Nonsense.

>  We've made
> a guarantee to drivers that they wil not be woken unless their parents are
> awake.

No we haven't.  The guarantee is only that the PM core will call the =

parent's resume method before calling the child's method.  There is no =

guarantee about whether the method succeeds or the parent is awake.

Remember, the whole purpose of this is to let drivers know when the =

system is going to sleep or waking up.  Proper handling of devices is =

up to the drivers, not up to the core.

>  In fact the semantics of the callbacks are defined in a way that
> adding devices to a parent can be enabled. You cannot add children to a
> dead parent.

Depends what you mean.  In some cases it is possible -- i.e., you can
do it and the kernel won't crash, although the new children probably
won't be usable.  In any case it doesn't matter; the PM core doesn't
care whether children are added to a dead parent, only drivers care.

> It's the very reason for this rewrite.

No it isn't.  See Rafael's changelog ocmments; the rewrite is being =

done for completely different reasons.

Alan Stern
