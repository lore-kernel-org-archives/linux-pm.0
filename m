From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 14 Jun 2006 21:50:17 -0400
Message-ID: <20060615015017.GD4823@neo.rr.com>
References: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
	<20060615003926.GA11083@neo.rr.com>
	<20060615004052.GA19545@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060615004052.GA19545@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 14, 2006 at 05:40:52PM -0700, Greg KH wrote:
> On Wed, Jun 14, 2006 at 08:39:26PM -0400, Adam Belay wrote:
> > On Wed, Jun 14, 2006 at 03:37:51PM -0700, Linus Torvalds wrote:
> > > And btw, the reason it didn't resume originally was because _we_ did =

> > > things wrong. The PCI command word mustn't be writen before the rest =
of =

> > > the config space has been restored (one of the things I used my debug=
ging =

> > > patches for, until I noticed that -mm had the same fix independently,=
 so =

> > > that's the one that is merged right now ;)
> > =

> > I was hoping to see a more complete fix merged.  This patch still write=
s to a
> > large number of read-only registers, touches BIST (which can be dangero=
us on
> > some hardware), and isn't careful about the initial state of the PCI co=
mmand
> > word.
> > =

> > I attempted to rework pci_save/restore_state() a couple weeks ago:
> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114949711413176&w=3D2
> > =

> > Any comments would be appreciated.
> =

> Your patches are still in my queue, so don't worry, they aren't being
> ignored (the other restore patch had been in my tree, and in -mm for a
> long time, and deserved to be merged already.)

Thanks, I appreciate you keeping them in mind.

> In other email threads, the idea came up that we should probably be
> restoring more than just the "basic" configuration.  PCI-E and PCI-X 2.0
> devices have a much bigger config space, and there's the "new
> capabilities list" that we should also probably restore in the proper
> manner if present.

Yes, I think we currently only restore MSI.  I'll look into adding support
for other capabilities that might need it.

Regards,
Adam
