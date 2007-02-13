From: Pavel Machek <pavel@suse.cz>
Subject: Re: question on freeze and aio
Date: Tue, 13 Feb 2007 11:17:53 +0100
Message-ID: <20070213101753.GC12996@elf.ucw.cz>
References: <1171056576.1484.41.camel@nigel.suspend2.net>
	<Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > can there be running aio requests if all tasks are frozen?
> > =

> > Since tasks are frozen, no new aio requests would be submitted. We do a
> > sync to ssek to complete existing requests; I haven't looked to see
> > whether that would need extending to flush aio as well, but don't think
> > that would be the case. Given everyone else's silence, so far, you might
> > be better to ask the author(s) of the aio code.
> =

> I believe Nigel is basically correct.  However sync will only flush aio =

> for block devices.  Other types of aio will remain active.
> =

> aio callbacks are interrupt-driven and execute in a workqueue (see
> fs/aio.c), and as far as I can tell that workqueue doesn't freeze.  =

> Unless some general facility freezes all workqueues...

If this is so... we need to make that particular workqueue
freezeable. (And we should really make most workqueues freezeable).

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
