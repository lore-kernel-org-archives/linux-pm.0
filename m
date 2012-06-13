From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: add NO_D3_DURING_SLEEP flag and revert
 151b61284776be2
Date: Wed, 13 Jun 2012 13:03:10 -0700
Message-ID: <20120613200310.GA11110@kroah.com>
References: <201206131122.36198.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1206131117260.1401-100000@iolanthe.rowland.org>
	<20120613152701.GA28116@kroah.com> <201206132204.43622.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201206132204.43622.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrey Rahmatullin <wrar@wrar.name>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2012 at 10:04:43PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 13, 2012, Greg KH wrote:
> > On Wed, Jun 13, 2012 at 11:20:19AM -0400, Alan Stern wrote:
> > > This patch (as1558) fixes a problem affecting several ASUS computer=
s:
> > > The machine crashes or corrupts memory when going into suspend if t=
he
> > > ehci-hcd driver is bound to any controllers.  Users have been force=
d
> > > to unbind or unload ehci-hcd before putting their systems to sleep.
> > >=20
> > > After extensive testing, it was determined that the machines don't
> > > like going into suspend when any EHCI controllers are in the PCI D3
> > > power state.  Presumably this is a firmware bug, but there's nothin=
g
> > > we can do about it except to avoid putting the controllers in D3
> > > during system sleep.
> > >=20
> > > The patch adds a new flag to indicate whether the problem is presen=
t,
> > > and avoids changing the controller's power state if the flag is set=
.
> > > Runtime suspend is unaffected; this matters only for system suspend=
.
> > > However as a side effect, the controller will not respond to remote
> > > wakeup requests while the system is asleep.  Hence USB wakeup is no=
t
> > > functional -- but of course, this is already true in the current st=
ate
> > > of affairs.
> > >=20
> > > A similar patch has already been applied as commit
> > > 151b61284776be2d6f02d48c23c3625678960b97 (USB: EHCI: fix crash duri=
ng
> > > suspend on ASUS computers).  The patch supersedes that one and reve=
rts
> > > it.  There are two differences:
> > >=20
> > > 	The old patch added the flag at the USB level; this patch
> > > 	adds it at the PCI level.
> > >=20
> > > 	The old patch applied to all chipsets with the same vendor,
> > > 	subsystem vendor, and product IDs; this patch makes an
> > > 	exception for a known-good system (based on DMI information).
> > >=20
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Tested-by: D=E2niel Fraga <fragabr@gmail.com>
> > > Tested-by: Andrey Rahmatullin <wrar@wrar.name>
> > > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> > > CC: Greg KH <greg@kroah.com>
> > > CC: <stable@vger.kernel.org>
> > >=20
> > > ---
> > >=20
> > > Greg, do you mind if this goes in through Rafael's tree?
> >=20
> > Not at all, but I can also take it.
> >=20
> > Rafael, if you want to take it, please add:
> >=20
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >=20
> > to it, or let me know, and I can take this through my tree.
>=20
> Please take it, if that's not a problem, I don't have any other
> patches for 3.5 pending.  And please add:
>=20
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

Ok, I'll go queue it up right now.

greg k-h
