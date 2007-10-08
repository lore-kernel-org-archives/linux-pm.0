From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Documentation for USB power management
Date: Mon, 8 Oct 2007 11:31:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710081127340.3931-100000__22795.8369454884$1191857556$gmane$org@netrider.rowland.org>
References: <200710080840.49451.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710080840.49451.oliver@neukum.org>
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
Cc: linux-pm@lists.linux-foundation.org, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Oct 2007, Oliver Neukum wrote:

> Am Samstag 06 Oktober 2007 schrieb Alan Stern:
> > +It is worth mentioning that many USB drivers don't support
> > +autosuspend. =A0In fact, at the time of this writing (Linux 2.6.23) =
the
> > +only drivers which do support it are the hub driver, kaweth, usblp,
> > +usblcd, usb-skeleton (which doesn't count), and usb-storage. =A0If a
>=20
> Storage no longer does.
> You forgot the asix etherne driver.

I was working with an old -rc tree.  The appropriate changes will be=20
made.

> > +Sometimes a driver needs to make sure that remote wakeup is enabled
> > +during autosuspend. =A0For example, there's not much point
> > +autosuspending a keyboard if the user can't cause the keyboard to do=
 a
> > +remote wakeup by typing on it. =A0If the driver sets
> > +intf->needs_remote_wakeup to 1, the kernel won't autosuspend the
> > +device if remote wakeup isn't available or has been disabled through
> > +the power/wakeup attribute.
>=20
> You should mention that a driver has to make sure that the device is
> awake for this to have immediate effect.

> > +External suspend calls should never be allowed to fail in this way,
> > +only autosuspend calls. =A0The driver can tell them apart by checkin=
g
> > +udev->auto_pm; this flag will be set to 1 for internal PM events
>=20
> This is a bit unclear, as suspend methods are called with interface
> pointers. I think you need to elaborate.

Both good ideas, thank you.

Alan Stern
