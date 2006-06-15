From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 11:39:14 +0200
Message-ID: <200606151139.14632.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606150102.53961.rjw@sisk.pl>
	<20060614233233.GA21135@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614233233.GA21135@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 01:32, Pavel Machek wrote:
> Hi!
> =

> > > Actually, no, it is not.
> > > =

> > > It happens to be almost okay for s2ram, but it will mean no messages
> > > for suspend to disk... and that is bad.
> > > =

> > > Console subsystem should be stopped when console device is stopped,
> > > and restarted when console device is restarted.
> > =

> > Well, I don't know.  In ususpend we only use pm_prepare/restore_console=
()
> > during resume and we can live without that at all.
> =

> Linus has examples why console stopping is neccessary (netconsole
> case)... so I do not think we can live without that.
> =

> Cleanest solution would be if console driver simply responded to
> device_suspend() and do all neccessary stuff...

Agreed.

BTW, is there any reason for which the console suspend/resume routines are
not called from device_suspend()?

Rafael
