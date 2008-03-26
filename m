From: Oliver Neukum <oliver@neukum.org>
Subject: Re:
	=?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
	=?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28?=
	=?iso-8859-1?q?rev=2E_2=29?=
Date: Wed, 26 Mar 2008 15:24:17 +0100
Message-ID: <200803261524.18300.oliver__10464.6718049937$1206541778$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0803261003540.4755-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803261003540.4755-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 26. M=E4rz 2008 15:10:01 schrieb Alan Stern:
> > > IMO you must always keep the ordering invariant. If a parent returns =
an error
> > > the PM core must not wake its children.
> =

> Don't think of it that way. =A0The PM core doesn't wake anything. =A0It
> merely notifies drivers that the system sleep is ending, so that the
> drivers can wake their devices. =A0It's up to the driver to detect
> whether the parent failed to resume, in which case the driver should
> take appropriate action.

How do you propose that every driver should check the power state
of its parent? Without locking the parent?

> The situation is no different from what happens when the user tries to =

> access a mounted USB disk drive after the USB cable has been unplugged. =
=A0
> The drivers take care of everything.

That completely throws away the reason to have a PM core. We've made
a guarantee to drivers that they wil not be woken unless their parents are
awake. In fact the semantics of the callbacks are defined in a way that
adding devices to a parent can be enabled. You cannot add children to a
dead parent. It's the very reason for this rewrite.

	Regards
		Oliver
