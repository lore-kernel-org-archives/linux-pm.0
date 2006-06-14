From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 01:02:53 +0200
Message-ID: <200606150102.53961.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614224436.GF7751@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 00:44, Pavel Machek wrote:
> On St 14-06-06 15:38:39, Linus Torvalds wrote:
> > =

> > =

> > On Wed, 14 Jun 2006, Peter Jones wrote:
> > =

> > > On Thu, 2006-06-15 at 00:12 +0200, Pavel Machek wrote:
> > > > =

> > > > if (network_driver_suspended)
> > > > 	drop_message_on_the_floor() =

> > > =

> > > I think we have the same problems with e.g. fbcon .
> > =

> > We have the same problem with EVERY SINGLE CONSOLE DEVICE, and we don't =

> > always even know which chip is the device (ie the VGA console simply =

> > doesn't even care).
> > =

> > Which is why my solution really is the right one.
> =

> Actually, no, it is not.
> =

> It happens to be almost okay for s2ram, but it will mean no messages
> for suspend to disk... and that is bad.
> =

> Console subsystem should be stopped when console device is stopped,
> and restarted when console device is restarted.

Well, I don't know.  In ususpend we only use pm_prepare/restore_console()
during resume and we can live without that at all.

Greetings,
Rafael
