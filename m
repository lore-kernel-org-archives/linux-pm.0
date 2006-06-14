From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 00:44:37 +0200
Message-ID: <20060614224436.GF7751@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On St 14-06-06 15:38:39, Linus Torvalds wrote:
> =

> =

> On Wed, 14 Jun 2006, Peter Jones wrote:
> =

> > On Thu, 2006-06-15 at 00:12 +0200, Pavel Machek wrote:
> > > =

> > > if (network_driver_suspended)
> > > 	drop_message_on_the_floor() =

> > =

> > I think we have the same problems with e.g. fbcon .
> =

> We have the same problem with EVERY SINGLE CONSOLE DEVICE, and we don't =

> always even know which chip is the device (ie the VGA console simply =

> doesn't even care).
> =

> Which is why my solution really is the right one.

Actually, no, it is not.

It happens to be almost okay for s2ram, but it will mean no messages
for suspend to disk... and that is bad.

Console subsystem should be stopped when console device is stopped,
and restarted when console device is restarted.

If that is not practical, it should be stopped when all the other
devices are stopped, and resumed when all the other devices are
resumed. Currently, pm_restore_console is not called when devices are
resumed before writing to disk (in s2disk case).

pm_prepare/restore_console would need to be split to two function to
DTRT with s2disk.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
